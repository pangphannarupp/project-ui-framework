<template>
<div class="guide-section">
        <h2>Floating Action Button (FAB)</h2>
        <div class="variant-group">
          <h3>Standard FAB & Speed Dial</h3>
          <div class="component-demo" style="min-height: 400px; position: relative;">
            
            <!-- Standard -->
            <PPFab position="bottom-right" variant="solid" color="primary">
              <template #list>
                <PPFabList side="top">
                  <PPFabAction color="primary" @click="alertVal('Action 1')">1</PPFabAction>
                  <PPFabAction color="danger" @click="alertVal('Action 2')">2</PPFabAction>
                </PPFabList>
              </template>
            </PPFab>
            
            <!-- Extended -->
            <PPFab position="bottom-left" color="secondary" :extended="isExtended">
              Extended FAB
            </PPFab>

            <!-- Gradient Variant -->
            <PPFab position="center" variant="gradient" style="margin-top: -120px;">
              <template #icon>
                <IonIcon :icon="rocketOutline" />
              </template>
            </PPFab>

            <!-- Soft Variant -->
            <PPFab position="center" variant="soft" style="margin-left: -100px; margin-top: 40px;">
              <template #icon>
                <IonIcon :icon="layersOutline" />
              </template>
            </PPFab>

            <!-- Outline Variant -->
            <PPFab position="center" variant="outline" style="margin-left: 100px; margin-top: 40px;">
              <template #icon>
                <IonIcon :icon="searchOutline" />
              </template>
            </PPFab>

            <!-- Glass Variant -->
            <!-- Glass looks best on an image or pattern, but we'll demonstrate it here -->
            <div style="position: absolute; top: 20px; right: 20px; width: 100px; height: 100px; background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
              <PPFab position="center" variant="glass" style="position: relative; top: 0; left: 0; transform: none;">
                <template #icon>
                  <IonIcon :icon="chatbubbleOutline" />
                </template>
              </PPFab>
            </div>
            
            <div style="padding-bottom: 20px; position: relative; z-index: 10;">
              <PPButton @click="isExtended = !isExtended">Toggle Extended FAB</PPButton>
            </div>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPFab position="bottom-right"&gt;
  &lt;template #list&gt;
    &lt;PPFabList side="top"&gt;
      &lt;PPFabAction color="primary" @click="doSomething"&gt;1&lt;/PPFabAction&gt;
    &lt;/PPFabList&gt;
  &lt;/template&gt;
&lt;/PPFab&gt;

&lt;PPFab position="bottom-left" color="secondary" :extended="isExtended"&gt;
  Extended FAB
&lt;/PPFab&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Circle Speed Dial</h3>
          <div class="component-demo" style="min-height: 400px; position: relative;">
            <p style="text-align: center; margin-bottom: 24px; color: #6b7280;">Click the center FAB to see the actions expand in a circle.</p>

            <!-- Full Circle Speed Dial -->
            <PPFab position="center" color="primary">
              <template #icon>
                <IonIcon :icon="addOutline" />
              </template>
              <template #list>
                <PPFabList side="circle" :circleRadius="80">
                  <PPFabAction color="primary"><IonIcon :icon="shareOutline" /></PPFabAction>
                  <PPFabAction color="danger"><IonIcon :icon="trashOutline" /></PPFabAction>
                  <PPFabAction color="secondary"><IonIcon :icon="documentTextOutline" /></PPFabAction>
                  <PPFabAction color="light"><IonIcon :icon="personOutline" /></PPFabAction>
                  <PPFabAction color="light"><IonIcon :icon="settingsOutline" /></PPFabAction>
                </PPFabList>
              </template>
            </PPFab>
            
            <!-- Semi-Circle Speed Dial (Top) -->
            <PPFab position="bottom-right" color="danger">
              <template #icon>
                <IonIcon :icon="addOutline" />
              </template>
              <template #list>
                <!-- A top semi-circle uses angles from -90 to 90. -->
                <PPFabList side="circle" :circleStartAngle="-90" :circleEndAngle="0" :circleRadius="90">
                  <PPFabAction color="light"><IonIcon :icon="chatbubbleOutline" /></PPFabAction>
                  <PPFabAction color="light"><IonIcon :icon="phonePortraitOutline" /></PPFabAction>
                  <PPFabAction color="light"><IonIcon :icon="personOutline" /></PPFabAction>
                </PPFabList>
              </template>
            </PPFab>

          </div>
          <pre class="code-block" v-pre><code>&lt;!-- Full Circle Speed Dial --&gt;
