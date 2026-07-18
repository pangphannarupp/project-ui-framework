<template>
<div class="guide-section">
        <h2>Sliders</h2>
        <p class="guide-desc">A highly customizable slider component supporting single values, ranges, steps, and pins.</p>

        <div class="variant-group">
          <h3>Standard & Range</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <BizSlider v-model="sliderVal1" label="Standard" :showValue="true" />
            <BizSlider v-model="sliderVal2" label="Dual Knobs (Range)" :dualKnobs="true" :showValue="true" />
          </div>
        </div>

        <div class="variant-group">
          <h3>Snaps, Pins & Icons</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <BizSlider v-model="sliderVal3" label="Stepped with Pins" :min="0" :max="100" :step="10" :snaps="true" :pin="true" :ticks="true" />
            <BizSlider v-model="sliderVal1" :startIcon="volumeLowOutline" :endIcon="volumeHighOutline" color="secondary" />
            <BizSlider v-model="sliderVal1" label="Disabled Slider" :disabled="true" />
          </div>
        </div>
        <div class="variant-group">
          <h3>Material 3 Style</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <BizSlider v-model="sliderVal1" label="M3 Thick Track Slider" variant="m3" :showValue="true" />
            <BizSlider v-model="sliderVal2" label="M3 Range Slider" variant="m3" :dualKnobs="true" :showValue="true" />
          </div>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const sliderVal1 = ref(50);

const sliderVal2 = ref({ lower: 20, upper: 80 });

const sliderVal3 = ref(30);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
