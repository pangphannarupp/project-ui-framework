<template>
<div class="guide-section">
        <h2>7. Structural Components</h2>

        <div class="variant-group">
          <h3>PPSegment (Toggle)</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <PPSegment v-model="segmentVal" style="--pp-segment-bg: white;">
              <PPSegmentButton value="opt1">Option 1</PPSegmentButton>
              <PPSegmentButton value="opt2">Option 2</PPSegmentButton>
            </PPSegment>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPSegment v-model="val"&gt;
  &lt;PPSegmentButton value="1"&gt;Tab 1&lt;/PPSegmentButton&gt;
&lt;/PPSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPAnimatedSegment</h3>
          <p class="custom-guide">Wraps PPSegment to provide smooth animated transitions between content sections.</p>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px; height: 180px;">
            <PPAnimatedSegment v-model="animatedSegmentVal" :segments="animatedSegments">
              <template #segment-opt1>
                <div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                  <h4 style="margin-top:0;">Option 1 Content</h4>
                  <p style="margin-bottom:0;">This content slides in smoothly!</p>
                </div>
              </template>
              <template #segment-opt2>
                <div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                  <h4 style="margin-top:0;">Option 2 Content</h4>
                  <p style="margin-bottom:0;">Here is some different content.</p>
                </div>
              </template>
              <template #segment-opt3>
                <div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                  <h4 style="margin-top:0;">Option 3 Content</h4>
                  <p style="margin-bottom:0;">And even more content.</p>
                </div>
              </template>
            </PPAnimatedSegment>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPAnimatedSegment v-model="val" :segments="segments"&gt;
  &lt;template #segment-opt1&gt;...&lt;/template&gt;
&lt;/PPAnimatedSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPCompanySelector</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <PPCompanySelector companyName="CHOKCHEY FINANCE PLC" companyType="Individual" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCompanySelector 
  companyName="CHOKCHEY" 
  companyType="Individual" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPUserProfile</h3>
          <div class="component-demo" style="background: var(--pp-primary, #003399); padding: 20px; border-radius: 12px;">
            <PPUserProfile userName="SOM MONYROTTANA" role="Master User" :isVerified="true" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPUserProfile 
  userName="Name" 
  role="Master User" 
  :isVerified="true" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPBottomSheet (Action Menu)</h3>
          <p class="custom-guide" style="margin-bottom: 8px;"><strong>Props:</strong> <code>title</code>, <code>modelValue</code>, <code>backdropType</code></p>
          <div class="component-demo">
            <PPButton variant="secondary" @click="openSheet('default')" style="margin-right: 8px; margin-bottom: 8px;">Default Backdrop</PPButton>
            <PPButton variant="secondary" @click="openSheet('blur')" style="margin-right: 8px; margin-bottom: 8px;">Blur Backdrop</PPButton>
            <PPButton variant="secondary" @click="openSheet('clear')" style="margin-right: 8px; margin-bottom: 8px;">Clear Backdrop</PPButton>
            <PPButton variant="secondary" @click="openSheet('black')" style="margin-right: 8px; margin-bottom: 8px;">Black Backdrop</PPButton>
            
            <!-- We render the sheet locally for the demo -->
            <PPBottomSheet v-model="showBottomSheet" title="Select Action" :backdropType="currentBackdrop">
              <div style="padding: 16px; text-align: center;">
                <p>This is the content inside the bottom sheet.</p>
                <PPButton variant="primary" block @click="showBottomSheet = false">Close</PPButton>
              </div>
            </PPBottomSheet>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBottomSheet v-model="isOpen" backdropType="blur" title="Select Action"&gt;...&lt;/PPBottomSheet&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPBiometricSheet</h3>
          <p class="custom-guide" style="margin-bottom: 8px;"><strong>Props:</strong> <code>type</code> ('both', 'face', 'fingerprint')</p>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;">
            <PPButton variant="outline" @click="showBioBoth = true">Open Biometric (Both)</PPButton>
            <PPButton variant="outline" @click="showBioFace = true">Open Biometric (Face ID)</PPButton>
            <PPButton variant="outline" @click="showBioFinger = true">Open Biometric (Fingerprint ID)</PPButton>
            
            <PPBiometricSheet v-model="showBioBoth" type="both" @setup="alertVal" />
            <PPBiometricSheet v-model="showBioFace" type="face" @setup="alertVal" />
            <PPBiometricSheet v-model="showBioFinger" type="fingerprint" @setup="alertVal" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPBiometricSheet 
  v-model="isOpen" 
  type="both" 
  @setup="handleSetup" 
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
        &lt;h2&gt;7. Structural Components&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPSegment (Toggle)&lt;/h3&gt;
          &lt;div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;"&gt;
            &lt;PPSegment v-model="segmentVal" style="--pp-segment-bg: white;"&gt;
              &lt;PPSegmentButton value="opt1"&gt;Option 1&lt;/PPSegmentButton&gt;
              &lt;PPSegmentButton value="opt2"&gt;Option 2&lt;/PPSegmentButton&gt;
            &lt;/PPSegment&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSegment v-model="val"&amp;gt;
  &amp;lt;PPSegmentButton value="1"&amp;gt;Tab 1&amp;lt;/PPSegmentButton&amp;gt;
