<template>
<div class="guide-section">
        <h2>18. Navigation Rail (Material 3)</h2>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <p class="custom-guide">A vertical navigation rail typically used on larger screens.</p>
          <div class="component-demo" style="height: 400px; border: 1px solid #ddd; border-radius: 12px; overflow: hidden; display: flex; background: #fff;">
            <PPNavigationRail 
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
          <pre class="code-block"><code>&lt;PPNavigationRail 
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

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
