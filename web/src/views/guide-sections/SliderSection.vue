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
          <pre class="code-block" v-pre><code>&lt;template&gt;
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
          <pre class="code-block" v-pre><code>&lt;template&gt;
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
          <pre class="code-block" v-pre><code>&lt;template&gt;
  &lt;PPSlider v-model="sliderVal1" label="M3 Thick Track Slider" variant="m3" :showValue="true" /&gt;
  &lt;PPSlider v-model="sliderVal2" label="M3 Range Slider" variant="m3" :dualKnobs="true" :showValue="true" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
const sliderVal1 = ref(50);
const sliderVal2 = ref({ lower: 20, upper: 80 });
&lt;/script&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary: /* value */;
  --pp-primary-rgb: /* value */;
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
        &lt;h2&gt;Sliders&lt;/h2&gt;
        &lt;p class="guide-desc"&gt;A highly customizable slider component supporting single values, ranges, steps, and pins.&lt;/p&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard &amp; Range&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;"&gt;
            &lt;PPSlider v-model="sliderVal1" label="Standard" :showValue="true" /&gt;
            &lt;PPSlider v-model="sliderVal2" label="Dual Knobs (Range)" :dualKnobs="true" :showValue="true" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSlider v-model="sliderVal1" label="Standard" :showValue="true" /&amp;gt;
  &amp;lt;PPSlider v-model="sliderVal2" label="Dual Knobs (Range)" :dualKnobs="true" :showValue="true" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
const sliderVal1 = ref(50);
const sliderVal2 = ref({ lower: 20, upper: 80 });
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Snaps, Pins &amp; Icons&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;"&gt;
            &lt;PPSlider v-model="sliderVal3" label="Stepped with Pins" :min="0" :max="100" :step="10" :snaps="true" :pin="true" :ticks="true" /&gt;
            &lt;PPSlider v-model="sliderVal1" :startIcon="volumeLowOutline" :endIcon="volumeHighOutline" color="secondary" /&gt;
            &lt;PPSlider v-model="sliderVal1" label="Disabled Slider" :disabled="true" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSlider v-model="sliderVal3" label="Stepped with Pins" :min="0" :max="100" :step="10" :snaps="true" :pin="true" :ticks="true" /&amp;gt;
  &amp;lt;PPSlider v-model="sliderVal1" :startIcon="volumeLowOutline" :endIcon="volumeHighOutline" color="secondary" /&amp;gt;
  &amp;lt;PPSlider v-model="sliderVal1" label="Disabled Slider" :disabled="true" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { volumeLowOutline, volumeHighOutline } from 'ionicons/icons';
const sliderVal1 = ref(50);
const sliderVal3 = ref(30);
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Material 3 Style&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;"&gt;
            &lt;PPSlider v-model="sliderVal1" label="M3 Thick Track Slider" variant="m3" :showValue="true" /&gt;
            &lt;PPSlider v-model="sliderVal2" label="M3 Range Slider" variant="m3" :dualKnobs="true" :showValue="true" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSlider v-model="sliderVal1" label="M3 Thick Track Slider" variant="m3" :showValue="true" /&amp;gt;
  &amp;lt;PPSlider v-model="sliderVal2" label="M3 Range Slider" variant="m3" :dualKnobs="true" :showValue="true" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
const sliderVal1 = ref(50);
const sliderVal2 = ref({ lower: 20, upper: 80 });
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary: /* value */;
  --pp-primary-rgb: /* value */;
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

const sliderVal1 = ref(50);

const sliderVal2 = ref({ lower: 20, upper: 80 });

const sliderVal3 = ref(30);



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

const sliderVal1 = ref(50);

const sliderVal2 = ref({ lower: 20, upper: 80 });

const sliderVal3 = ref(30);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
