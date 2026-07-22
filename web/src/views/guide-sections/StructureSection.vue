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
          <pre class="code-block"><code>&lt;PPSegment v-model="val"&gt;
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
          <pre class="code-block"><code>&lt;PPAnimatedSegment v-model="val" :segments="segments"&gt;
  &lt;template #segment-opt1&gt;...&lt;/template&gt;
&lt;/PPAnimatedSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPCompanySelector</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <PPCompanySelector companyName="CHOKCHEY FINANCE PLC" companyType="Individual" />
          </div>
          <pre class="code-block"><code>&lt;PPCompanySelector 
  companyName="CHOKCHEY" 
  companyType="Individual" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPUserProfile</h3>
          <div class="component-demo" style="background: var(--pp-primary, #003399); padding: 20px; border-radius: 12px;">
            <PPUserProfile userName="SOM MONYROTTANA" role="Master User" :isVerified="true" />
          </div>
          <pre class="code-block"><code>&lt;PPUserProfile 
  userName="Name" 
  role="Master User" 
  :isVerified="true" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPBottomSheet (Action Menu)</h3>
          <p class="custom-guide" style="margin-bottom: 8px;"><strong>Props:</strong> <code>title</code>, <code>modelValue</code> (controls visibility)</p>
          <div class="component-demo">
            <PPButton variant="secondary" @click="showBottomSheet = true">Open Standard Bottom Sheet</PPButton>
            
            <!-- We render the sheet locally for the demo -->
            <PPBottomSheet v-model="showBottomSheet" title="Select Action">
              <div style="padding: 16px; text-align: center;">
                <p>This is the content inside the bottom sheet.</p>
                <PPButton variant="primary" block @click="showBottomSheet = false">Close</PPButton>
              </div>
            </PPBottomSheet>
          </div>
          <pre class="code-block"><code>&lt;PPBottomSheet v-model="isOpen" title="Select Action"&gt;...&lt;/PPBottomSheet&gt;</code></pre>
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
          <pre class="code-block"><code>&lt;PPBiometricSheet 
  v-model="isOpen" 
  type="both" 
  @setup="handleSetup" 
/&gt;</code></pre>
        </div>


      </div>
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
