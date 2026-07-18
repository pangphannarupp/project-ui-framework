<template>
<div class="guide-section">
        <h2>Collapse / Accordion</h2>
        <p class="guide-desc">A flexible container for hiding and showing content panels.</p>

        <div class="variant-group">
          <h3>Standard Mode (Multiple Open)</h3>
          <p class="custom-guide">Multiple panels can be expanded simultaneously.</p>
          <div class="component-demo">
            <BizCollapse v-model="collapseModel1">
              <BizCollapseItem name="1" title="Panel 1">
                Content for Panel 1. This can contain text, forms, or any other components.
              </BizCollapseItem>
              <BizCollapseItem name="2" title="Panel 2">
                Content for Panel 2.
              </BizCollapseItem>
              <BizCollapseItem name="3" title="Panel 3 (Disabled)" disabled>
                You shouldn't see this.
              </BizCollapseItem>
            </BizCollapse>
            <p style="margin-top: 16px; font-size: 12px; color: #666;">Active panels: {{ collapseModel1 }}</p>
          </div>
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Accordion Mode (Single Open)</h3>
          <p class="custom-guide">Only one panel can be open at a time.</p>
          <div class="component-demo">
            <BizCollapse v-model="collapseModel2" accordion>
              <BizCollapseItem name="A" title="Section A">
                Content for Section A.
              </BizCollapseItem>
              <BizCollapseItem name="B">
                <template #title>
                  <strong style="color: var(--biz-primary-color);">Custom Header B</strong>
                </template>
                Content for Section B.
              </BizCollapseItem>
              <BizCollapseItem name="C" title="Section C">
                Content for Section C.
              </BizCollapseItem>
            </BizCollapse>
            <p style="margin-top: 16px; font-size: 12px; color: #666;">Active panel: {{ collapseModel2 }}</p>
          </div>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const collapseModel1 = ref(['1']);

const collapseModel2 = ref('A');



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
