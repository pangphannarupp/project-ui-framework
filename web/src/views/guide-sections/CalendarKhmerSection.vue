<template>
<div class="guide-section">
        <h2>11. Khmer Calendar</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code> (default)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPKhmerCalendar 
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString() + '\nKhmer Date: ' + s.fullText)"
            />
          </div>
          <pre class="code-block"><code>&lt;PPKhmerCalendar @date-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection & Limits</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range', minDate: ..., maxDate: ... }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPKhmerCalendar 
              :config="{ 
                selectionMode: 'Range', 
                minDate: new Date(new Date().getFullYear(), new Date().getMonth(), 1), 
                maxDate: new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0) 
              }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;PPKhmerCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Week Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Week' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPKhmerCalendar 
              :config="{ selectionMode: 'Week' }"
              @range-selected="(start, end) => alertVal('Week: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;PPKhmerCalendar :config="{ selectionMode: 'Week' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Hide Header Controls</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>hideHeaderPicker</code>, <code>hideNavButtons</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPKhmerCalendar 
              :hide-header-picker="true"
              :hide-nav-buttons="true"
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString() + '\nKhmer Date: ' + s.fullText)"
            />
          </div>
          <pre class="code-block"><code>&lt;PPKhmerCalendar :hide-header-picker="true" :hide-nav-buttons="true" /&gt;</code></pre>
        </div>



        <div class="variant-group">
          <h3>Calendar Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPKhmerCalendarSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showCalendarSheet = true">Open Calendar Sheet</PPButton>
            <PPKhmerCalendarSheet 
              v-model="showCalendarSheet"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showCalendarSheet = false; }"
              @cancel="showCalendarSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPKhmerCalendarSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Alert Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPKhmerCalendarAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showAlertCalendar = true">Open Calendar Alert</PPButton>
            <PPKhmerCalendarAlert 
              v-model="showAlertCalendar"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showAlertCalendar = false; }"
              @cancel="showAlertCalendar = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPKhmerCalendarAlert v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPKhmerCalendarIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showKhmerCalendarIsland = true">Open Calendar Island</PPButton>
            <PPKhmerCalendarIsland 
              v-model="showKhmerCalendarIsland"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showKhmerCalendarIsland = false; }"
              @cancel="showKhmerCalendarIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPKhmerCalendarIsland v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Direct TS Utility Access (KhmerDate.ts)</h3>
          <p class="custom-guide">You can import the raw <code>KhmerDate.ts</code> file directly from the framework's dist folder. This allows developers to read or modify the unminified business logic directly in their own build process!</p>
          <div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px; font-size: 16px;">
            <strong>Today is:</strong> {{ khmerDateDemo }}
          </div>
          <pre class="code-block" v-pre><code>import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';

const khmerDate = new KhmerDate();
const dateObj = khmerDate.toLunar();
console.log(`${dateObj.lunarDay} ខែ${dateObj.lunarMonth} ឆ្នាំ${dateObj.zodiacYear}`);</code></pre>
        </div>

        <div class="variant-group">
          <h3>Customizing KhmerDate.ts in Your Project Scope</h3>
          <div class="guide-intro" style="background: #fff8e1; border-left-color: #fbbc05;">
            <strong>Best Practice:</strong> Modifying files directly inside <code>node_modules</code> is an anti-pattern because your changes will be erased during the next package installation. Since the framework provides the unminified <code>KhmerDate.ts</code>, you can easily copy it into your own project and apply specific business logic.
          </div>
          
          <ol class="custom-guide" style="padding-left: 20px; margin-bottom: 24px;">
            <li style="margin-bottom: 12px;">
              <strong>Locate the source file:</strong> Find the unminified TypeScript file at <code>node_modules/@phanna/ui-framework/dist/KhmerDate.ts</code>.
            </li>
            <li style="margin-bottom: 12px;">
              <strong>Copy to your project:</strong> Copy the file into a utility directory in your local source code (e.g., <code>src/utils/KhmerDate.ts</code>).
            </li>
            <li style="margin-bottom: 12px;">
              <strong>Apply customizations:</strong> Edit your local copy to modify date calculations, override string formats, or inject your custom business logic.
            </li>
            <li style="margin-bottom: 12px;">
              <strong>Update imports:</strong> Point your application's imports to your newly customized local file.
            </li>
          </ol>

          <pre class="code-block" v-pre><code>// ❌ Instead of importing from the framework:
// import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';

// ✅ Import your locally customized version:
import { KhmerDate } from '@/utils/KhmerDate';

const khmerDate = new KhmerDate();
const dateObj = khmerDate.toLunar();
// Now executes YOUR specific business logic!</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const khmerDateDemo = computed(() => {
  const khmerDate = new KhmerDate();
  const dateObj = khmerDate.toLunar();
  return `${dateObj.lunarDay} ខែ${dateObj.lunarMonth} ឆ្នាំ${dateObj.zodiacYear} ${dateObj.stem} ព.ស. ${dateObj.lunarYear}`;
});const showCalendarSheet = ref(false);

const showAlertCalendar = ref(false);

const showKhmerCalendarIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
