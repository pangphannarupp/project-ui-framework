<template>
<div class="guide-section">
        <h2>Swipe Actions (List Items)</h2>
        <div class="variant-group">
          <h3>Swipe Left & Right</h3>
          <p class="custom-guide">Swipe horizontally to reveal actions. Supports rubber-banding physics.</p>
          <div class="component-demo" style="padding: 0; background: transparent; border-radius: 12px; overflow: hidden; border: 1px solid #eee;">
            <PPSwipeItem style="border-bottom: 1px solid #eee;">
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
            </PPSwipeItem>
            
            <PPSwipeItem>
              <template #right>
                <div style="background: #eb445a;" @click="alertVal('Deleted!')">
                  Delete
                </div>
              </template>
              <div style="padding: 16px; background: white;">
                <h4 style="margin: 0; color: #333;">Swipe me left only</h4>
                <p style="margin: 4px 0 0; color: #666; font-size: 14px;">Only a delete button on the right.</p>
              </div>
            </PPSwipeItem>
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

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
