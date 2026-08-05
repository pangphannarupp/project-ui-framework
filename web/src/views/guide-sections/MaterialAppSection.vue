<template>
  <div class="guide-section">
    <div class="section-header">
      <h2>PPMaterialApp (Scaffold)</h2>
      <p>The master layout container that brings together App Bars, Navigation Drawers, Bottom Navigation, and Floating Action Buttons into a single cohesive structure.</p>
    </div>

    <div class="section-content">
      <div class="variant-group">
        <h3>Full Application Layout Demo</h3>
        <p class="guide-desc">A complete dashboard layout using <code>PPMaterialApp</code>. The layout manages the fixed header, sidebar, and scrollable content area automatically.</p>
        
        <div class="component-demo" style="padding: 0;">
          <!-- We put it in a container so it doesn't take over the whole screen in the documentation -->
          <div style="height: 600px; width: 100%; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative;">
            <PPMaterialApp 
              :theme="isDark ? 'dark' : 'light'" 
              :responsive="true"
              drawer-variant="mini"
              :drawer-open="drawerOpen"
              @close-drawer="drawerOpen = false"
              :hide-app-bar-on-scroll="hideAppBarOnScroll"
              :hide-bottom-nav-on-scroll="hideBottomNavOnScroll"
              fab-position="center-docked"
            >
              <template #header>
                <PPAppBar title="Dashboard" :theme="isDark ? 'dark' : 'light'" variant="center">
                  <template #left>
                    <PPIconButton @click="drawerOpen = !drawerOpen" color="transparent">
                      <ion-icon :icon="menuOutline" />
                    </PPIconButton>
                  </template>
                  <template #right>
                    <div style="display: flex; align-items: center; gap: 8px;">
                      <PPIconButton color="transparent">
                        <ion-icon :icon="searchOutline" />
                      </PPIconButton>
                      <PPIconButton color="transparent" :badge="true">
                        <ion-icon :icon="notificationsOutline" />
                      </PPIconButton>
                      <PPAvatar src="https://i.pravatar.cc/150?u=a042581f4e29026704d" size="sm" />
                    </div>
                  </template>
                </PPAppBar>
              </template>

              <!-- DRAWER -->
              <template #drawer>
                <PPSidebarNavigation
                  v-model="activeMenu"
                  :items="sidebarItems"
                  :theme="isDark ? 'dark' : 'light'"
                  variant="flat"
                  :collapsed="!drawerOpen"
                />
              </template>

              <!-- BOTTOM NAV -->
              <template #bottom-nav>
                <PPBottomNav
                  :theme="isDark ? 'dark' : 'light'"
                  :items="bottomNavItems"
                  v-model="activeBottom"
                  variant="cutout"
                />
              </template>

              <!-- FAB -->
              <template #fab>
                <PPFab color="primary" shape="rounded" @click="triggerSnackbar">
                  <template #icon><ion-icon :icon="addOutline" /></template>
                </PPFab>
              </template>

              <!-- SNACKBAR -->
              <template #snackbar>
                <div v-if="showSnackbar" style="background: var(--pp-primary, #3b82f6); color: white; padding: 12px 24px; border-radius: 8px; font-weight: 500; box-shadow: 0 4px 12px rgba(0,0,0,0.15); display: flex; align-items: center; gap: 8px; pointer-events: auto; white-space: nowrap;">
                  <ion-icon :icon="notificationsOutline" />
                  <span>FAB Clicked! Feature implemented!</span>
                </div>
              </template>

              <!-- MAIN CONTENT -->
              <div style="padding: 24px;">
                <div v-if="activeBottom === 'home'">
                  <h1 style="margin-top: 0;">Welcome back!</h1>
                  <p>This is the Home tab. The Header and Sidebar stay fixed while this content scrolls.</p>
                  <div style="height: 800px; background: repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(0,0,0,0.05) 10px, rgba(0,0,0,0.05) 20px); border-radius: 8px; margin-top: 24px; padding: 24px;">
                    Scroll down to see the FAB stay in place!
                  </div>
                </div>

                <div v-else-if="activeBottom === 'search'">
                  <h1 style="margin-top: 0;">Search</h1>
                  <p>Find what you're looking for.</p>
                  <div style="display: flex; flex-direction: column; gap: 16px; margin-top: 24px;">
                    <div style="height: 60px; background: rgba(0,0,0,0.05); border-radius: 8px;"></div>
                    <div style="height: 120px; background: rgba(0,0,0,0.05); border-radius: 8px;"></div>
                    <div style="height: 120px; background: rgba(0,0,0,0.05); border-radius: 8px;"></div>
                  </div>
                </div>

                <div v-else-if="activeBottom === 'profile'">
                  <h1 style="margin-top: 0;">Your Profile</h1>
                  <p>Manage your account settings and preferences.</p>
                  <div style="display: flex; align-items: center; gap: 16px; margin-top: 24px;">
                    <PPAvatar src="https://i.pravatar.cc/150?u=a042581f4e29026704d" size="lg" />
                    <div>
                      <h3 style="margin: 0;">Jane Doe</h3>
                      <p style="margin: 4px 0 0 0; opacity: 0.7;">jane.doe@example.com</p>
                    </div>
                  </div>
                </div>
              </div>
            </PPMaterialApp>
          </div>
        </div>
        
        <div style="margin-top: 16px; display: flex; gap: 12px; flex-wrap: wrap;">
          <PPSwitch v-model="drawerOpen" label="Sidebar" color="primary" />
          <PPSwitch v-model="isDark" label="Dark Theme" color="primary" />
          <PPSwitch v-model="hideAppBarOnScroll" label="Hide App Bar on Scroll" color="primary" />
          <PPSwitch v-model="hideBottomNavOnScroll" label="Hide Bottom Nav on Scroll" color="primary" />
        </div>

        <pre class="code-block" v-pre><code>&lt;PPMaterialApp theme="light"&gt;
  &lt;template #header&gt;
    &lt;PPAppBar title="Dashboard" /&gt;
  &lt;/template&gt;

  &lt;template #drawer&gt;
    &lt;PPSidebarNavigation :items="items" /&gt;
  &lt;/template&gt;

  &lt;!-- Main Content goes in the default slot --&gt;
  &lt;div class="content"&gt;
    ...
  &lt;/div&gt;

  &lt;template #fab&gt;
    &lt;PPFab color="primary"&gt;...&lt;/PPFab&gt;
  &lt;/template&gt;
