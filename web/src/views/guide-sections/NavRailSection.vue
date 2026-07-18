<template>
<div class="guide-section">
        <h2>18. Navigation Rail (Material 3)</h2>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <p class="custom-guide">A vertical navigation rail typically used on larger screens.</p>
          <div class="component-demo" style="height: 400px; border: 1px solid #ddd; border-radius: 12px; overflow: hidden; display: flex; background: #fff;">
            <BizNavigationRail 
              :items="navRailItems" 
              showMenu
              @menu-click="alertVal('Menu Toggle Clicked!')"
              @item-click="handleRailClick"
            />
            <div style="flex: 1; padding: 24px;">
              <h3 style="margin-top: 0">Main Content Area</h3>
              <p>Selected tab: <strong>{{ selectedRailItem }}</strong></p>
            </div>
          </div>
          <pre class="code-block"><code>&lt;BizNavigationRail 
  :items="railItems" 
  @item-click="onRailClick" 
/&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const selectedRailItem = ref('Home');

const navRailItems = ref([
  { label: 'Home', active: true, icon: homeOutline },
  { label: 'History', badge: '1', icon: documentTextOutline },
  { label: 'Profile', icon: personOutline }
]);

const handleRailClick = (item: any) => {
  navRailItems.value.forEach(i => i.active = false);
  item.active = true;
  selectedRailItem.value = item.label;
};

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
