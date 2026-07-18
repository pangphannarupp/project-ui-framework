<template>
<div class="guide-section">
        <h2>9. Feedback & Action Sheets</h2>

        <div class="variant-group">
          <h3>BizToast</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>message</code>, <code>duration</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizButton @click="showToast = true">Trigger Toast</BizButton>
            <BizToast v-model="showToast" message="User has been deleted." />
          </div>
          <pre class="code-block"><code>&lt;BizToast v-model="showToast" message="User has been deleted." /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizConfirmSheet</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>title</code>, <code>subtitle</code>, <code>confirmText</code>, <code>cancelText</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizButton @click="showConfirmSheet = true">Trigger Confirm Sheet</BizButton>
            <BizConfirmSheet 
              v-model="showConfirmSheet" 
              title="Delete User?"
              subtitle="This action cannot be undone."
              confirmText="Delete"
              cancelText="Cancel"
            />
          </div>
          <pre class="code-block"><code>&lt;BizConfirmSheet 
  v-model="showConfirmSheet" 
  title="Delete User?"
  subtitle="This action cannot be undone."
  confirmText="Delete"
  cancelText="Cancel"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizReceiveAmountSheet</h3>
          <p class="custom-guide"><strong>Events:</strong> <code>@confirm</code> (emits payload with currency and amount)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizButton @click="showReceiveAmount = true">Trigger Receive Amount Sheet</BizButton>
            <BizReceiveAmountSheet 
              v-model="showReceiveAmount" 
              @confirm="val => alertVal(`Received ${val.currency} ${val.amount}`)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizReceiveAmountSheet 
  v-model="showReceiveAmount" 
  @confirm="handleConfirm" 
/&gt;</code></pre>
        </div>

      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const showToast = ref(false);

const showConfirmSheet = ref(false);

const showReceiveAmount = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