&lt;/PPMaterialApp&gt;</code></pre>
      </div>

      <div class="variant-group" style="margin-top: 32px;">
        <h3>Mobile App Layout</h3>
        <p class="guide-desc">A typical mobile layout with an App Bar, Bottom Navigation, and a center-docked FAB. No sidebar is used here.</p>
        
        <div class="component-demo" style="padding: 0;">
          <div style="height: 600px; max-width: 375px; margin: 0 auto; border: 12px solid #1e293b; border-radius: 36px; overflow: hidden; position: relative; background: #0f172a;">
            <PPMaterialApp 
              theme="dark" 
              :hide-app-bar-on-scroll="true"
              :hide-bottom-nav-on-scroll="true"
              fab-position="center-float"
            >
              <template #header>
                <PPAppBar title="Mobile App" theme="dark" variant="center">
                  <template #left>
                    <PPIconButton color="transparent">
                      <ion-icon :icon="menuOutline" />
                    </PPIconButton>
                  </template>
                  <template #right>
                    <PPIconButton color="transparent">
                      <ion-icon :icon="searchOutline" />
                    </PPIconButton>
                  </template>
                </PPAppBar>
              </template>

              <template #bottom-nav>
                <PPBottomNav
                  theme="dark"
                  :items="bottomNavItems"
                  v-model="activeBottomMobile"
                />
              </template>

              <template #fab>
                <PPFab color="primary" shape="circle" size="lg">
                  <template #icon><ion-icon :icon="addOutline" /></template>
                </PPFab>
              </template>

              <div style="padding: 24px;">
                <div v-for="i in 10" :key="i" style="height: 80px; background: rgba(255,255,255,0.05); border-radius: 12px; margin-bottom: 16px; padding: 16px; display: flex; align-items: center; gap: 16px;">
                  <div style="width: 48px; height: 48px; border-radius: 24px; background: rgba(255,255,255,0.1);"></div>
                  <div style="flex: 1;">
                    <div style="height: 12px; width: 60%; background: rgba(255,255,255,0.1); border-radius: 4px; margin-bottom: 8px;"></div>
                    <div style="height: 10px; width: 40%; background: rgba(255,255,255,0.05); border-radius: 4px;"></div>
                  </div>
                </div>
              </div>
            </PPMaterialApp>
          </div>
        </div>
      </div>

      <div class="variant-group" style="margin-top: 32px;">
        <h3>Desktop Admin Layout</h3>
        <p class="guide-desc">A classic desktop admin layout with a permanent sidebar, header, and content area. No bottom navigation or FAB.</p>
        
        <div class="component-demo" style="padding: 0;">
          <div style="height: 500px; width: 100%; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative;">
            <PPMaterialApp 
              :theme="isDark ? 'dark' : 'light'" 
              drawer-variant="default"
              :drawer-open="true"
            >
              <template #header>
                <PPAppBar title="Admin Portal" :theme="isDark ? 'dark' : 'light'" variant="default">
                  <template #right>
                    <div style="display: flex; align-items: center; gap: 16px;">
                      <PPButton variant="ghost" size="small">Help</PPButton>
                      <PPAvatar src="https://i.pravatar.cc/150?u=admin" size="sm" />
                    </div>
                  </template>
                </PPAppBar>
              </template>

              <template #drawer>
                <PPSidebarNavigation
                  v-model="activeAdminMenu"
                  :items="adminSidebarItems"
                  :theme="isDark ? 'dark' : 'light'"
                  variant="flat"
                />
              </template>

              <div style="padding: 32px; height: 100%;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
                  <h1 style="margin: 0;">Dashboard Overview</h1>
                  <PPButton color="primary">Export Report</PPButton>
                </div>
                
                <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; margin-bottom: 24px;">
                  <div v-for="i in 3" :key="i" style="height: 120px; background: var(--pp-surface-alt, rgba(0,0,0,0.02)); border-radius: 12px; border: 1px solid var(--pp-border, #e2e8f0); padding: 24px;">
                    <div style="font-size: 14px; opacity: 0.7; margin-bottom: 8px;">Metric {{ i }}</div>
                    <div style="font-size: 32px; font-weight: bold;">{{ Math.floor(Math.random() * 1000) }}</div>
                  </div>
                </div>

                <div style="height: 400px; background: var(--pp-surface-alt, rgba(0,0,0,0.02)); border-radius: 12px; border: 1px solid var(--pp-border, #e2e8f0);"></div>
              </div>
            </PPMaterialApp>
          </div>
        </div>
      </div>
    </div>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-surface: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}</code></pre>
        </div>
