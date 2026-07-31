<template>
<div class="guide-section">
        <h2>Collapsing Appbar</h2>
        <div class="variant-group">
          <h3>Scroll to Collapse</h3>
          <p class="custom-guide">A Material Design style collapsing toolbar. Scroll the content below to see it shrink!</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Profile" :expandedHeight="200" :collapsedHeight="56">
              <template #background>
                <img src="https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop" alt="bg" />
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <template #profile>
                <img src="https://i.pravatar.cc/150?img=68" alt="Profile" style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; object-fit: cover; box-shadow: 0 2px 4px rgba(0,0,0,0.2);" />
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
          <pre class="code-block"><code>&lt;PPCollapsingToolbar title="Profile" :expandedHeight="200" :collapsedHeight="56"&gt;
  &lt;template #background&gt;
    &lt;img src="..." alt="bg" /&gt;
  &lt;/template&gt;
  &lt;template #start&gt;
    &lt;PPIconButton color="white"&gt;
      &lt;!-- Back Icon --&gt;
    &lt;/PPIconButton&gt;
  &lt;/template&gt;
  &lt;template #profile&gt;
    &lt;img src="..." alt="Profile" class="avatar" /&gt;
  &lt;/template&gt;
  
  &lt;div class="content"&gt;
    &lt;!-- Scrollable content --&gt;
  &lt;/div&gt;
&lt;/PPCollapsingToolbar&gt;</code></pre>
        </div>
        
        <div class="variant-group">
          <h3>Standard Header (No Profile)</h3>
          <p class="custom-guide">Without a profile picture, the title scales and aligns correctly by itself. Here it moves to the center when collapsed.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Dashboard" :expandedHeight="200" :collapsedHeight="56" centerTitleOnCollapse>
              <template #background>
                <img src="https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=1000&auto=format&fit=crop" alt="bg" />
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
          <pre class="code-block"><code>&lt;PPCollapsingToolbar title="Dashboard" :expandedHeight="200" :collapsedHeight="56" centerTitleOnCollapse&gt;
  &lt;template #background&gt;
    &lt;img src="..." alt="bg" /&gt;
  &lt;/template&gt;
  &lt;template #start&gt;
    &lt;PPIconButton color="white"&gt;
      &lt;!-- Back Icon --&gt;
    &lt;/PPIconButton&gt;
  &lt;/template&gt;
  
  &lt;div class="content"&gt;
    &lt;!-- Scrollable content --&gt;
  &lt;/div&gt;
