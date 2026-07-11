import os
import re

components_dir = "/Users/pangphanna/projects/los/dbcs-los-app-android/ui-framework/src/main/java/kh/mcnc/lib/ui/components"
views_dir = "/Users/pangphanna/projects/los/dbcs-los-app-android/ui-framework/src/main/java/kh/mcnc/lib/ui/views"
layouts_dir = "/Users/pangphanna/projects/los/dbcs-los-app-android/ui-framework/src/main/res/layout"
manifest_path = "/Users/pangphanna/projects/los/dbcs-los-app-android/ui-framework/src/main/AndroidManifest.xml"
attrs_path = "/Users/pangphanna/projects/los/dbcs-los-app-android/ui-framework/src/main/res/values/attrs.xml"

# Make sure views directory exists
os.makedirs(views_dir, exist_ok=True)
os.makedirs(layouts_dir, exist_ok=True)

# Basic list of components we found
components = [f for f in os.listdir(components_dir) if f.endswith(".kt") and f.startswith("App")]

# Create attrs.xml if it doesn't exist
if not os.path.exists(os.path.dirname(attrs_path)):
    os.makedirs(os.path.dirname(attrs_path), exist_ok=True)
if not os.path.exists(attrs_path):
    with open(attrs_path, "w") as f:
        f.write('<?xml version="1.0" encoding="utf-8"?>\n<resources>\n</resources>')

def to_snake_case(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

activities_to_add = []

for component_file in components:
    component_name = component_file.replace(".kt", "")
    # Exclude non-UI components or already done
    if component_name in ["AppKhmerCalendar", "AppMonthYearPickerBottomSheet"]:
        continue
        
    view_name = f"{component_name}View"
    activity_name = f"{component_name}SampleActivity"
    layout_name = f"activity_{to_snake_case(component_name)}_sample"
    
    # Generate View Wrapper
    view_content = f"""package kh.mcnc.lib.ui.views

import android.content.Context
import android.util.AttributeSet
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.AbstractComposeView
import kh.mcnc.lib.ui.components.{component_name}
import kh.mcnc.lib.ui.theme.AppTheme

class {view_name} @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : AbstractComposeView(context, attrs, defStyleAttr) {{

    @Composable
    override fun Content() {{
        AppTheme {{
            // Placeholder: Call the actual {component_name} composable here
            // Note: Parameters will need to be configured based on the specific component
            {component_name}()
        }}
    }}
}}
"""
    with open(os.path.join(views_dir, f"{view_name}.kt"), "w") as f:
        f.write(view_content)
        
    # Generate Activity
    activity_content = f"""package kh.mcnc.lib.ui.views

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kh.mcnc.lib.R

class {activity_name} : AppCompatActivity() {{
    override fun onCreate(savedInstanceState: Bundle?) {{
        super.onCreate(savedInstanceState)
        setContentView(R.layout.{layout_name})
    }}
}}
"""
    with open(os.path.join(views_dir, f"{activity_name}.kt"), "w") as f:
        f.write(activity_content)
        
    # Generate Layout XML
    layout_content = f"""<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <kh.mcnc.lib.ui.views.{view_name}
        android:id="@+id/{component_name[0].lower() + component_name[1:]}View"
        android:layout_width="match_parent"
        android:layout_height="wrap_content" />

</LinearLayout>
"""
    with open(os.path.join(layouts_dir, f"{layout_name}.xml"), "w") as f:
        f.write(layout_content)
        
    activities_to_add.append(f"kh.mcnc.lib.ui.views.{activity_name}")

# Update Manifest
with open(manifest_path, "r") as f:
    manifest_content = f.read()

activity_tags = ""
for act in activities_to_add:
    activity_tags += f'''
        <activity
            android:name="{act}"
            android:exported="false"
            android:theme="@style/Theme.App" />'''

manifest_content = manifest_content.replace("</application>", f"{activity_tags}\n    </application>")

with open(manifest_path, "w") as f:
    f.write(manifest_content)

print(f"Generated wrappers and activities for {len(activities_to_add)} components.")