</div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
  &lt;div class="guide-section"&gt;
    &lt;div class="section-header"&gt;
      &lt;h2&gt;PPMaterialApp (Scaffold)&lt;/h2&gt;
      &lt;p&gt;The master layout container that brings together App Bars, Navigation Drawers, Bottom Navigation, and Floating Action Buttons into a single cohesive structure.&lt;/p&gt;
    &lt;/div&gt;

    &lt;div class="section-content"&gt;
      &lt;div class="variant-group"&gt;
        &lt;h3&gt;Full Application Layout Demo&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A complete dashboard layout using &lt;code&gt;PPMaterialApp&lt;/code&gt;. The layout manages the fixed header, sidebar, and scrollable content area automatically.&lt;/p&gt;
        
        &lt;div class="component-demo" style="padding: 0;"&gt;
          &lt;!-- We put it in a container so it doesn't take over the whole screen in the documentation --&gt;
          &lt;div style="height: 600px; width: 100%; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPMaterialApp 
              :theme="isDark ? 'dark' : 'light'" 
              :responsive="true"
              drawer-variant="mini"
              :drawer-open="drawerOpen"
              @close-drawer="drawerOpen = false"
              :hide-app-bar-on-scroll="hideAppBarOnScroll"
              :hide-bottom-nav-on-scroll="hideBottomNavOnScroll"
              fab-position="center-docked"
            &gt;
              &lt;template #header&gt;
                &lt;PPAppBar title="Dashboard" :theme="isDark ? 'dark' : 'light'" variant="center"&gt;
                  &lt;template #left&gt;
                    &lt;PPIconButton @click="drawerOpen = !drawerOpen" color="transparent"&gt;
                      &lt;ion-icon :icon="menuOutline" /&gt;
                    &lt;/PPIconButton&gt;
                  &lt;/template&gt;
                  &lt;template #right&gt;
                    &lt;div style="display: flex; align-items: center; gap: 8px;"&gt;
                      &lt;PPIconButton color="transparent"&gt;
                        &lt;ion-icon :icon="searchOutline" /&gt;
                      &lt;/PPIconButton&gt;
                      &lt;PPIconButton color="transparent" :badge="true"&gt;
                        &lt;ion-icon :icon="notificationsOutline" /&gt;
                      &lt;/PPIconButton&gt;
                      &lt;PPAvatar src="https://i.pravatar.cc/150?u=a042581f4e29026704d" size="sm" /&gt;
                    &lt;/div&gt;
                  &lt;/template&gt;
                &lt;/PPAppBar&gt;
              &lt;/template&gt;

              &lt;!-- DRAWER --&gt;
              &lt;template #drawer&gt;
                &lt;PPSidebarNavigation
                  v-model="activeMenu"
                  :items="sidebarItems"
                  :theme="isDark ? 'dark' : 'light'"
                  variant="flat"
                  :collapsed="!drawerOpen"
                /&gt;
              &lt;/template&gt;

              &lt;!-- BOTTOM NAV --&gt;
              &lt;template #bottom-nav&gt;
                &lt;PPBottomNav
                  :theme="isDark ? 'dark' : 'light'"
                  :items="bottomNavItems"
                  v-model="activeBottom"
                  variant="cutout"
                /&gt;
              &lt;/template&gt;

              &lt;!-- FAB --&gt;
              &lt;template #fab&gt;
                &lt;PPFab color="primary" shape="rounded" @click="triggerSnackbar"&gt;
                  &lt;template #icon&gt;&lt;ion-icon :icon="addOutline" /&gt;&lt;/template&gt;
                &lt;/PPFab&gt;
              &lt;/template&gt;

              &lt;!-- SNACKBAR --&gt;
              &lt;template #snackbar&gt;
                &lt;div v-if="showSnackbar" style="background: var(--pp-primary, #3b82f6); color: white; padding: 12px 24px; border-radius: 8px; font-weight: 500; box-shadow: 0 4px 12px rgba(0,0,0,0.15); display: flex; align-items: center; gap: 8px; pointer-events: auto; white-space: nowrap;"&gt;
                  &lt;ion-icon :icon="notificationsOutline" /&gt;
                  &lt;span&gt;FAB Clicked! Feature implemented!&lt;/span&gt;
                &lt;/div&gt;
              &lt;/template&gt;

              &lt;!-- MAIN CONTENT --&gt;
              &lt;div style="padding: 24px;"&gt;
                &lt;div v-if="activeBottom === 'home'"&gt;
                  &lt;h1 style="margin-top: 0;"&gt;Welcome back!&lt;/h1&gt;
                  &lt;p&gt;This is the Home tab. The Header and Sidebar stay fixed while this content scrolls.&lt;/p&gt;
                  &lt;div style="height: 800px; background: repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(0,0,0,0.05) 10px, rgba(0,0,0,0.05) 20px); border-radius: 8px; margin-top: 24px; padding: 24px;"&gt;
                    Scroll down to see the FAB stay in place!
                  &lt;/div&gt;
                &lt;/div&gt;

                &lt;div v-else-if="activeBottom === 'search'"&gt;
                  &lt;h1 style="margin-top: 0;"&gt;Search&lt;/h1&gt;
                  &lt;p&gt;Find what you're looking for.&lt;/p&gt;
                  &lt;div style="display: flex; flex-direction: column; gap: 16px; margin-top: 24px;"&gt;
                    &lt;div style="height: 60px; background: rgba(0,0,0,0.05); border-radius: 8px;"&gt;&lt;/div&gt;
                    &lt;div style="height: 120px; background: rgba(0,0,0,0.05); border-radius: 8px;"&gt;&lt;/div&gt;
                    &lt;div style="height: 120px; background: rgba(0,0,0,0.05); border-radius: 8px;"&gt;&lt;/div&gt;
                  &lt;/div&gt;
                &lt;/div&gt;

                &lt;div v-else-if="activeBottom === 'profile'"&gt;
                  &lt;h1 style="margin-top: 0;"&gt;Your Profile&lt;/h1&gt;
                  &lt;p&gt;Manage your account settings and preferences.&lt;/p&gt;
                  &lt;div style="display: flex; align-items: center; gap: 16px; margin-top: 24px;"&gt;
                    &lt;PPAvatar src="https://i.pravatar.cc/150?u=a042581f4e29026704d" size="lg" /&gt;
                    &lt;div&gt;
                      &lt;h3 style="margin: 0;"&gt;Jane Doe&lt;/h3&gt;
                      &lt;p style="margin: 4px 0 0 0; opacity: 0.7;"&gt;jane.doe@example.com&lt;/p&gt;
                    &lt;/div&gt;
                  &lt;/div&gt;
                &lt;/div&gt;
              &lt;/div&gt;
            &lt;/PPMaterialApp&gt;
          &lt;/div&gt;
        &lt;/div&gt;
        
        &lt;div style="margin-top: 16px; display: flex; gap: 12px; flex-wrap: wrap;"&gt;
          &lt;PPSwitch v-model="drawerOpen" label="Sidebar" color="primary" /&gt;
          &lt;PPSwitch v-model="isDark" label="Dark Theme" color="primary" /&gt;
          &lt;PPSwitch v-model="hideAppBarOnScroll" label="Hide App Bar on Scroll" color="primary" /&gt;
          &lt;PPSwitch v-model="hideBottomNavOnScroll" label="Hide Bottom Nav on Scroll" color="primary" /&gt;
        &lt;/div&gt;

        &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPMaterialApp theme="light"&amp;gt;
  &amp;lt;template #header&amp;gt;
    &amp;lt;PPAppBar title="Dashboard" /&amp;gt;
  &amp;lt;/template&amp;gt;

  &amp;lt;template #drawer&amp;gt;
    &amp;lt;PPSidebarNavigation :items="items" /&amp;gt;
  &amp;lt;/template&amp;gt;

  &amp;lt;!-- Main Content goes in the default slot --&amp;gt;
  &amp;lt;div class="content"&amp;gt;
    ...
  &amp;lt;/div&amp;gt;

  &amp;lt;template #fab&amp;gt;
    &amp;lt;PPFab color="primary"&amp;gt;...&amp;lt;/PPFab&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPMaterialApp&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;

      &lt;div class="variant-group" style="margin-top: 32px;"&gt;
        &lt;h3&gt;Mobile App Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A typical mobile layout with an App Bar, Bottom Navigation, and a center-docked FAB. No sidebar is used here.&lt;/p&gt;
        
        &lt;div class="component-demo" style="padding: 0;"&gt;
          &lt;div style="height: 600px; max-width: 375px; margin: 0 auto; border: 12px solid #1e293b; border-radius: 36px; overflow: hidden; position: relative; background: #0f172a;"&gt;
            &lt;PPMaterialApp 
              theme="dark" 
              :hide-app-bar-on-scroll="true"
              :hide-bottom-nav-on-scroll="true"
              fab-position="center-float"
            &gt;
              &lt;template #header&gt;
                &lt;PPAppBar title="Mobile App" theme="dark" variant="center"&gt;
                  &lt;template #left&gt;
                    &lt;PPIconButton color="transparent"&gt;
                      &lt;ion-icon :icon="menuOutline" /&gt;
                    &lt;/PPIconButton&gt;
                  &lt;/template&gt;
                  &lt;template #right&gt;
                    &lt;PPIconButton color="transparent"&gt;
                      &lt;ion-icon :icon="searchOutline" /&gt;
                    &lt;/PPIconButton&gt;
                  &lt;/template&gt;
                &lt;/PPAppBar&gt;
              &lt;/template&gt;

              &lt;template #bottom-nav&gt;
                &lt;PPBottomNav
                  theme="dark"
                  :items="bottomNavItems"
                  v-model="activeBottomMobile"
                /&gt;
              &lt;/template&gt;

              &lt;template #fab&gt;
                &lt;PPFab color="primary" shape="circle" size="lg"&gt;
                  &lt;template #icon&gt;&lt;ion-icon :icon="addOutline" /&gt;&lt;/template&gt;
                &lt;/PPFab&gt;
              &lt;/template&gt;

              &lt;div style="padding: 24px;"&gt;
                &lt;div v-for="i in 10" :key="i" style="height: 80px; background: rgba(255,255,255,0.05); border-radius: 12px; margin-bottom: 16px; padding: 16px; display: flex; align-items: center; gap: 16px;"&gt;
                  &lt;div style="width: 48px; height: 48px; border-radius: 24px; background: rgba(255,255,255,0.1);"&gt;&lt;/div&gt;
                  &lt;div style="flex: 1;"&gt;
                    &lt;div style="height: 12px; width: 60%; background: rgba(255,255,255,0.1); border-radius: 4px; margin-bottom: 8px;"&gt;&lt;/div&gt;
                    &lt;div style="height: 10px; width: 40%; background: rgba(255,255,255,0.05); border-radius: 4px;"&gt;&lt;/div&gt;
                  &lt;/div&gt;
                &lt;/div&gt;
              &lt;/div&gt;
            &lt;/PPMaterialApp&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group" style="margin-top: 32px;"&gt;
        &lt;h3&gt;Desktop Admin Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A classic desktop admin layout with a permanent sidebar, header, and content area. No bottom navigation or FAB.&lt;/p&gt;
        
        &lt;div class="component-demo" style="padding: 0;"&gt;
          &lt;div style="height: 500px; width: 100%; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPMaterialApp 
              :theme="isDark ? 'dark' : 'light'" 
              drawer-variant="default"
              :drawer-open="true"
            &gt;
              &lt;template #header&gt;
                &lt;PPAppBar title="Admin Portal" :theme="isDark ? 'dark' : 'light'" variant="default"&gt;
                  &lt;template #right&gt;
                    &lt;div style="display: flex; align-items: center; gap: 16px;"&gt;
                      &lt;PPButton variant="ghost" size="small"&gt;Help&lt;/PPButton&gt;
                      &lt;PPAvatar src="https://i.pravatar.cc/150?u=admin" size="sm" /&gt;
                    &lt;/div&gt;
                  &lt;/template&gt;
                &lt;/PPAppBar&gt;
              &lt;/template&gt;

              &lt;template #drawer&gt;
                &lt;PPSidebarNavigation
                  v-model="activeAdminMenu"
                  :items="adminSidebarItems"
                  :theme="isDark ? 'dark' : 'light'"
                  variant="flat"
                /&gt;
              &lt;/template&gt;

              &lt;div style="padding: 32px; height: 100%;"&gt;
                &lt;div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;"&gt;
                  &lt;h1 style="margin: 0;"&gt;Dashboard Overview&lt;/h1&gt;
                  &lt;PPButton color="primary"&gt;Export Report&lt;/PPButton&gt;
                &lt;/div&gt;
                
                &lt;div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; margin-bottom: 24px;"&gt;
                  &lt;div v-for="i in 3" :key="i" style="height: 120px; background: var(--pp-surface-alt, rgba(0,0,0,0.02)); border-radius: 12px; border: 1px solid var(--pp-border, #e2e8f0); padding: 24px;"&gt;
                    &lt;div style="font-size: 14px; opacity: 0.7; margin-bottom: 8px;"&gt;Metric {{ i }}&lt;/div&gt;
                    &lt;div style="font-size: 32px; font-weight: bold;"&gt;{{ Math.floor(Math.random() * 1000) }}&lt;/div&gt;
                  &lt;/div&gt;
                &lt;/div&gt;

                &lt;div style="height: 400px; background: var(--pp-surface-alt, rgba(0,0,0,0.02)); border-radius: 12px; border: 1px solid var(--pp-border, #e2e8f0);"&gt;&lt;/div&gt;
              &lt;/div&gt;
            &lt;/PPMaterialApp&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-surface: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';
