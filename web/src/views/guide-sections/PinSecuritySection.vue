<template>
<div class="guide-section">
        <h2>8. PIN Security Components</h2>

        <div class="variant-group">
          <h3>BizPinDots</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>length</code>, <code>value</code>, <code>error</code>, <code>errorText</code>, <code>success</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 40px; border-radius: 12px; display: flex; flex-direction: column; gap: 20px;">
            <BizPinDots :length="6" value="123" />
            <BizPinDots :length="6" value="12345" :error="true" />
            <BizPinDots :length="6" value="123456" :success="true" />
          </div>
          <pre class="code-block"><code>&lt;BizPinDots :length="6" value="123" /&gt;
&lt;BizPinDots :length="6" value="123" :error="true" /&gt;
&lt;BizPinDots :length="6" value="123456" :success="true" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizKeypad</h3>
          <p class="custom-guide"><strong>Events:</strong> <code>@press</code> (emits value string or 'backspace')</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <!-- Render keypad live -->
            <BizKeypad @press="handlePress" />
            <div style="padding: 16px; text-align: center; color: #666;">
              Last Pressed: <strong>{{ keypadDemoVal }}</strong>
            </div>
          </div>
          <pre class="code-block"><code>&lt;BizKeypad @press="handlePress" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Secure Keypad</h3>
          <p class="custom-guide">A randomized secure keypad with a shield icon. The numbers shuffle every time the component mounts to prevent shoulder-surfing!</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <div style="padding: 16px; text-align: center; color: #666; font-size: 18px;">
              Secure PIN: <strong>{{ secureKeypadVal || 'Enter PIN' }}</strong>
            </div>
            <BizSecureKeypad @press="handleSecureKeypadPress" />
          </div>
          <pre class="code-block"><code>&lt;BizSecureKeypad @press="handleSecureKeypadPress" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Secure Virtual Keyboard</h3>
          <p class="custom-guide">A full randomized QWERTY-style secure keyboard (dark theme).</p>
          <div class="component-section" id="biz-secure-keyboard">
            <h2>BizSecureKeyboard</h2>
            <p>A full randomized QWERTY keyboard with custom layouts.</p>
            <div class="demo-container bg-dark" style="position: relative; overflow: visible;">
              <div class="mb-4" style="color: white;">
                <div class="text-sm text-gray-400">English Input</div>
                <div class="text-xl tracking-widest font-mono">{{ keypadDemoVal || 'Tap to type' }}</div>
              </div>
              <BizSecureKeyboard @press="handleKeyboardPress" />
            </div>
          </div>

          <!-- Secure Khmer Keyboard -->
          <div class="component-section" id="biz-khmer-keyboard">
            <h2>BizKhmerKeyboard</h2>
            <p>A full randomized Khmer (NiDA) keyboard with custom layouts.</p>
            <div class="demo-container bg-dark" style="position: relative; overflow: visible;">
              <div class="mb-4" style="color: white;">
                <div class="text-sm text-gray-400">Khmer Input</div>
                <div class="text-xl tracking-widest font-mono">{{ khmerDemoVal || 'Tap to type' }}</div>
              </div>
              <BizKhmerKeyboard @press="handleKhmerPress" />
            </div>
          </div>
        </div>

      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const handleSecureKeypadPress = (v: string) => {
  if (v === 'backspace') {
    secureKeypadVal.value = secureKeypadVal.value.slice(0, -1);
  } else {
    secureKeypadVal.value += v;
  }
};

const khmerDemoVal = ref('');

const handleKeyboardPress = (v: string) => {
  if (v === 'backspace') {
    keypadDemoVal.value = keypadDemoVal.value.slice(0, -1);
  } else if (v === 'enter') {
    console.log('Enter pressed');
  } else {
    keypadDemoVal.value += v;
  }
};

const handleKhmerPress = (v: string) => {
  if (v === 'backspace') {
    khmerDemoVal.value = khmerDemoVal.value.slice(0, -1);
  } else if (v === 'enter') {
    console.log('Enter pressed');
  } else {
    khmerDemoVal.value += v;
  }
};

const secureKeypadVal = ref('');

const keypadDemoVal = ref('None');

const handlePress = (v: string) => {
  keypadDemoVal.value = v;
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