&lt;/PPCollapsingToolbar&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Gradient Background & Icon Profile</h3>
          <p class="custom-guide">A vibrant gradient background with an icon instead of an image for the profile.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Plugin Details" :expandedHeight="200" :collapsedHeight="56">
              <template #background>
                <div style="width: 100%; height: 100%; background: linear-gradient(135deg, #ff4081 0%, #ffe0b2 50%, #81d4fa 100%);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <template #profile>
                <div style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; background-color: white; display: flex; align-items: center; justify-content: center; color: #ff4081;">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="18" height="18"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
                </div>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 5" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. This style is great for dynamic plugin pages!
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Solid Color with Actions</h3>
          <p class="custom-guide">A solid color background using the end slot for actions like search and settings.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Settings" :expandedHeight="150" :collapsedHeight="56" centerTitleOnCollapse>
              <template #background>
                <div style="width: 100%; height: 100%; background-color: var(--pp-primary, #007aff);"></div>
              </template>
              
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>

              <template #end>
                <div style="display: flex; gap: 4px; align-items: center;">
                  <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg></PPIconButton>
                  <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg></PPIconButton>
                </div>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  List item {{ i }}. This style allows adding quick actions directly on the appbar.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>
        <div class="variant-group">
          <h3>Sticky Segment (Tabs)</h3>
          <p class="custom-guide">A segment control that scrolls with the content but sticks to the bottom of the collapsed header.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Transactions" :expandedHeight="200" :collapsedHeight="56">
              <template #background>
                <div style="width: 100%; height: 100%; background: linear-gradient(to right, #4facfe 0%, #00f2fe 100%);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <!-- Sticky Segment Container -->
              <div style="position: sticky; top: 56px; z-index: 20; background: white; padding: 8px 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);">
                <div style="display: flex; background: #f1f5f9; border-radius: 8px; padding: 4px;">
                  <div style="flex: 1; text-align: center; padding: 6px; background: white; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); font-weight: 500; font-size: 14px;">Recent</div>
                  <div style="flex: 1; text-align: center; padding: 6px; border-radius: 6px; color: #64748b; font-weight: 500; font-size: 14px;">Scheduled</div>
                </div>
              </div>
              
              <div style="padding: 16px 24px;">
                <p v-for="i in 12" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable item {{ i }}. Notice how the segment tabs stick right under the header when you scroll down.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Floating Header Style</h3>
          <p class="custom-guide">By using CSS overrides, you can make the expanded header look like a floating island.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #f8fafc;">
            <PPCollapsingToolbar title="Overview" :expandedHeight="220" :collapsedHeight="64" class="floating-collapse-appbar">
              <template #background>
                <div style="width: 100%; height: 100%; background: #ffffff; border-radius: 20px; box-shadow: 0 10px 25px -5px rgba(0,0,0,0.1);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent" style="color: #1e293b;"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px; padding-top: 32px;">
                <p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Floating content {{ i }}. This style pushes the header inward using CSS.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>
        <div class="variant-group">
          <h3>Glassmorphism (Frosted Glass)</h3>
          <p class="custom-guide">A premium iOS-style blurred glass effect using backdrop-filter. This requires a background image and a translucent overlay.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Discover" :expandedHeight="220" :collapsedHeight="60">
              <template #background>
                <!-- Base image -->
                <div style="position: absolute; inset: 0;">
                  <img src="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=1000&auto=format&fit=crop" alt="bg" style="width: 100%; height: 100%; object-fit: cover;" />
                </div>
                <!-- Glass overlay -->
                <div style="position: absolute; inset: 0; background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px); border-bottom: 1px solid rgba(255, 255, 255, 0.3);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              <template #end>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scroll up to see the beautiful frosted glass effect compress. The background image blurs heavily under the title.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Dark Mode Aesthetic</h3>
          <p class="custom-guide">A sleek, dark-themed header with subtle glowing accents.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #0f172a;">
            <PPCollapsingToolbar title="Wallet" :expandedHeight="200" :collapsedHeight="56" class="dark-collapse-appbar">
              <template #background>
                <div style="width: 100%; height: 100%; background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%); position: relative; overflow: hidden;">
                  <!-- Glowing orb -->
                  <div style="position: absolute; top: -50px; right: -20px; width: 150px; height: 150px; background: #3b82f6; border-radius: 50%; filter: blur(60px); opacity: 0.5;"></div>
                  <div style="position: absolute; bottom: 0; left: 0; right: 0; height: 1px; background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.5), transparent);"></div>
                </div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px; color: #cbd5e1;">
                <p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px;">
                  Dark mode content. The appbar title text is styled to be white using a CSS override.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Card Overlap Style</h3>
          <p class="custom-guide">The content scrolls over the header, creating a layered, dimensional look. Very common in modern finance apps.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #f1f5f9;">
            <PPCollapsingToolbar title="Account details" :expandedHeight="240" :collapsedHeight="60">
              <template #background>
                <div style="width: 100%; height: 100%; background: #2563eb; background-image: radial-gradient(circle at 100% 0%, #3b82f6 0%, transparent 50%);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <!-- Overlapping Card Container -->
              <div style="padding: 0 16px; margin-top: -32px; position: relative; z-index: 1;">
                <div style="background: white; border-radius: 16px; padding: 24px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05); text-align: center;">
                  <div style="font-size: 14px; color: #64748b; font-weight: 500;">Total Balance</div>
                  <div style="font-size: 32px; font-weight: 700; color: #0f172a; margin-top: 8px;">$12,450.00</div>
                  <div style="display: flex; gap: 12px; margin-top: 24px;">
                    <div style="flex: 1; padding: 12px; background: #eff6ff; color: #2563eb; border-radius: 12px; font-weight: 600;">Transfer</div>
                    <div style="flex: 1; padding: 12px; background: #eff6ff; color: #2563eb; border-radius: 12px; font-weight: 600;">Pay</div>
                  </div>
                </div>
                
                <div style="margin-top: 24px;">
                  <h4 style="margin: 0 0 16px 0; color: #334155;">Recent Activity</h4>
                  <div v-for="i in 8" :key="i" style="background: white; padding: 16px; border-radius: 12px; margin-bottom: 12px; display: flex; justify-content: space-between;">
                    <div>
                      <div style="font-weight: 600; color: #1e293b;">Payment {{ i }}</div>
                      <div style="font-size: 13px; color: #94a3b8; margin-top: 4px;">Today</div>
                    </div>
                    <div style="font-weight: 600; color: #ef4444;">-$45.00</div>
                  </div>
                </div>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

      </div>
</template>

<script setup lang="ts">
import { PPCollapsingToolbar, PPIconButton } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section {
  padding: 16px;
}
.custom-guide {
  color: #64748b;
  margin-bottom: 16px;
}
.code-block {
  background: #1e293b;
  color: #e2e8f0;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  margin-top: 16px;
}
.floating-collapse-appbar :deep(.pp-collapsing-header) {
  margin: 16px;
  width: calc(100% - 32px);
  border-radius: 20px;
  background: transparent;
  box-shadow: none;
}
.floating-collapse-appbar :deep(.pp-collapsing-title) {
  color: #1e293b;
}

/* Fallback for transparent icon button until framework rebuild cache is cleared */
:deep(.pp-icon-btn--transparent) {
  background-color: transparent !important;
  color: inherit;
  box-shadow: none !important;
}
:deep(.pp-icon-btn--transparent:active) {
  background-color: rgba(0, 0, 0, 0.1) !important;
}
:deep(.floating-collapse-appbar .pp-icon-btn--transparent) {
  color: #1e293b !important;
}
:deep(.pp-collapsing-header:not(.floating-collapse-appbar) .pp-icon-btn--transparent) {
  color: #ffffff;
}
.dark-collapse-appbar :deep(.pp-collapsing-title) {
  color: #ffffff !important;
}
</style>
