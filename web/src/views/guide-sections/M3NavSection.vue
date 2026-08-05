<template>
<div class="guide-section">
        <h2>Bottom Navigation</h2>
        <p class="guide-desc">Modern bottom navigation bars with multiple styles and variants.</p>

        <div class="variant-group">
          <h3>Material 3 (Default)</h3>
          <p class="guide-desc">The standard MD3 style with pill indicators.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValMaterial"
              variant="material"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="material"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Classic</h3>
          <p class="guide-desc">A traditional style with icons and text stacked vertically.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValClassic"
              variant="classic"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="classic"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Shift</h3>
          <p class="guide-desc">A dynamic shifting style where only the active item shows its label.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValShift"
              variant="shift"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="shift"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Floating</h3>
          <p class="guide-desc">A modern floating island navigation bar.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; height: 160px; background: #f0f2f5;">
            <PPBottomNav 
              v-model="navValFloating"
              variant="floating"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="floating"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Dot (Animated)</h3>
          <p class="guide-desc">A smooth sliding dot indicator with icon bounce.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValDot"
              variant="dot"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="dot"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Bubble (Animated)</h3>
          <p class="guide-desc">A springy popping bubble indicator.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValBubble"
              variant="bubble"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="bubble"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Magic Line (Animated)</h3>
          <p class="guide-desc">A glowing line sliding across a sleek dark background.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #2c2c36;">
            <PPBottomNav 
              v-model="navValMagicLine"
              variant="magic-line"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="magic-line"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Curved (The Cutout)</h3>
          <p class="guide-desc">The active item pops up into a floating circle above the navigation bar.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #f9f9fc;">
            <PPBottomNav 
              v-model="navValCurved"
              variant="curved"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="curved"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Cutout (Action FAB)</h3>
          <p class="guide-desc">A centered elevated action button with a curved cutout behind it.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #1a1a1a;">
            <PPBottomNav 
              v-model="navValCutout"
              variant="cutout"
              :items="navItemsCutout"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="cutout"
  :items="navItemsCutout"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Pill Slide (Segmented Control)</h3>
          <p class="guide-desc">A continuous pill shape with a solid background sliding behind the active item.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #ffffff;">
            <PPBottomNav 
              v-model="navValPillSlide"
              variant="pill-slide"
              :items="navItems"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="pill-slide"
  :items="navItems"
/&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
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
        &lt;h2&gt;Bottom Navigation&lt;/h2&gt;
        &lt;p class="guide-desc"&gt;Modern bottom navigation bars with multiple styles and variants.&lt;/p&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Material 3 (Default)&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;The standard MD3 style with pill indicators.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;"&gt;
            &lt;PPBottomNav 
              v-model="navValMaterial"
              variant="material"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="material"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Classic&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;A traditional style with icons and text stacked vertically.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;"&gt;
            &lt;PPBottomNav 
              v-model="navValClassic"
              variant="classic"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="classic"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Shift&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;A dynamic shifting style where only the active item shows its label.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;"&gt;
            &lt;PPBottomNav 
              v-model="navValShift"
              variant="shift"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="shift"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Floating&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;A modern floating island navigation bar.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; height: 160px; background: #f0f2f5;"&gt;
            &lt;PPBottomNav 
              v-model="navValFloating"
              variant="floating"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="floating"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Dot (Animated)&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;A smooth sliding dot indicator with icon bounce.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;"&gt;
            &lt;PPBottomNav 
              v-model="navValDot"
              variant="dot"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="dot"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Bubble (Animated)&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;A springy popping bubble indicator.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;"&gt;
            &lt;PPBottomNav 
              v-model="navValBubble"
              variant="bubble"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="bubble"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Magic Line (Animated)&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;A glowing line sliding across a sleek dark background.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #2c2c36;"&gt;
            &lt;PPBottomNav 
              v-model="navValMagicLine"
              variant="magic-line"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="magic-line"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Curved (The Cutout)&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;The active item pops up into a floating circle above the navigation bar.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #f9f9fc;"&gt;
            &lt;PPBottomNav 
              v-model="navValCurved"
              variant="curved"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="curved"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Cutout (Action FAB)&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;A centered elevated action button with a curved cutout behind it.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #1a1a1a;"&gt;
            &lt;PPBottomNav 
              v-model="navValCutout"
              variant="cutout"
              :items="navItemsCutout"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="cutout"
  :items="navItemsCutout"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Pill Slide (Segmented Control)&lt;/h3&gt;
          &lt;p class="guide-desc"&gt;A continuous pill shape with a solid background sliding behind the active item.&lt;/p&gt;
          &lt;div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #ffffff;"&gt;
            &lt;PPBottomNav 
              v-model="navValPillSlide"
              variant="pill-slide"
              :items="navItems"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomNav 
  v-model="currentTab"
  variant="pill-slide"
  :items="navItems"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue';

const navValMaterial = ref('home');
const navValClassic = ref('home');
const navValShift = ref('home');
const navValFloating = ref('home');
const navValDot = ref('home');
const navValBubble = ref('home');
const navValMagicLine = ref('home');
const navValCurved = ref('home');
const navValPillSlide = ref('home');
const navValCutout = ref('home');

const navItems = [
  { label: 'Home', value: 'home', icon: homeOutline, activeIcon: home },
  { label: 'History', value: 'history', icon: documentTextOutline, activeIcon: documentText },
  { label: 'Messages', value: 'messages', icon: chatbubbleOutline, activeIcon: chatbubble },
  { label: 'Profile', value: 'profile', icon: personOutline, activeIcon: person }
];

const navItemsCutout = [
  { label: 'Home', value: 'home', icon: homeOutline, activeIcon: home },
  { label: 'Rewards', value: 'rewards', icon: cardOutline, activeIcon: cardOutline },
  { label: 'Order', value: 'order', icon: addOutline, isAction: true },
  { label: 'Scan', value: 'scan', icon: scanOutline },
  { label: 'My Order', value: 'myorder', icon: cartOutline }
];

import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline, scanOutline, cartOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const navValMaterial = ref('home');
const navValClassic = ref('home');
const navValShift = ref('home');
const navValFloating = ref('home');
const navValDot = ref('home');
const navValBubble = ref('home');
const navValMagicLine = ref('home');
const navValCurved = ref('home');
const navValPillSlide = ref('home');
const navValCutout = ref('home');

const navItems = [
  { label: 'Home', value: 'home', icon: homeOutline, activeIcon: home },
  { label: 'History', value: 'history', icon: documentTextOutline, activeIcon: documentText },
  { label: 'Messages', value: 'messages', icon: chatbubbleOutline, activeIcon: chatbubble },
  { label: 'Profile', value: 'profile', icon: personOutline, activeIcon: person }
];

const navItemsCutout = [
  { label: 'Home', value: 'home', icon: homeOutline, activeIcon: home },
  { label: 'Rewards', value: 'rewards', icon: cardOutline, activeIcon: cardOutline },
  { label: 'Order', value: 'order', icon: addOutline, isAction: true },
  { label: 'Scan', value: 'scan', icon: scanOutline },
  { label: 'My Order', value: 'myorder', icon: cartOutline }
];

import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline, scanOutline, cartOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