import { 
  menuOutline, 
  addOutline,
  homeOutline,
  home,
  searchOutline,
  search,
  personOutline,
  person,
  notificationsOutline
} from 'ionicons/icons';
import { 
  PPMaterialApp, 
  PPAppBar, 
  PPSidebarNavigation, 
  PPBottomNav, 
  PPFab, 
  PPIconButton, 
  PPAvatar,
  PPButton,
  PPSwitch
} from '@phanna/ui-framework';

const isDark = ref(false);
const drawerOpen = ref(true);
const activeMenu = ref('home');
const activeBottom = ref('home');
const activeBottomMobile = ref('home');
const activeAdminMenu = ref('dashboard');
const showSnackbar = ref(false);
const hideAppBarOnScroll = ref(true);
const hideBottomNavOnScroll = ref(true);

function triggerSnackbar() {
  showSnackbar.value = true;
  setTimeout(() =&gt; {
    showSnackbar.value = false;
  }, 3000);
}

const bottomNavItems = [
  { value: 'home', label: 'Home', icon: homeOutline, activeIcon: home },
  { value: 'search', label: 'Search', icon: searchOutline, activeIcon: search },
  { value: 'profile', label: 'Profile', icon: personOutline, activeIcon: person }
];

const sidebarItems = [
  {
    groupLabel: 'Overview',
    items: [
      { id: 'home', label: 'Home', icon: homeOutline },
      { id: 'analytics', label: 'Analytics', icon: searchOutline }
    ]
  },
  {
    groupLabel: 'Settings',
    items: [
      { id: 'profile', label: 'Profile', icon: personOutline }
    ]
  }
];

