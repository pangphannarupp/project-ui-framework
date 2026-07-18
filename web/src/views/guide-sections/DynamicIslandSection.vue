<template>
<div class="guide-section">
        <h2>19. Dynamic Island</h2>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <p class="custom-guide">A fluid, shape-shifting popup that anchors to the top of the screen.</p>
          <div class="component-demo">
            <div style="display: flex; gap: 8px; margin-bottom: 16px; align-items: center; flex-wrap: wrap;">
              <div style="width: 200px;">
                <BizSelect v-model="islandPosition" :options="[{label: 'Top', value: 'top'}, {label: 'Bottom', value: 'bottom'}, {label: 'Left', value: 'left'}, {label: 'Right', value: 'right'}]" placeholder="Select Position" />
              </div>
              <BizCheckbox v-model="islandFullWidth">Full Width</BizCheckbox>
            </div>
            <BizButtonGroup>
              <BizButton @click="showIsland('minimal')">Minimal</BizButton>
              <BizButton @click="showIsland('compact')">Compact</BizButton>
              <BizButton @click="showIsland('expanded')">Expanded</BizButton>
              <BizButton variant="outline-danger" @click="isIslandOpen = false">Close</BizButton>
            </BizButtonGroup>

            <BizDynamicIsland 
              v-model="isIslandOpen"
              :state="islandState"
              :position="islandPosition"
              :fullWidth="islandFullWidth"
              :offset="16"
              :autoHideTimeout="islandState === 'expanded' ? 0 : 3000"
            >
              <!-- Compact Slots -->
              <template #compact-left>
                <div style="width: 24px; height: 24px; border-radius: 50%; background: #2dd36f; display: flex; align-items: center; justify-content: center;">
                  <ion-icon :icon="phonePortraitOutline" style="color: black; font-size: 14px;"></ion-icon>
                </div>
              </template>
              <template #compact-center>
                00:14
              </template>
              <template #compact-right>
                <ion-icon :icon="volumeHighOutline" style="color: #2dd36f; font-size: 20px;"></ion-icon>
              </template>

              <!-- Expanded Slots -->
              <template #expanded-header>
                <div style="display: flex; align-items: center; gap: 12px;">
                  <img src="https://i.pravatar.cc/150?img=68" style="width: 48px; height: 48px; border-radius: 50%; object-fit: cover;" />
                  <div>
                    <h4 style="margin: 0; font-size: 16px; color: white;">Jane Doe</h4>
                    <p style="margin: 0; color: #aaa; font-size: 12px;">iPhone</p>
                  </div>
                </div>
                <div style="font-size: 24px; color: #aaa;">00:14</div>
              </template>
              
              <template #expanded-body>
                <div style="display: flex; gap: 4px; margin-top: 24px; align-items: center; justify-content: center;">
                  <div v-for="i in 5" :key="i" style="width: 4px; height: 24px; background: #2dd36f; border-radius: 2px;"></div>
                </div>
              </template>

              <template #expanded-footer>
                <BizIconButton color="danger" style="border-radius: 50%; width: 56px; height: 56px;" @click="isIslandOpen = false">
                  <ion-icon :icon="phonePortraitOutline" style="transform: rotate(135deg);"></ion-icon>
                </BizIconButton>
                <BizIconButton color="success" style="border-radius: 50%; width: 56px; height: 56px;">
                  <ion-icon :icon="volumeHighOutline"></ion-icon>
                </BizIconButton>
              </template>
            </BizDynamicIsland>
          </div>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const isIslandOpen = ref(false);

const islandState = ref('compact');

const islandPosition = ref('top');

const islandFullWidth = ref(false);

const showIsland = (state: string) => {
  islandState.value = state;
  isIslandOpen.value = true;
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
