<template>
<div class="guide-section">
        <h2>17. Navigation Drawer (Material 3)</h2>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <p class="custom-guide">Click the button to slide open the navigation drawer.</p>
          <div class="component-demo">
            <BizButton @click="showNavDrawer = true">Open Left Menu</BizButton>

            <BizNavigationDrawer 
              v-model="showNavDrawer" 
              title="App Menu" 
              :items="navDrawerItems" 
              @item-click="val => alertVal('Selected: ' + val.label)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizNavigationDrawer 
  v-model="isDrawerOpen" 
  title="App Menu" 
  :items="menuItems" 
/&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const showNavDrawer = ref(false);

const navDrawerItems = ref([
  { label: 'Inbox', active: true, badge: '3' },
  { label: 'Sent' },
  { label: 'Drafts' }
]);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