&lt;PPFab position="center"&gt;
  &lt;template #list&gt;
    &lt;PPFabList side="circle" :circleRadius="80"&gt;
      &lt;PPFabAction&gt;1&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;2&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;3&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;4&lt;/PPFabAction&gt;
    &lt;/PPFabList&gt;
  &lt;/template&gt;
&lt;/PPFab&gt;

&lt;!-- Quarter/Semi Circle Speed Dial --&gt;
&lt;PPFab position="bottom-right"&gt;
  &lt;template #list&gt;
    &lt;PPFabList side="circle" :circleStartAngle="-90" :circleEndAngle="0" :circleRadius="90"&gt;
      &lt;PPFabAction&gt;1&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;2&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;3&lt;/PPFabAction&gt;
    &lt;/PPFabList&gt;
  &lt;/template&gt;
&lt;/PPFab&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Shapes and Morph Animation</h3>
          <div class="component-demo" style="min-height: 400px; position: relative; overflow: hidden; transform: translateZ(0);">
            
            <!-- Rounded Shape -->
            <PPFab position="top-right" color="danger" shape="rounded">
              <template #icon>
                <IonIcon :icon="trashOutline" />
              </template>
            </PPFab>
            
            <!-- Square Shape -->
            <PPFab position="top-left" color="secondary" shape="square">
              <template #icon>
                <IonIcon :icon="documentTextOutline" />
              </template>
            </PPFab>

            <!-- Morph Animation to Full Screen -->
            <PPFab position="center" color="primary" morph>
              <template #icon>
                <IonIcon :icon="addOutline" />
              </template>
              <template #morph-content>
                <div style="padding: 60px 40px; color: white; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; text-align: center;">
                  <h2 style="color: white; margin-bottom: 16px; font-size: 32px;">Create New Item</h2>
                  <p style="font-size: 18px; max-width: 400px; line-height: 1.5;">This is the fullscreen morph content. The button expands to fill the entire screen, and you can render anything you need right here!</p>
                  
                  <div style="margin-top: 40px; display: flex; gap: 16px;">
                     <PPButton variant="soft" style="background: rgba(255,255,255,0.2); color: white;">Save Draft</PPButton>
                     <PPButton variant="secondary" style="background: white; color: var(--pp-primary-variant, #1a2a5e);">Publish Now</PPButton>
                  </div>
                </div>
              </template>
            </PPFab>

          </div>
          <pre class="code-block" v-pre><code>&lt;!-- Different Shapes --&gt;
&lt;PPFab shape="circle"&gt;&lt;/PPFab&gt;
&lt;PPFab shape="rounded"&gt;&lt;/PPFab&gt;
&lt;PPFab shape="square"&gt;&lt;/PPFab&gt;

&lt;!-- Morph Animation --&gt;
&lt;PPFab morph color="primary"&gt;
  &lt;template #icon&gt;
    &lt;IonIcon :icon="addOutline" /&gt;
  &lt;/template&gt;
  &lt;template #morph-content&gt;
    &lt;div class="fullscreen-content"&gt;...&lt;/div&gt;
  &lt;/template&gt;