const adminSidebarItems = [
  {
    groupLabel: 'Core',
    items: [
      { id: 'dashboard', label: 'Dashboard', icon: homeOutline },
      { id: 'users', label: 'Users', icon: personOutline }
    ]
  },
  {
    groupLabel: 'System',
    items: [
      { id: 'settings', label: 'Settings', icon: searchOutline }
    ]
  }
];

function toggleDrawer() {
  drawerOpen.value = !drawerOpen.value;
}
&lt;/script&gt;

&lt;style scoped&gt;
/* Scoped styles if needed */
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';
import { 
  menuOutline, 
  addOutline,
  homeOutline,
  home,
  searchOutline,
  search,
  personOutline,
  person,
  notificationsOutline
} from 'ionicons/icons';
import { 
  PPMaterialApp, 
  PPAppBar, 
  PPSidebarNavigation, 
  PPBottomNav, 
  PPFab, 
  PPIconButton, 
  PPAvatar,
  PPButton,
  PPSwitch
} from '@phanna/ui-framework';

const isDark = ref(false);
const drawerOpen = ref(true);
const activeMenu = ref('home');
const activeBottom = ref('home');
const activeBottomMobile = ref('home');
const activeAdminMenu = ref('dashboard');
const showSnackbar = ref(false);
const hideAppBarOnScroll = ref(true);
const hideBottomNavOnScroll = ref(true);

