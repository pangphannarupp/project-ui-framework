<template>
<div class="guide-section">
        <h2>19. Dynamic Island</h2>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <p class="custom-guide">A fluid, shape-shifting popup that anchors to the top of the screen.</p>
          <div class="component-demo">
            <div style="display: flex; gap: 8px; margin-bottom: 16px; align-items: center; flex-wrap: wrap;">
              <div style="width: 200px;">
                <PPSelect v-model="islandPosition" :options="[{label: 'Top', value: 'top'}, {label: 'Bottom', value: 'bottom'}, {label: 'Left', value: 'left'}, {label: 'Right', value: 'right'}]" placeholder="Select Position" />
              </div>
              <PPCheckbox v-model="islandFullWidth">Full Width</PPCheckbox>
            </div>
            <PPButtonGroup>
              <PPButton @click="showIsland('minimal')">Minimal</PPButton>
              <PPButton @click="showIsland('compact')">Compact</PPButton>
              <PPButton @click="showIsland('expanded')">Expanded</PPButton>
              <PPButton variant="outline-danger" @click="isIslandOpen = false">Close</PPButton>
            </PPButtonGroup>

            <PPDynamicIsland 
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
                <PPIconButton color="danger" style="border-radius: 50%; width: 56px; height: 56px;" @click="isIslandOpen = false">
                  <ion-icon :icon="phonePortraitOutline" style="transform: rotate(135deg);"></ion-icon>
                </PPIconButton>
                <PPIconButton color="success" style="border-radius: 50%; width: 56px; height: 56px;">
                  <ion-icon :icon="volumeHighOutline"></ion-icon>
                </PPIconButton>
              </template>
            </PPDynamicIsland>
          </div>
          <pre class="code-block"><code>&lt;PPDynamicIsland 
  v-model="isIslandOpen"
  :state="islandState"
  :position="islandPosition"
  :fullWidth="islandFullWidth"
  :offset="16"
  :autoHideTimeout="islandState === 'expanded' ? 0 : 3000"
&gt;
  &lt;!-- Compact Slots --&gt;
  &lt;template #compact-left&gt;
    &lt;!-- Icon or Avatar --&gt;
  &lt;/template&gt;
  &lt;template #compact-center&gt;
    &lt;!-- Title or Text --&gt;
  &lt;/template&gt;
  &lt;template #compact-right&gt;
    &lt;!-- Status Icon --&gt;
  &lt;/template&gt;

  &lt;!-- Expanded Slots --&gt;
  &lt;template #expanded-header&gt;
    &lt;!-- Caller Info --&gt;
  &lt;/template&gt;
  &lt;template #expanded-body&gt;
    &lt;!-- Audio Visualizer / Content --&gt;
  &lt;/template&gt;
  &lt;template #expanded-footer&gt;
    &lt;!-- Action Buttons --&gt;
  &lt;/template&gt;
&lt;/PPDynamicIsland&gt;</code></pre>
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

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
