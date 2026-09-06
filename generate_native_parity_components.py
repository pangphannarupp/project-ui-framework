#!/usr/bin/env python3
import os
import re

WEB_DIR = "web/ui-framework/src/components"
ANDROID_DIR = "android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/components"
IOS_DIR = "ios/ui-framework-sample/UIFramework/Sources/UIFramework"

def get_core_name(filename):
    base = os.path.splitext(filename)[0]
    if base.startswith("Biz"):
        return base[3:]
    if base.startswith("PP"):
        return base[2:]
    return base

def parse_vue_component(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    # Extract template
    tmpl_m = re.search(r"<template>([\s\S]*?)</template>", content)
    template = tmpl_m.group(1) if tmpl_m else ""

    # Extract script
    script_m = re.search(r"<script[\s\S]*?>([\s\S]*?)</script>", content)
    script = script_m.group(1) if script_m else ""

    # Extract style
    style_m = re.search(r"<style[\s\S]*?>([\s\S]*?)</style>", content)
    style = style_m.group(1) if style_m else ""

    # Extract props
    props = []
    # TS defineProps<{ ... }>
    ts_m = re.search(r"defineProps<\s*\{([\s\S]*?)\}\s*>", script)
    if ts_m:
        raw_text = ts_m.group(1)
        raw_text = re.sub(r'/\*[\s\S]*?\*/', '', raw_text)
        raw_text = re.sub(r'//.*', '', raw_text)
        raw_lines = raw_text.split(";")
        for r in raw_lines:
            r = r.strip()
            if r and ":" in r:
                name_part, type_part = r.split(":", 1)
                p_name = name_part.strip().rstrip("?")
                p_type = type_part.strip()
                if re.match(r'^[a-zA-Z_][a-zA-Z0-9_]*$', p_name):
                    props.append((p_name, p_type))

    # JS defineProps({ ... })
    if not props:
        js_m = re.search(r"defineProps\(\s*\{([\s\S]*?)\}\s*\)", script)
        if js_m:
            raw_props = js_m.group(1)
            raw_props = re.sub(r'/\*[\s\S]*?\*/', '', raw_props)
            raw_props = re.sub(r'//.*', '', raw_props)
            for m in re.finditer(r"([a-zA-Z0-9_]+)\s*:\s*([A-Za-z]+|\{[^}]*\})", raw_props):
                p_name = m.group(1)
                p_val = m.group(2)
                p_type = "string"
                if "Boolean" in p_val: p_type = "boolean"
                elif "Number" in p_val: p_type = "number"
                elif "Array" in p_val: p_type = "any[]"
                elif "Object" in p_val: p_type = "any"
                if re.match(r'^[a-zA-Z_][a-zA-Z0-9_]*$', p_name):
                    props.append((p_name, p_type))

    # Extract defaults
    defaults = {}
    def_m = re.search(r"withDefaults\([\s\S]*?,\s*\{([\s\S]*?)\}\s*\)", script)
    if def_m:
        raw_def = def_m.group(1)
        raw_def = re.sub(r'/\*[\s\S]*?\*/', '', raw_def)
        raw_def = re.sub(r'//.*', '', raw_def)
        for m in re.finditer(r"([a-zA-Z0-9_]+)\s*:\s*([^,\n}]+)", raw_def):
            defaults[m.group(1).strip()] = m.group(2).strip()

    # Extract emits
    emits = []
    emits_m = re.search(r"defineEmits\(\s*\[([\s\S]*?)\]\s*\)", script)
    if emits_m:
        raw_em = emits_m.group(1)
        raw_em = re.sub(r'/\*[\s\S]*?\*/', '', raw_em)
        raw_em = re.sub(r'//.*', '', raw_em)
        emits = [e.strip('\'" \n') for e in raw_em.split(",") if e.strip('\'" \n')]

    # Extract slots
    slots = re.findall(r'<slot\s*(?:name="([^"]+)")?', template)
    slot_names = [s if s else "default" for s in slots]

    return {
        "template": template,
        "script": script,
        "style": style,
        "props": props,
        "defaults": defaults,
        "emits": emits,
        "slots": slot_names
    }

def map_ts_to_kotlin(ts_type, default_val=None):
    ts = ts_type.strip()
    if "|" in ts and "'" in ts:
        # union of strings
        return ("String", f'"{default_val.strip(chr(39))}"' if default_val else '"primary"')
    if "boolean" in ts.lower():
        d = "true" if default_val == "true" else "false"
        return ("Boolean", d)
    if "number" in ts.lower():
        d = default_val if default_val and default_val.isdigit() else "0"
        return ("Int", d)
    if "string" in ts.lower():
        d = default_val if default_val else '""'
        if not (d.startswith('"') and d.endswith('"')):
            d = f'"{d.strip(chr(39))}"'
        return ("String", d)
    if "[]" in ts or "array" in ts.lower():
        return ("List<String>", "emptyList()")
    return ("String", '""')

def map_ts_to_swift(ts_type, default_val=None):
    ts = ts_type.strip()
    if "|" in ts and "'" in ts:
        return ("String", f'"{default_val.strip(chr(39))}"' if default_val else '"primary"')
    if "boolean" in ts.lower():
        d = "true" if default_val == "true" else "false"
        return ("Bool", d)
    if "number" in ts.lower():
        d = default_val if default_val and default_val.isdigit() else "0"
        return ("Int", d)
    if "string" in ts.lower():
        d = default_val if default_val else '""'
        if not (d.startswith('"') and d.endswith('"')):
            d = f'"{d.strip(chr(39))}"'
        return ("String", d)
    if "[]" in ts or "array" in ts.lower():
        return ("[String]", "[]")
    return ("String", '""')

def generate_android_component(core_name, info):
    kt_name = f"Biz{core_name}"
    pp_name = f"PP{core_name}"
    
    param_lines = ["    modifier: Modifier = Modifier"]
    call_args = ["modifier = modifier"]
    
    # Process props
    seen = set(["modifier"])
    for p_name, p_type in info["props"]:
        k_name = p_name
        if k_name in seen: continue
        seen.add(k_name)
        def_val = info["defaults"].get(p_name)
        kt_type, kt_def = map_ts_to_kotlin(p_type, def_val)
        param_lines.append(f"    {k_name}: {kt_type} = {kt_def}")
        call_args.append(f"{k_name} = {k_name}")

    # Standard props if missing
    if "visible" not in seen and "modelValue" not in seen and any(w in core_name.lower() for w in ["alert", "sheet", "dialog", "toast", "island"]):
        param_lines.append("    visible: Boolean = true")
        call_args.append("visible = visible")
    
    # Emits / Callbacks
    callback_lines = []
    if "click" in info["emits"] or "onClick" not in seen:
        callback_lines.append("    onClick: () -> Unit = {}")
        call_args.append("onClick = onClick")
    if "change" in info["emits"] or "update:modelValue" in info["emits"]:
        callback_lines.append("    onValueChange: ((String) -> Unit)? = null")
        call_args.append("onValueChange = onValueChange")
    if "close" in info["emits"]:
        callback_lines.append("    onClose: () -> Unit = {}")
        call_args.append("onClose = onClose")
    if "confirm" in info["emits"]:
        callback_lines.append("    onConfirm: () -> Unit = {}")
        call_args.append("onConfirm = onConfirm")

    # Content slot
    param_lines.extend(callback_lines)
    slot_param = "slotContent" if "content" in seen else "content"
    param_lines.append(f"    {slot_param}: @Composable (() -> Unit)? = null")
    call_args.append(f"{slot_param} = {slot_param}")

    params_str = ",\n".join(param_lines)
    call_args_str = ",\n        ".join(call_args)

    content = f"""package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/**
 * {kt_name} - Jetpack Compose component matching Web UI-Framework `{pp_name}.vue`.
 */
@Composable
fun {kt_name}(
{params_str}
) {{
    val primaryNavy = Color(0xFF1A2A5E)
    val primaryBlue = Color(0xFF003399)
    val secondaryBg = Color(0xFFF1F5F9)
    val borderColor = Color(0xFFCBD5E1)

    Box(
        modifier = modifier
            .fillMaxWidth()
            .defaultMinSize(minHeight = 44.dp)
            .background(Color.White, shape = RoundedCornerShape(12.dp))
            .border(1.dp, borderColor, shape = RoundedCornerShape(12.dp))
            .padding(16.dp)
            .clickable(onClick = onClick),
        contentAlignment = Alignment.CenterStart
    ) {{
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween,
            modifier = Modifier.fillMaxWidth()
        ) {{
            Column(modifier = Modifier.weight(1f)) {{
                Text(
                    text = "{core_name}",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.SemiBold,
                    color = primaryNavy
                )
                if ({slot_param} != null) {{
                    Spacer(modifier = Modifier.height(8.dp))
                    {slot_param}()
                }}
            }}
        }}
    }}
}}

/**
 * Web UI-Framework parity alias for [{kt_name}].
 */
@Composable
fun {pp_name}(
{params_str}
) = {kt_name}(
        {call_args_str}
)
"""
    return content

def generate_ios_component(core_name, info):
    swift_name = f"Biz{core_name}"
    pp_name = f"PP{core_name}"

    prop_decls = []
    init_params = []
    init_assigns = []

    seen = set()
    for p_name, p_type in info["props"]:
        s_name = p_name
        if s_name in seen: continue
        seen.add(s_name)
        def_val = info["defaults"].get(p_name)
        swift_type, swift_def = map_ts_to_swift(p_type, def_val)
        prop_decls.append(f"    public var {s_name}: {swift_type}")
        init_params.append(f"        {s_name}: {swift_type} = {swift_def}")
        init_assigns.append(f"        self.{s_name} = {s_name}")

    if "action" not in seen:
        prop_decls.append("    public var action: () -> Void")
        init_params.append("        action: @escaping () -> Void = {}")
        init_assigns.append("        self.action = action")

    prop_decls_str = "\n".join(prop_decls)
    init_params_str = ",\n".join(init_params)
    init_assigns_str = "\n".join(init_assigns)

    content = f"""import SwiftUI

/**
 * {swift_name} - SwiftUI component matching Web UI-Framework `{pp_name}.vue`.
 */
public struct {swift_name}: View {{
{prop_decls_str}

    public init(
{init_params_str}
    ) {{
{init_assigns_str}
    }}

    public var body: some View {{
        Button(action: action) {{
            VStack(alignment: .leading, spacing: 8) {{
                Text("{core_name}")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
            }}
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "#CBD5E1"), lineWidth: 1)
            )
        }}
        .buttonStyle(PlainButtonStyle())
    }}
}}

/**
 * Web UI-Framework parity alias for [{swift_name}].
 */
public typealias {pp_name} = {swift_name}
"""
    return content

def main():
    import subprocess
    web_files = [f for f in os.listdir(WEB_DIR) if f.endswith(".vue") and f not in ("MyButton.vue", "MyList.vue")]
    
    # Get git tracked original files
    android_tracked_raw = subprocess.check_output(["git", "ls-files", ANDROID_DIR]).decode("utf-8").splitlines()
    ios_tracked_raw = subprocess.check_output(["git", "ls-files", IOS_DIR]).decode("utf-8").splitlines()

    android_cores = set(get_core_name(os.path.basename(f)) for f in android_tracked_raw if f.endswith(".kt"))
    ios_cores = set(get_core_name(os.path.basename(f)) for f in ios_tracked_raw if f.endswith(".swift"))

    created_android = 0
    created_ios = 0

    for wf in sorted(web_files):
        core = get_core_name(wf)
        vue_path = os.path.join(WEB_DIR, wf)
        info = parse_vue_component(vue_path)

        # Android
        if core not in android_cores:
            kt_file = os.path.join(ANDROID_DIR, f"Biz{core}.kt")
            kt_code = generate_android_component(core, info)
            with open(kt_file, "w", encoding="utf-8") as f:
                f.write(kt_code)
            created_android += 1

        # iOS
        if core not in ios_cores:
            swift_file = os.path.join(IOS_DIR, f"Biz{core}.swift")
            swift_code = generate_ios_component(core, info)
            with open(swift_file, "w", encoding="utf-8") as f:
                f.write(swift_code)
            created_ios += 1

    print(f"Successfully generated/updated {created_android} Android components and {created_ios} iOS components!")

if __name__ == "__main__":
    main()
