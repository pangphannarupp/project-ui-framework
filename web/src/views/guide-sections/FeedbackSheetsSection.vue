<template>
<div class="guide-section">
        <h2>9. Feedback & Action Sheets</h2>

        <div class="variant-group">
          <h3>PPToast</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>message</code>, <code>duration</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <PPButton @click="showToast = true">Trigger Toast</PPButton>
            <PPToast v-model="showToast" message="User has been deleted." />
          </div>
          <pre class="code-block"><code>&lt;PPToast v-model="showToast" message="User has been deleted." /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPConfirmSheet</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>title</code>, <code>subtitle</code>, <code>confirmText</code>, <code>cancelText</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <PPButton @click="showConfirmSheet = true">Trigger Confirm Sheet</PPButton>
            <PPConfirmSheet 
              v-model="showConfirmSheet" 
              title="Delete User?"
              subtitle="This action cannot be undone."
              confirmText="Delete"
              cancelText="Cancel"
            />
          </div>
          <pre class="code-block"><code>&lt;PPConfirmSheet 
  v-model="showConfirmSheet" 
  title="Delete User?"
  subtitle="This action cannot be undone."
  confirmText="Delete"
  cancelText="Cancel"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPReceiveAmountSheet</h3>
          <p class="custom-guide"><strong>Events:</strong> <code>@confirm</code> (emits payload with currency and amount)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <PPButton @click="showReceiveAmount = true">Trigger Receive Amount Sheet</PPButton>
            <PPReceiveAmountSheet 
              v-model="showReceiveAmount" 
              @confirm="val => alertVal(`Received ${val.currency} ${val.amount}`)"
            />
          </div>
          <pre class="code-block"><code>&lt;PPReceiveAmountSheet 
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

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
