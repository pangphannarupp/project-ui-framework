<template>
<div class="guide-section">
        <p class="guide-desc">A flexible container for hiding and showing content panels.</p>

        <div class="variant-group">
          <h3>Standard Mode (Multiple Open)</h3>
          <p class="custom-guide">Multiple panels can be expanded simultaneously.</p>
          <div class="component-demo">
            <PPCollapse v-model="collapseModel1">
              <PPCollapseItem name="1" title="Panel 1">
                Content for Panel 1. This can contain text, forms, or any other components.
              </PPCollapseItem>
              <PPCollapseItem name="2" title="Panel 2">
                Content for Panel 2.
              </PPCollapseItem>
              <PPCollapseItem name="3" title="Panel 3 (Disabled)" disabled>
                You shouldn't see this.
              </PPCollapseItem>
            </PPCollapse>
            <p style="margin-top: 16px; font-size: 12px; color: #666;">Active panels: {{ collapseModel1 }}</p>
          </div>
          <pre class="code-block"><code>&lt;PPCollapse v-model="collapseModel1"&gt;
  &lt;PPCollapseItem name="1" title="Panel 1"&gt;
    Content for Panel 1. This can contain text, forms, or any other components.
  &lt;/PPCollapseItem&gt;
  &lt;PPCollapseItem name="2" title="Panel 2"&gt;
    Content for Panel 2.
  &lt;/PPCollapseItem&gt;
  &lt;PPCollapseItem name="3" title="Panel 3 (Disabled)" disabled&gt;
    You shouldn't see this.
  &lt;/PPCollapseItem&gt;
&lt;/PPCollapse&gt;</code></pre>
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Accordion Mode (Single Open)</h3>
          <p class="custom-guide">Only one panel can be open at a time.</p>
          <div class="component-demo">
            <PPCollapse v-model="collapseModel2" accordion>
              <PPCollapseItem name="A" title="Section A">
                Content for Section A.
              </PPCollapseItem>
              <PPCollapseItem name="B">
                <template #title>
                  <strong style="color: var(--pp-primary-color);">Custom Header B</strong>
                </template>
                Content for Section B.
              </PPCollapseItem>
              <PPCollapseItem name="C" title="Section C">
                Content for Section C.
              </PPCollapseItem>
            </PPCollapse>
            <p style="margin-top: 16px; font-size: 12px; color: #666;">Active panel: {{ collapseModel2 }}</p>
          </div>
          <pre class="code-block"><code>&lt;PPCollapse v-model="collapseModel2" accordion&gt;
  &lt;PPCollapseItem name="A" title="Section A"&gt;
    Content for Section A.
  &lt;/PPCollapseItem&gt;
  &lt;PPCollapseItem name="B"&gt;
    &lt;template #title&gt;
      &lt;strong style="color: var(--pp-primary-color);"&gt;Custom Header B&lt;/strong&gt;
    &lt;/template&gt;
    Content for Section B.
  &lt;/PPCollapseItem&gt;
  &lt;PPCollapseItem name="C" title="Section C"&gt;
    Content for Section C.
  &lt;/PPCollapseItem&gt;
&lt;/PPCollapse&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const collapseModel1 = ref(['1']);

const collapseModel2 = ref('A');



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
