<template>
<div class="guide-section">
        <h2>Bottom Navigation</h2>
        <p class="guide-desc">Modern bottom navigation bars with multiple styles and variants.</p>

        <div class="variant-group">
          <h3>Material 3 (Default)</h3>
          <p class="guide-desc">The standard MD3 style with pill indicators.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValMaterial"
              variant="material"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="material"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Classic</h3>
          <p class="guide-desc">A traditional style with icons and text stacked vertically.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValClassic"
              variant="classic"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="classic"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Shift</h3>
          <p class="guide-desc">A dynamic shifting style where only the active item shows its label.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValShift"
              variant="shift"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="shift"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Floating</h3>
          <p class="guide-desc">A modern floating island navigation bar.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; height: 160px; background: #f0f2f5;">
            <PPBottomNav 
              v-model="navValFloating"
              variant="floating"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="floating"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Dot (Animated)</h3>
          <p class="guide-desc">A smooth sliding dot indicator with icon bounce.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValDot"
              variant="dot"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="dot"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Bubble (Animated)</h3>
          <p class="guide-desc">A springy popping bubble indicator.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px;">
            <PPBottomNav 
              v-model="navValBubble"
              variant="bubble"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="bubble"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Magic Line (Animated)</h3>
          <p class="guide-desc">A glowing line sliding across a sleek dark background.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #2c2c36;">
            <PPBottomNav 
              v-model="navValMagicLine"
              variant="magic-line"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="magic-line"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Curved (The Cutout)</h3>
          <p class="guide-desc">The active item pops up into a floating circle above the navigation bar.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #f9f9fc;">
            <PPBottomNav 
              v-model="navValCurved"
              variant="curved"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="curved"
  :items="navItems"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Cutout (Action FAB)</h3>
          <p class="guide-desc">A centered elevated action button with a curved cutout behind it.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #1a1a1a;">
            <PPBottomNav 
              v-model="navValCutout"
              variant="cutout"
              :items="navItemsCutout"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="cutout"
  :items="navItemsCutout"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Pill Slide (Segmented Control)</h3>
          <p class="guide-desc">A continuous pill shape with a solid background sliding behind the active item.</p>
          <div class="component-demo" style="position: relative; overflow: hidden; padding-bottom: 20px; background-color: #ffffff;">
            <PPBottomNav 
              v-model="navValPillSlide"
              variant="pill-slide"
              :items="navItems"
            />
          </div>
          <pre class="code-block"><code>&lt;PPBottomNav 
  v-model="currentTab"
  variant="pill-slide"
  :items="navItems"
/&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const navValMaterial = ref('home');
const navValClassic = ref('home');
const navValShift = ref('home');
const navValFloating = ref('home');
const navValDot = ref('home');
const navValBubble = ref('home');
const navValMagicLine = ref('home');
const navValCurved = ref('home');
const navValPillSlide = ref('home');
const navValCutout = ref('home');

const navItems = [
  { label: 'Home', value: 'home', icon: homeOutline, activeIcon: home },
  { label: 'History', value: 'history', icon: documentTextOutline, activeIcon: documentText },
  { label: 'Messages', value: 'messages', icon: chatbubbleOutline, activeIcon: chatbubble },
  { label: 'Profile', value: 'profile', icon: personOutline, activeIcon: person }
];

const navItemsCutout = [
  { label: 'Home', value: 'home', icon: homeOutline, activeIcon: home },
  { label: 'Rewards', value: 'rewards', icon: cardOutline, activeIcon: cardOutline },
  { label: 'Order', value: 'order', icon: addOutline, isAction: true },
  { label: 'Scan', value: 'scan', icon: scanOutline },
  { label: 'My Order', value: 'myorder', icon: cartOutline }
];

import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline, scanOutline, cartOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
