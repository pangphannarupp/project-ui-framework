<template>
<div class="guide-section">
        <h2>Switches</h2>
        <p class="guide-desc">A toggle switch component supporting multiple platform styles and Material Design 3.</p>

        <div class="variant-group">
          <h3>Standard Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPSwitch v-model="switchVal1" label="Standard Toggle" />
            <PPSwitch v-model="switchVal1" label="iOS Mode Toggle" mode="ios" color="secondary" />
            <PPSwitch v-model="switchVal2" label="Disabled Toggle" :disabled="true" />
          </div>
          <pre class="code-block"><code>&lt;template&gt;
  &lt;PPSwitch v-model="switchVal1" label="Standard Toggle" /&gt;
  &lt;PPSwitch v-model="switchVal1" label="iOS Mode Toggle" mode="ios" color="secondary" /&gt;
  &lt;PPSwitch v-model="switchVal2" label="Disabled Toggle" :disabled="true" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
const switchVal1 = ref(false);
const switchVal2 = ref(true);
&lt;/script&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Material 3 & Icon Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPSwitch v-model="switchVal3" label="Material 3 Toggle" variant="m3" />
            <PPSwitch v-model="switchVal3" label="Icon Toggle" variant="icon" color="success" />
          </div>
          <pre class="code-block"><code>&lt;template&gt;
  &lt;PPSwitch v-model="switchVal3" label="Material 3 Toggle" variant="m3" /&gt;
  &lt;PPSwitch v-model="switchVal3" label="Icon Toggle" variant="icon" color="success" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
const switchVal3 = ref(false);
&lt;/script&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const switchVal1 = ref(false);

const switchVal2 = ref(true);

const switchVal3 = ref(false);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
