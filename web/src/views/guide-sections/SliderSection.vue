<template>
<div class="guide-section">
        <h2>Sliders</h2>
        <p class="guide-desc">A highly customizable slider component supporting single values, ranges, steps, and pins.</p>

        <div class="variant-group">
          <h3>Standard & Range</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <PPSlider v-model="sliderVal1" label="Standard" :showValue="true" />
            <PPSlider v-model="sliderVal2" label="Dual Knobs (Range)" :dualKnobs="true" :showValue="true" />
          </div>
          <pre class="code-block"><code>&lt;template&gt;
  &lt;PPSlider v-model="sliderVal1" label="Standard" :showValue="true" /&gt;
  &lt;PPSlider v-model="sliderVal2" label="Dual Knobs (Range)" :dualKnobs="true" :showValue="true" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
const sliderVal1 = ref(50);
const sliderVal2 = ref({ lower: 20, upper: 80 });
&lt;/script&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Snaps, Pins & Icons</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <PPSlider v-model="sliderVal3" label="Stepped with Pins" :min="0" :max="100" :step="10" :snaps="true" :pin="true" :ticks="true" />
            <PPSlider v-model="sliderVal1" :startIcon="volumeLowOutline" :endIcon="volumeHighOutline" color="secondary" />
            <PPSlider v-model="sliderVal1" label="Disabled Slider" :disabled="true" />
          </div>
          <pre class="code-block"><code>&lt;template&gt;
  &lt;PPSlider v-model="sliderVal3" label="Stepped with Pins" :min="0" :max="100" :step="10" :snaps="true" :pin="true" :ticks="true" /&gt;
  &lt;PPSlider v-model="sliderVal1" :startIcon="volumeLowOutline" :endIcon="volumeHighOutline" color="secondary" /&gt;
  &lt;PPSlider v-model="sliderVal1" label="Disabled Slider" :disabled="true" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { volumeLowOutline, volumeHighOutline } from 'ionicons/icons';
const sliderVal1 = ref(50);
const sliderVal3 = ref(30);
&lt;/script&gt;</code></pre>
        </div>
        <div class="variant-group">
          <h3>Material 3 Style</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <PPSlider v-model="sliderVal1" label="M3 Thick Track Slider" variant="m3" :showValue="true" />
            <PPSlider v-model="sliderVal2" label="M3 Range Slider" variant="m3" :dualKnobs="true" :showValue="true" />
          </div>
          <pre class="code-block"><code>&lt;template&gt;
  &lt;PPSlider v-model="sliderVal1" label="M3 Thick Track Slider" variant="m3" :showValue="true" /&gt;
  &lt;PPSlider v-model="sliderVal2" label="M3 Range Slider" variant="m3" :dualKnobs="true" :showValue="true" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
const sliderVal1 = ref(50);
const sliderVal2 = ref({ lower: 20, upper: 80 });
&lt;/script&gt;</code></pre>
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

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
