<template>
<div class="guide-section">
        <h2>14. Account Reorder List</h2>

        <div class="variant-group">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
            <h3>Interactive Reorder List</h3>
            <PPButton size="small" @click="isReorderMode = !isReorderMode">
              {{ isReorderMode ? 'Done' : 'Sort by' }}
            </PPButton>
          </div>
          <p class="custom-guide">Toggle Sort mode to see drag handles. Drag to reorder.</p>
          <div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px;">
            <PPAccountReorderList 
              :accounts="demoAccounts"
              :isReorderMode="isReorderMode"
              @update:accounts="newAccs => demoAccounts = newAccs"
              @action-click="acc => alertVal('Action clicked for ' + acc.accountName)"
            >
              <template #item="{ item, isReorderMode: reorderMode, onUpdateHidden, dragListeners }">
                <PPAccountListCard 
                  :accountName="item.accountName || item.name"
                  :accountNumber="item.accountNumber || item.number"
                  :balance="item.balance"
                  :currency="item.currency"
                  :type="item.type"
                  :isHidden="item.isHidden"
                  @update:isHidden="val => onUpdateHidden(val)"
                  @action-click="() => alertVal('Action clicked for ' + (item.accountName || item.name))"
                  @click="() => !reorderMode && alertVal('Item clicked for ' + (item.accountName || item.name))"
                >
                  <template #action>
                    <div 
                      v-if="reorderMode" 
                      style="color: #999; cursor: grab; padding: 0; display: flex; align-items: center; justify-content: center;"
                      v-on="dragListeners"
                    >
                      <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="4" y1="12" x2="20" y2="12"></line>
                        <line x1="4" y1="6" x2="20" y2="6"></line>
                        <line x1="4" y1="18" x2="20" y2="18"></line>
                      </svg>
                    </div>
                    <button v-else style="background: transparent; border: none; color: #999; padding: 0; cursor: pointer; display: flex; align-items: center; justify-content: center;" @click.stop="alertVal('Action clicked for ' + (item.accountName || item.name))">
                      <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="5" r="1"></circle>
                        <circle cx="12" cy="12" r="1"></circle>
                        <circle cx="12" cy="19" r="1"></circle>
                      </svg>
                    </button>
                  </template>
                </PPAccountListCard>
              </template>
            </PPAccountReorderList>
          </div>
          <pre class="code-block"><code>&lt;PPAccountReorderList 
  :accounts="accounts" 
  :isReorderMode="isReorderMode" 
  @update:accounts="newAccs => accounts = newAccs" 
&gt;
  &lt;template #item="{ item, dragListeners, isReorderMode }"&gt;
    &lt;PPAccountListCard 
      :accountName="item.name"
      :balance="item.balance"
      &lt;!-- ... --&gt;
    &gt;
      &lt;template #action&gt;
        &lt;div v-if="isReorderMode" v-on="dragListeners"&gt;Drag Me&lt;/div&gt;
      &lt;/template&gt;
    &lt;/PPAccountListCard&gt;
  &lt;/template&gt;
&lt;/PPAccountReorderList&gt;</code></pre>
        </div>

        <div class="variant-group">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
            <h3>Fully Custom Template</h3>
            <PPButton size="small" @click="isReorderMode = !isReorderMode">
              {{ isReorderMode ? 'Done' : 'Sort by' }}
            </PPButton>
          </div>
          <p class="custom-guide">You can completely replace the internal cards with your own custom HTML while retaining the drag-to-reorder logic.</p>
          <div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px;">
            <PPAccountReorderList 
              :accounts="demoAccounts"
              :isReorderMode="isReorderMode"
              @update:accounts="newAccs => demoAccounts = newAccs"
            >
              <template #item="{ item, dragListeners, isReorderMode: reorderMode }">
                <div style="background: white; border-radius: 8px; padding: 16px; margin-bottom: 8px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                  <div>
                    <strong style="display: block; font-size: 16px; color: #333;">Custom: {{ item.accountName || item.name }}</strong>
                    <span style="color: #666; font-size: 14px;">Balance: {{ item.currency }}{{ item.balance }}</span>
                  </div>
                  <div 
                    v-if="reorderMode" 
                    style="background: #eef2f6; padding: 8px; border-radius: 4px; cursor: grab; color: #555;"
                    v-on="dragListeners"
                  >
                    Hold to Drag
                  </div>
                  <PPButton v-else size="small" variant="outline" @click="alertVal('Action on custom card')">Action</PPButton>
                </div>
              </template>
            </PPAccountReorderList>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPAccountReorderList 
  :accounts="accounts" 
  :isReorderMode="isReorderMode"
&gt;
  &lt;template #item="{ item, dragListeners, isReorderMode }"&gt;
    &lt;div class="my-custom-card"&gt;
      &lt;h4&gt;{{ item.name }}&lt;/h4&gt;
      &lt;p&gt;{{ item.balance }}&lt;/p&gt;
      &lt;div v-if="isReorderMode" v-on="dragListeners"&gt;
        Hold to Drag
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/template&gt;
&lt;/PPAccountReorderList&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const demoAccounts = ref([
  { id: 'acc1', name: "Chan Ty' Saving", number: "1-120-14335454-8", balance: 12000000.00, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc2', name: "Chan Ty' Saving", number: "1-120-14335455-9", balance: 50000.50, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc3', name: "Chan Ty' Saving", number: "1-120-14335456-0", balance: 40000000, currency: "KHR" as const, type: "Savings", isHidden: true },
]);

const isReorderMode = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
