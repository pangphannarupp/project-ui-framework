<template>
<div class="guide-section">
        <h2>7. Structural Components</h2>

        <div class="variant-group">
          <h3>BizSegment (Toggle)</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <BizSegment v-model="segmentVal" style="--biz-segment-bg: white;">
              <BizSegmentButton value="opt1">Option 1</BizSegmentButton>
              <BizSegmentButton value="opt2">Option 2</BizSegmentButton>
            </BizSegment>
          </div>
          <pre class="code-block"><code>&lt;BizSegment v-model="val"&gt;
  &lt;BizSegmentButton value="1"&gt;Tab 1&lt;/BizSegmentButton&gt;
&lt;/BizSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizAnimatedSegment</h3>
          <p class="custom-guide">Wraps BizSegment to provide smooth animated transitions between content sections.</p>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px; height: 180px;">
            <BizAnimatedSegment v-model="animatedSegmentVal" :segments="animatedSegments">
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
            </BizAnimatedSegment>
          </div>
          <pre class="code-block"><code>&lt;BizAnimatedSegment v-model="val" :segments="segments"&gt;
  &lt;template #segment-opt1&gt;...&lt;/template&gt;
&lt;/BizAnimatedSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizCompanySelector</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <BizCompanySelector companyName="CHOKCHEY FINANCE PLC" companyType="Individual" />
          </div>
          <pre class="code-block"><code>&lt;BizCompanySelector 
  companyName="CHOKCHEY" 
  companyType="Individual" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizUserProfile</h3>
          <div class="component-demo" style="background: var(--biz-primary, #003399); padding: 20px; border-radius: 12px;">
            <BizUserProfile userName="SOM MONYROTTANA" role="Master User" :isVerified="true" />
          </div>
          <pre class="code-block"><code>&lt;BizUserProfile 
  userName="Name" 
  role="Master User" 
  :isVerified="true" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizBottomSheet (Action Menu)</h3>
          <p class="custom-guide" style="margin-bottom: 8px;"><strong>Props:</strong> <code>title</code>, <code>modelValue</code> (controls visibility)</p>
          <div class="component-demo">
            <BizButton variant="secondary" @click="showBottomSheet = true">Open Standard Bottom Sheet</BizButton>
            
            <!-- We render the sheet locally for the demo -->
            <BizBottomSheet v-model="showBottomSheet" title="Select Action">
              <div style="padding: 16px; text-align: center;">
                <p>This is the content inside the bottom sheet.</p>
                <BizButton variant="primary" block @click="showBottomSheet = false">Close</BizButton>
              </div>
            </BizBottomSheet>
          </div>
          <pre class="code-block"><code>&lt;BizBottomSheet v-model="isOpen" title="Select Action"&gt;...&lt;/BizBottomSheet&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizBiometricSheet</h3>
          <p class="custom-guide" style="margin-bottom: 8px;"><strong>Props:</strong> <code>type</code> ('both', 'face', 'fingerprint')</p>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;">
            <BizButton variant="outline" @click="showBioBoth = true">Open Biometric (Both)</BizButton>
            <BizButton variant="outline" @click="showBioFace = true">Open Biometric (Face ID)</BizButton>
            <BizButton variant="outline" @click="showBioFinger = true">Open Biometric (Fingerprint ID)</BizButton>
            
            <BizBiometricSheet v-model="showBioBoth" type="both" @setup="alertVal" />
            <BizBiometricSheet v-model="showBioFace" type="face" @setup="alertVal" />
            <BizBiometricSheet v-model="showBioFinger" type="fingerprint" @setup="alertVal" />
          </div>
          <pre class="code-block"><code>&lt;BizBiometricSheet 
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

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