&lt;/PPFab&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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
        &lt;h2&gt;Floating Action Button (FAB)&lt;/h2&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard FAB &amp; Speed Dial&lt;/h3&gt;
          &lt;div class="component-demo" style="min-height: 400px; position: relative;"&gt;
            
            &lt;!-- Standard --&gt;
            &lt;PPFab position="bottom-right" variant="solid" color="primary"&gt;
              &lt;template #list&gt;
                &lt;PPFabList side="top"&gt;
                  &lt;PPFabAction color="primary" @click="alertVal('Action 1')"&gt;1&lt;/PPFabAction&gt;
                  &lt;PPFabAction color="danger" @click="alertVal('Action 2')"&gt;2&lt;/PPFabAction&gt;
                &lt;/PPFabList&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;
            
            &lt;!-- Extended --&gt;
            &lt;PPFab position="bottom-left" color="secondary" :extended="isExtended"&gt;
              Extended FAB
            &lt;/PPFab&gt;

            &lt;!-- Gradient Variant --&gt;
            &lt;PPFab position="center" variant="gradient" style="margin-top: -120px;"&gt;
              &lt;template #icon&gt;
                &lt;IonIcon :icon="rocketOutline" /&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;

            &lt;!-- Soft Variant --&gt;
            &lt;PPFab position="center" variant="soft" style="margin-left: -100px; margin-top: 40px;"&gt;
              &lt;template #icon&gt;
                &lt;IonIcon :icon="layersOutline" /&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;

            &lt;!-- Outline Variant --&gt;
            &lt;PPFab position="center" variant="outline" style="margin-left: 100px; margin-top: 40px;"&gt;
              &lt;template #icon&gt;
                &lt;IonIcon :icon="searchOutline" /&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;

            &lt;!-- Glass Variant --&gt;
            &lt;!-- Glass looks best on an image or pattern, but we'll demonstrate it here --&gt;
            &lt;div style="position: absolute; top: 20px; right: 20px; width: 100px; height: 100px; background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center;"&gt;
              &lt;PPFab position="center" variant="glass" style="position: relative; top: 0; left: 0; transform: none;"&gt;
                &lt;template #icon&gt;
                  &lt;IonIcon :icon="chatbubbleOutline" /&gt;
                &lt;/template&gt;
              &lt;/PPFab&gt;
            &lt;/div&gt;
            
            &lt;div style="padding-bottom: 20px; position: relative; z-index: 10;"&gt;
              &lt;PPButton @click="isExtended = !isExtended"&gt;Toggle Extended FAB&lt;/PPButton&gt;
            &lt;/div&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPFab position="bottom-right"&amp;gt;
  &amp;lt;template #list&amp;gt;
    &amp;lt;PPFabList side="top"&amp;gt;
      &amp;lt;PPFabAction color="primary" @click="doSomething"&amp;gt;1&amp;lt;/PPFabAction&amp;gt;
    &amp;lt;/PPFabList&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPFab&amp;gt;

&amp;lt;PPFab position="bottom-left" color="secondary" :extended="isExtended"&amp;gt;
  Extended FAB
&amp;lt;/PPFab&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Circle Speed Dial&lt;/h3&gt;
          &lt;div class="component-demo" style="min-height: 400px; position: relative;"&gt;
            &lt;p style="text-align: center; margin-bottom: 24px; color: #6b7280;"&gt;Click the center FAB to see the actions expand in a circle.&lt;/p&gt;

            &lt;!-- Full Circle Speed Dial --&gt;
            &lt;PPFab position="center" color="primary"&gt;
              &lt;template #icon&gt;
                &lt;IonIcon :icon="addOutline" /&gt;
              &lt;/template&gt;
              &lt;template #list&gt;
                &lt;PPFabList side="circle" :circleRadius="80"&gt;
                  &lt;PPFabAction color="primary"&gt;&lt;IonIcon :icon="shareOutline" /&gt;&lt;/PPFabAction&gt;
                  &lt;PPFabAction color="danger"&gt;&lt;IonIcon :icon="trashOutline" /&gt;&lt;/PPFabAction&gt;
                  &lt;PPFabAction color="secondary"&gt;&lt;IonIcon :icon="documentTextOutline" /&gt;&lt;/PPFabAction&gt;
                  &lt;PPFabAction color="light"&gt;&lt;IonIcon :icon="personOutline" /&gt;&lt;/PPFabAction&gt;
                  &lt;PPFabAction color="light"&gt;&lt;IonIcon :icon="settingsOutline" /&gt;&lt;/PPFabAction&gt;
                &lt;/PPFabList&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;
            
            &lt;!-- Semi-Circle Speed Dial (Top) --&gt;
            &lt;PPFab position="bottom-right" color="danger"&gt;
              &lt;template #icon&gt;
                &lt;IonIcon :icon="addOutline" /&gt;
              &lt;/template&gt;
              &lt;template #list&gt;
                &lt;!-- A top semi-circle uses angles from -90 to 90. --&gt;
                &lt;PPFabList side="circle" :circleStartAngle="-90" :circleEndAngle="0" :circleRadius="90"&gt;
                  &lt;PPFabAction color="light"&gt;&lt;IonIcon :icon="chatbubbleOutline" /&gt;&lt;/PPFabAction&gt;
                  &lt;PPFabAction color="light"&gt;&lt;IonIcon :icon="phonePortraitOutline" /&gt;&lt;/PPFabAction&gt;
                  &lt;PPFabAction color="light"&gt;&lt;IonIcon :icon="personOutline" /&gt;&lt;/PPFabAction&gt;
                &lt;/PPFabList&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;

          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;!-- Full Circle Speed Dial --&amp;gt;
