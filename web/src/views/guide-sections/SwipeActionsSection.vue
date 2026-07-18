<template>
<div class="guide-section">
        <h2>Swipe Actions (List Items)</h2>
        <div class="variant-group">
          <h3>Swipe Left & Right</h3>
          <p class="custom-guide">Swipe horizontally to reveal actions. Supports rubber-banding physics.</p>
          <div class="component-demo" style="padding: 0; background: transparent; border-radius: 12px; overflow: hidden; border: 1px solid #eee;">
            <BizSwipeItem style="border-bottom: 1px solid #eee;">
              <template #left>
                <div style="background: #28ba62;" @click="alertVal('Pinned!')">
                  Pin
                </div>
              </template>
              <template #right>
                <div style="background: #ffc409; color: #333;" @click="alertVal('Edited!')">
                  Edit
                </div>
                <div style="background: #eb445a;" @click="alertVal('Deleted!')">
                  Delete
                </div>
              </template>
              <div style="padding: 16px; background: white;">
                <h4 style="margin: 0; color: #333;">Swipe me both ways</h4>
                <p style="margin: 4px 0 0; color: #666; font-size: 14px;">I have actions on both sides!</p>
              </div>
            </BizSwipeItem>
            
            <BizSwipeItem>
              <template #right>
                <div style="background: #eb445a;" @click="alertVal('Deleted!')">
                  Delete
                </div>
              </template>
              <div style="padding: 16px; background: white;">
                <h4 style="margin: 0; color: #333;">Swipe me left only</h4>
                <p style="margin: 4px 0 0; color: #666; font-size: 14px;">Only a delete button on the right.</p>
              </div>
            </BizSwipeItem>
          </div>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
