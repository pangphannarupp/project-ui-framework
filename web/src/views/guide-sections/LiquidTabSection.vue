<template>
<div class="guide-section">
        <h2>Liquid Glass Tab Bar (iOS) & Animated Tabs</h2>
        <p class="guide-desc">A custom floating tab bar with an iOS-style liquid glass (frosted) effect that animates between tab content.</p>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <div class="component-demo" style="position: relative; height: 300px; background: url('https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop') center/cover; border-radius: 12px; overflow: hidden;">
            <BizAnimatedTabs v-model="animatedTabVal" :tabs="animatedTabs">
              <template #tab-0>
                <div style="padding: 24px; color: white;">
                  <h3 style="color: white; font-size: 24px;">Welcome Home</h3>
                  <p>Slide transition applies smoothly across tabs.</p>
                </div>
              </template>
              <template #tab-1>
                <div style="padding: 24px; color: white;">
                  <h3 style="color: white; font-size: 24px;">Transaction History</h3>
                  <p>All your recent transactions appear here.</p>
                </div>
              </template>
              <template #tab-2>
                <div style="padding: 24px; color: white;">
                  <h3 style="color: white; font-size: 24px;">Your Profile</h3>
                  <p>Manage your account settings.</p>
                </div>
              </template>
            </BizAnimatedTabs>
          </div>
          <pre class="code-block"><code>&lt;BizAnimatedTabs v-model="activeTab" :tabs="tabs"&gt;
  &lt;template #tab-0&gt;Content 1&lt;/template&gt;
  &lt;template #tab-1&gt;Content 2&lt;/template&gt;
&lt;/BizAnimatedTabs&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const animatedTabVal = ref(0);

const animatedTabs = ref([
  { label: 'Home', icon: homeOutline },
  { label: 'History', icon: documentTextOutline },
  { label: 'Profile', icon: personOutline }
]);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
