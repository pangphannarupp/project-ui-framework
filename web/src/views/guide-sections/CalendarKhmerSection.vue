<template>
<div class="guide-section">
        <h2>11. Khmer Calendar</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code> (default)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizKhmerCalendar 
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString() + '\nKhmer Date: ' + s.fullText)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendar @date-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection & Limits</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range', minDate: ..., maxDate: ... }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizKhmerCalendar 
              :config="{ 
                selectionMode: 'Range', 
                minDate: new Date(new Date().getFullYear(), new Date().getMonth(), 1), 
                maxDate: new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0) 
              }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Week Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Week' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizKhmerCalendar 
              :config="{ selectionMode: 'Week' }"
              @range-selected="(start, end) => alertVal('Week: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendar :config="{ selectionMode: 'Week' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizKhmerCalendarSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showCalendarSheet = true">Open Calendar Sheet</BizButton>
            <BizKhmerCalendarSheet 
              v-model="showCalendarSheet"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showCalendarSheet = false; }"
              @cancel="showCalendarSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendarSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Alert Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizKhmerCalendarAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showAlertCalendar = true">Open Calendar Alert</BizButton>
            <BizKhmerCalendarAlert 
              v-model="showAlertCalendar"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showAlertCalendar = false; }"
              @cancel="showAlertCalendar = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendarAlert v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizKhmerCalendarIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showKhmerCalendarIsland = true">Open Calendar Island</BizButton>
            <BizKhmerCalendarIsland 
              v-model="showKhmerCalendarIsland"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showKhmerCalendarIsland = false; }"
              @cancel="showKhmerCalendarIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendarIsland v-model="isOpen" /&gt;</code></pre>
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

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