&amp;lt;PPFab position="center"&amp;gt;
  &amp;lt;template #list&amp;gt;
    &amp;lt;PPFabList side="circle" :circleRadius="80"&amp;gt;
      &amp;lt;PPFabAction&amp;gt;1&amp;lt;/PPFabAction&amp;gt;
      &amp;lt;PPFabAction&amp;gt;2&amp;lt;/PPFabAction&amp;gt;
      &amp;lt;PPFabAction&amp;gt;3&amp;lt;/PPFabAction&amp;gt;
      &amp;lt;PPFabAction&amp;gt;4&amp;lt;/PPFabAction&amp;gt;
    &amp;lt;/PPFabList&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPFab&amp;gt;

&amp;lt;!-- Quarter/Semi Circle Speed Dial --&amp;gt;
&amp;lt;PPFab position="bottom-right"&amp;gt;
  &amp;lt;template #list&amp;gt;
    &amp;lt;PPFabList side="circle" :circleStartAngle="-90" :circleEndAngle="0" :circleRadius="90"&amp;gt;
      &amp;lt;PPFabAction&amp;gt;1&amp;lt;/PPFabAction&amp;gt;
      &amp;lt;PPFabAction&amp;gt;2&amp;lt;/PPFabAction&amp;gt;
      &amp;lt;PPFabAction&amp;gt;3&amp;lt;/PPFabAction&amp;gt;
    &amp;lt;/PPFabList&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPFab&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Shapes and Morph Animation&lt;/h3&gt;
          &lt;div class="component-demo" style="min-height: 400px; position: relative; overflow: hidden; transform: translateZ(0);"&gt;
            
            &lt;!-- Rounded Shape --&gt;
            &lt;PPFab position="top-right" color="danger" shape="rounded"&gt;
              &lt;template #icon&gt;
                &lt;IonIcon :icon="trashOutline" /&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;
            
            &lt;!-- Square Shape --&gt;
            &lt;PPFab position="top-left" color="secondary" shape="square"&gt;
              &lt;template #icon&gt;
                &lt;IonIcon :icon="documentTextOutline" /&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;

            &lt;!-- Morph Animation to Full Screen --&gt;
            &lt;PPFab position="center" color="primary" morph&gt;
              &lt;template #icon&gt;
                &lt;IonIcon :icon="addOutline" /&gt;
              &lt;/template&gt;
              &lt;template #morph-content&gt;
                &lt;div style="padding: 60px 40px; color: white; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; text-align: center;"&gt;
                  &lt;h2 style="color: white; margin-bottom: 16px; font-size: 32px;"&gt;Create New Item&lt;/h2&gt;
                  &lt;p style="font-size: 18px; max-width: 400px; line-height: 1.5;"&gt;This is the fullscreen morph content. The button expands to fill the entire screen, and you can render anything you need right here!&lt;/p&gt;
                  
                  &lt;div style="margin-top: 40px; display: flex; gap: 16px;"&gt;
                     &lt;PPButton variant="soft" style="background: rgba(255,255,255,0.2); color: white;"&gt;Save Draft&lt;/PPButton&gt;
                     &lt;PPButton variant="secondary" style="background: white; color: var(--pp-primary-variant, #1a2a5e);"&gt;Publish Now&lt;/PPButton&gt;
                  &lt;/div&gt;
                &lt;/div&gt;
              &lt;/template&gt;
            &lt;/PPFab&gt;

          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;!-- Different Shapes --&amp;gt;
&amp;lt;PPFab shape="circle"&amp;gt;&amp;lt;/PPFab&amp;gt;
&amp;lt;PPFab shape="rounded"&amp;gt;&amp;lt;/PPFab&amp;gt;
&amp;lt;PPFab shape="square"&amp;gt;&amp;lt;/PPFab&amp;gt;

&amp;lt;!-- Morph Animation --&amp;gt;
&amp;lt;PPFab morph color="primary"&amp;gt;
  &amp;lt;template #icon&amp;gt;
    &amp;lt;IonIcon :icon="addOutline" /&amp;gt;
  &amp;lt;/template&amp;gt;
  &amp;lt;template #morph-content&amp;gt;
    &amp;lt;div class="fullscreen-content"&amp;gt;...&amp;lt;/div&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPFab&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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

const alertVal = (type: string) =&gt; console.log('Setup: ' + type);
const isExtended = ref(true);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.component-demo {
  position: relative;
  min-height: 200px;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
  overflow: hidden;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const alertVal = (type: string) => console.log('Setup: ' + type);
const isExtended = ref(true);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.component-demo {
  position: relative;
  min-height: 200px;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
  overflow: hidden;
}
</style>