function triggerSnackbar() {
  showSnackbar.value = true;
  setTimeout(() => {
    showSnackbar.value = false;
  }, 3000);
}

const bottomNavItems = [
  { value: 'home', label: 'Home', icon: homeOutline, activeIcon: home },
  { value: 'search', label: 'Search', icon: searchOutline, activeIcon: search },
  { value: 'profile', label: 'Profile', icon: personOutline, activeIcon: person }
];

const sidebarItems = [
  {
    groupLabel: 'Overview',
    items: [
      { id: 'home', label: 'Home', icon: homeOutline },
      { id: 'analytics', label: 'Analytics', icon: searchOutline }
    ]
  },
  {
    groupLabel: 'Settings',
    items: [
      { id: 'profile', label: 'Profile', icon: personOutline }
    ]
  }
];

const adminSidebarItems = [
  {
    groupLabel: 'Core',
    items: [
      { id: 'dashboard', label: 'Dashboard', icon: homeOutline },
      { id: 'users', label: 'Users', icon: personOutline }
    ]
  },
  {
    groupLabel: 'System',
    items: [
      { id: 'settings', label: 'Settings', icon: searchOutline }
    ]
  }
];

function toggleDrawer() {
  drawerOpen.value = !drawerOpen.value;
}
</script>

<style scoped>
/* Scoped styles if needed */
</style>
