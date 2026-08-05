<template>
<div class="guide-section">
        <h2>11. Khmer Calendar</h2>

        <div class="variant-group">
          <h3>Input Wrapper</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPKhmerDatePicker&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPKhmerDatePicker v-model="dateModel" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPKhmerDatePicker v-model="date" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code> (default)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPKhmerCalendar 
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString() + '\nKhmer Date: ' + s.fullText)"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPKhmerCalendar @date-selected="onSelect" /&gt;</code></pre>
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
          <pre class="code-block" v-pre><code>&lt;PPKhmerCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&gt;</code></pre>
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
          <pre class="code-block" v-pre><code>&lt;PPKhmerCalendar :config="{ selectionMode: 'Week' }" /&gt;</code></pre>
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
          <pre class="code-block" v-pre><code>&lt;PPKhmerCalendar :hide-header-picker="true" :hide-nav-buttons="true" /&gt;</code></pre>
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
          <pre class="code-block" v-pre><code>&lt;PPKhmerCalendarSheet v-model="isOpen" /&gt;</code></pre>
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
          <pre class="code-block" v-pre><code>&lt;PPKhmerCalendarAlert v-model="isOpen" /&gt;</code></pre>
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
          <pre class="code-block" v-pre><code>&lt;PPKhmerCalendarIsland v-model="isOpen" /&gt;</code></pre>
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
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-calendar-bg: /* value */;
  --pp-calendar-cell-height: /* value */;
  --pp-calendar-day-disabled-opacity: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-selected-text: /* value */;
  --pp-calendar-special-color: /* value */;
  --pp-calendar-subtitle-color: /* value */;
  --pp-calendar-subtitle-text: /* value */;
  --pp-calendar-sunday-color: /* value */;
  --pp-calendar-text: /* value */;
  --pp-calendar-today-border: /* value */;
  --pp-calendar-wheel-active: /* value */;
  --pp-calendar-wheel-text: /* value */;
  --pp-danger-color: /* value */;
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
  --pp-primary-variant: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}</code></pre>
        </div>
</div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
&lt;div class="guide-section"&gt;
        &lt;h2&gt;11. Khmer Calendar&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Selection&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Single' }&lt;/code&gt; (default)&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPKhmerCalendar 
              @date-selected="s =&gt; alertVal('Selected Date: ' + s.date.toLocaleDateString() + '\nKhmer Date: ' + s.fullText)"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPKhmerCalendar @date-selected="onSelect" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Range Selection &amp; Limits&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Range', minDate: ..., maxDate: ... }&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPKhmerCalendar 
              :config="{ 
                selectionMode: 'Range', 
                minDate: new Date(new Date().getFullYear(), new Date().getMonth(), 1), 
                maxDate: new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0) 
              }"
              @range-selected="(start, end) =&gt; alertVal('Range: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPKhmerCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Week Selection&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Week' }&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPKhmerCalendar 
              :config="{ selectionMode: 'Week' }"
              @range-selected="(start, end) =&gt; alertVal('Week: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPKhmerCalendar :config="{ selectionMode: 'Week' }" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Hide Header Controls&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;hideHeaderPicker&lt;/code&gt;, &lt;code&gt;hideNavButtons&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPKhmerCalendar 
              :hide-header-picker="true"
              :hide-nav-buttons="true"
              @date-selected="s =&gt; alertVal('Selected Date: ' + s.date.toLocaleDateString() + '\nKhmer Date: ' + s.fullText)"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPKhmerCalendar :hide-header-picker="true" :hide-nav-buttons="true" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;



        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Calendar Bottom Sheet&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPKhmerCalendarSheet&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showCalendarSheet = true"&gt;Open Calendar Sheet&lt;/PPButton&gt;
            &lt;PPKhmerCalendarSheet 
              v-model="showCalendarSheet"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) =&gt; { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showCalendarSheet = false; }"
              @cancel="showCalendarSheet = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPKhmerCalendarSheet v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Calendar Alert Popup&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPKhmerCalendarAlert&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showAlertCalendar = true"&gt;Open Calendar Alert&lt;/PPButton&gt;
            &lt;PPKhmerCalendarAlert 
              v-model="showAlertCalendar"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) =&gt; { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showAlertCalendar = false; }"
              @cancel="showAlertCalendar = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPKhmerCalendarAlert v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Calendar Island Popup&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPKhmerCalendarIsland&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showKhmerCalendarIsland = true"&gt;Open Calendar Island&lt;/PPButton&gt;
            &lt;PPKhmerCalendarIsland 
              v-model="showKhmerCalendarIsland"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) =&gt; { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showKhmerCalendarIsland = false; }"
              @cancel="showKhmerCalendarIsland = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPKhmerCalendarIsland v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Direct TS Utility Access (KhmerDate.ts)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can import the raw &lt;code&gt;KhmerDate.ts&lt;/code&gt; file directly from the framework's dist folder. This allows developers to read or modify the unminified business logic directly in their own build process!&lt;/p&gt;
          &lt;div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px; font-size: 16px;"&gt;
            &lt;strong&gt;Today is:&lt;/strong&gt; {{ khmerDateDemo }}
          &lt;/div&gt;
          &lt;pre class="code-block" v-pre&gt;&lt;code&gt;import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';