&amp;lt;/PPSegment&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPAnimatedSegment&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Wraps PPSegment to provide smooth animated transitions between content sections.&lt;/p&gt;
          &lt;div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px; height: 180px;"&gt;
            &lt;PPAnimatedSegment v-model="animatedSegmentVal" :segments="animatedSegments"&gt;
              &lt;template #segment-opt1&gt;
                &lt;div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);"&gt;
                  &lt;h4 style="margin-top:0;"&gt;Option 1 Content&lt;/h4&gt;
                  &lt;p style="margin-bottom:0;"&gt;This content slides in smoothly!&lt;/p&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;template #segment-opt2&gt;
                &lt;div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);"&gt;
                  &lt;h4 style="margin-top:0;"&gt;Option 2 Content&lt;/h4&gt;
                  &lt;p style="margin-bottom:0;"&gt;Here is some different content.&lt;/p&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;template #segment-opt3&gt;
                &lt;div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);"&gt;
                  &lt;h4 style="margin-top:0;"&gt;Option 3 Content&lt;/h4&gt;
                  &lt;p style="margin-bottom:0;"&gt;And even more content.&lt;/p&gt;
                &lt;/div&gt;
              &lt;/template&gt;
            &lt;/PPAnimatedSegment&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPAnimatedSegment v-model="val" :segments="segments"&amp;gt;
  &amp;lt;template #segment-opt1&amp;gt;...&amp;lt;/template&amp;gt;
&amp;lt;/PPAnimatedSegment&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPCompanySelector&lt;/h3&gt;
          &lt;div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;"&gt;
            &lt;PPCompanySelector companyName="CHOKCHEY FINANCE PLC" companyType="Individual" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCompanySelector 
  companyName="CHOKCHEY" 
  companyType="Individual" 
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPUserProfile&lt;/h3&gt;
          &lt;div class="component-demo" style="background: var(--pp-primary, #003399); padding: 20px; border-radius: 12px;"&gt;
            &lt;PPUserProfile userName="SOM MONYROTTANA" role="Master User" :isVerified="true" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPUserProfile 
  userName="Name" 
  role="Master User" 
  :isVerified="true" 
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPBottomSheet (Action Menu)&lt;/h3&gt;
          &lt;p class="custom-guide" style="margin-bottom: 8px;"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;title&lt;/code&gt;, &lt;code&gt;modelValue&lt;/code&gt;, &lt;code&gt;backdropType&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPButton variant="secondary" @click="openSheet('default')" style="margin-right: 8px; margin-bottom: 8px;"&gt;Default Backdrop&lt;/PPButton&gt;
            &lt;PPButton variant="secondary" @click="openSheet('blur')" style="margin-right: 8px; margin-bottom: 8px;"&gt;Blur Backdrop&lt;/PPButton&gt;
            &lt;PPButton variant="secondary" @click="openSheet('clear')" style="margin-right: 8px; margin-bottom: 8px;"&gt;Clear Backdrop&lt;/PPButton&gt;
            &lt;PPButton variant="secondary" @click="openSheet('black')" style="margin-right: 8px; margin-bottom: 8px;"&gt;Black Backdrop&lt;/PPButton&gt;
            
            &lt;!-- We render the sheet locally for the demo --&gt;
            &lt;PPBottomSheet v-model="showBottomSheet" title="Select Action" :backdropType="currentBackdrop"&gt;
              &lt;div style="padding: 16px; text-align: center;"&gt;
                &lt;p&gt;This is the content inside the bottom sheet.&lt;/p&gt;
                &lt;PPButton variant="primary" block @click="showBottomSheet = false"&gt;Close&lt;/PPButton&gt;
              &lt;/div&gt;
            &lt;/PPBottomSheet&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBottomSheet v-model="isOpen" backdropType="blur" title="Select Action"&amp;gt;...&amp;lt;/PPBottomSheet&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPBiometricSheet&lt;/h3&gt;
          &lt;p class="custom-guide" style="margin-bottom: 8px;"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;type&lt;/code&gt; ('both', 'face', 'fingerprint')&lt;/p&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;"&gt;
            &lt;PPButton variant="outline" @click="showBioBoth = true"&gt;Open Biometric (Both)&lt;/PPButton&gt;
            &lt;PPButton variant="outline" @click="showBioFace = true"&gt;Open Biometric (Face ID)&lt;/PPButton&gt;
            &lt;PPButton variant="outline" @click="showBioFinger = true"&gt;Open Biometric (Fingerprint ID)&lt;/PPButton&gt;
            
            &lt;PPBiometricSheet v-model="showBioBoth" type="both" @setup="alertVal" /&gt;
            &lt;PPBiometricSheet v-model="showBioFace" type="face" @setup="alertVal" /&gt;
            &lt;PPBiometricSheet v-model="showBioFinger" type="fingerprint" @setup="alertVal" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPBiometricSheet 
  v-model="isOpen" 
  type="both" 
  @setup="handleSetup" 
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

const animatedSegmentVal = ref('opt1');

const animatedSegments = ref([
  { label: 'Option 1', value: 'opt1' },
  { label: 'Option 2', value: 'opt2' },
  { label: 'Option 3', value: 'opt3' }
]);

const segmentVal = ref('opt1');

const showBottomSheet = ref(false);
const currentBackdrop = ref('default');

const openSheet = (type: string) =&gt; {
  currentBackdrop.value = type;
  showBottomSheet.value = true;
};

const showBioBoth = ref(false);

const showBioFace = ref(false);

const showBioFinger = ref(false);

const alertVal = (type: string) =&gt; console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const animatedSegmentVal = ref('opt1');

const animatedSegments = ref([
  { label: 'Option 1', value: 'opt1' },
  { label: 'Option 2', value: 'opt2' },
  { label: 'Option 3', value: 'opt3' }
]);

const segmentVal = ref('opt1');

const showBottomSheet = ref(false);
const currentBackdrop = ref('default');

const openSheet = (type: string) => {
  currentBackdrop.value = type;
  showBottomSheet.value = true;
};

const showBioBoth = ref(false);

const showBioFace = ref(false);

const showBioFinger = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