const khmerDate = new KhmerDate();
const dateObj = khmerDate.toLunar();
console.log(`${dateObj.lunarDay} ខែ${dateObj.lunarMonth} ឆ្នាំ${dateObj.zodiacYear}`);&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing KhmerDate.ts in Your Project Scope&lt;/h3&gt;
          &lt;div class="guide-intro" style="background: #fff8e1; border-left-color: #fbbc05;"&gt;
            &lt;strong&gt;Best Practice:&lt;/strong&gt; Modifying files directly inside &lt;code&gt;node_modules&lt;/code&gt; is an anti-pattern because your changes will be erased during the next package installation. Since the framework provides the unminified &lt;code&gt;KhmerDate.ts&lt;/code&gt;, you can easily copy it into your own project and apply specific business logic.
          &lt;/div&gt;
          
          &lt;ol class="custom-guide" style="padding-left: 20px; margin-bottom: 24px;"&gt;
            &lt;li style="margin-bottom: 12px;"&gt;
              &lt;strong&gt;Locate the source file:&lt;/strong&gt; Find the unminified TypeScript file at &lt;code&gt;node_modules/@phanna/ui-framework/dist/KhmerDate.ts&lt;/code&gt;.
            &lt;/li&gt;
            &lt;li style="margin-bottom: 12px;"&gt;
              &lt;strong&gt;Copy to your project:&lt;/strong&gt; Copy the file into a utility directory in your local source code (e.g., &lt;code&gt;src/utils/KhmerDate.ts&lt;/code&gt;).
            &lt;/li&gt;
            &lt;li style="margin-bottom: 12px;"&gt;
              &lt;strong&gt;Apply customizations:&lt;/strong&gt; Edit your local copy to modify date calculations, override string formats, or inject your custom business logic.
            &lt;/li&gt;
            &lt;li style="margin-bottom: 12px;"&gt;
              &lt;strong&gt;Update imports:&lt;/strong&gt; Point your application's imports to your newly customized local file.
            &lt;/li&gt;
          &lt;/ol&gt;

          &lt;pre class="code-block" v-pre&gt;&lt;code&gt;// ❌ Instead of importing from the framework:
// import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';

// ✅ Import your locally customized version:
import { KhmerDate } from '@/utils/KhmerDate';

const khmerDate = new KhmerDate();
const dateObj = khmerDate.toLunar();
// Now executes YOUR specific business logic!&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-calendar-bg: /* value */;
  --pp-calendar-cell-height: /* value */;
  --pp-calendar-day-disabled-opacity: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-selected-text: /* value */;
  --pp-calendar-special-color: /* value */;
  --pp-calendar-subtitle-color: /* value */;
  --pp-calendar-subtitle-text: /* value */;
  --pp-calendar-sunday-color: /* value */;
  --pp-calendar-text: /* value */;
  --pp-calendar-today-border: /* value */;
  --pp-calendar-wheel-active: /* value */;
  --pp-calendar-wheel-text: /* value */;
  --pp-danger-color: /* value */;
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
  --pp-primary-variant: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue';

const khmerDateDemo = computed(() =&gt; {
  const khmerDate = new KhmerDate();
  const dateObj = khmerDate.toLunar();
  return `${dateObj.lunarDay} ខែ${dateObj.lunarMonth} ឆ្នាំ${dateObj.zodiacYear} ${dateObj.stem} ព.ស. ${dateObj.lunarYear}`;
});const showCalendarSheet = ref(false);

const showAlertCalendar = ref(false);

const showKhmerCalendarIsland = ref(false);

const alertVal = (type: string) =&gt; console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const khmerDateDemo = computed(() => {
  const khmerDate = new KhmerDate();
  const dateObj = khmerDate.toLunar();
  return `${dateObj.lunarDay} ខែ${dateObj.lunarMonth} ឆ្នាំ${dateObj.zodiacYear} ${dateObj.stem} ព.ស. ${dateObj.lunarYear}`;
});

const dateModel = ref<Date | null>(null);
const showCalendarSheet = ref(false);

const showAlertCalendar = ref(false);

const showKhmerCalendarIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerDatePicker, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
