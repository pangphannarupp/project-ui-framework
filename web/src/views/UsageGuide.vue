<template>
  <ion-page>
    <ion-header>
      <ion-toolbar color="primary">
        <ion-buttons slot="start">
          <ion-back-button default-href="/"></ion-back-button>
        </ion-buttons>
        <ion-title>Full Component Catalog</ion-title>
      </ion-toolbar>
    </ion-header>
    
    <div style="display: flex; height: 100vh; overflow: hidden;">
      <!-- Navigation Rail -->
      <!-- <BizNavigationRail 
        v-model="isRailExpanded"
        :items="navRailItems"
        @select="handleRailSelect"
      /> -->

      <!-- Navigation Drawer (Accordion) -->
      <div 
        class="rail-drawer" 
        :class="{ expanded: isRailExpanded }"
        style="background: #ffffff; border-right: 1px solid #ddd; height: 100%; transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1); overflow-y: auto; overflow-x: hidden;"
        :style="{ width: isRailExpanded ? '280px' : '0px' }"
      >
        <div style="padding: 16px; width: 280px;">
          <BizInput 
            v-model="searchQuery" 
            placeholder="Filter components..." 
            clearable 
          />
        </div>
        
        <div style="width: 280px;">
          <BizCollapse v-model="expandedCategory" accordion>
            <BizCollapseItem 
              v-for="group in componentsMenu" 
              :key="group.category"
              :name="group.category"
            >
              <template #title>
                <div style="display: flex; align-items: center; gap: 12px; font-weight: 600; color: #333; width: 100%;">
                  <ion-icon :icon="group.icon" style="font-size: 20px; color: #003399;" />
                  <span>{{ group.category }}</span>
                </div>
              </template>
              
              <div 
                v-for="item in group.items" 
                :key="item.id"
                class="menu-item"
                :class="{ active: selectedComponentId === item.id }"
                @click="selectComponent(item.id)"
                style="padding: 12px 16px; padding-left: 48px; cursor: pointer; color: #666; font-size: 14px; transition: background 0.2s;"
              >
                {{ item.label }}
              </div>
            </BizCollapseItem>
          </BizCollapse>
        </div>
      </div>

      <!-- Main Content -->
      <ion-content class="ion-padding" style="flex: 1; height: 100%; --background: #ffffff; color: #333;">
        <div class="docs-content" style="max-width: 800px; margin: 0 auto; padding-bottom: 60px; background: #ffffff;">
          <h1 v-if="currentComponentTitle" style="margin-bottom: 24px; color: #003399; font-size: 24px; border-bottom: 2px solid #003399; padding-bottom: 12px;">
            {{ currentComponentTitle }}
          </h1>
          
          <component :is="currentComponent" />
        </div>
      </ion-content>
    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonIcon } from '@ionic/vue';
import { rocketOutline, cubeOutline, calendarOutline, compassOutline, lockClosedOutline, barChartOutline, layersOutline, documentTextOutline } from 'ionicons/icons';
import { BizNavigationRail, BizInput, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import * as GuideSections from './guide-sections';

const isRailExpanded = ref(true);
const searchQuery = ref('');
const expandedCategory = ref<string>('Getting Started');
const selectedComponentId = ref<string>('installation');

const navRailItems = ref([
  { label: 'Menu', active: true, icon: documentTextOutline }
]);

const handleRailSelect = () => {
  isRailExpanded.value = !isRailExpanded.value;
};

const componentsMenu = [
  {
    category: 'Getting Started',
    icon: rocketOutline,
    items: [
      { id: 'installation', label: 'Installation & Usage' }
    ]
  },
  {
    category: 'Elements',
    icon: cubeOutline,
    items: [
      { id: 'button', label: 'Button' },
      { id: 'button-group', label: 'Button Group' },
      { id: 'toggle-button', label: 'Toggle Button' },
      { id: 'icon-button', label: 'Icon Button' },
      { id: 'fab', label: 'Floating Action Button' },
      { id: 'info-card', label: 'Info Card' },
      { id: 'account-card', label: 'Account Card' },
      { id: 'action-card', label: 'Action Card' },
      { id: 'skeleton', label: 'Skeleton Loading' },
      { id: 'collapse', label: 'Collapse / Accordion' }
    ]
  },
  {
    category: 'Forms',
    icon: documentTextOutline,
    items: [
      { id: 'input', label: 'Text Input & Textarea' },
      { id: 'checkbox', label: 'Checkbox & Group' },
      { id: 'radio', label: 'Radio & Group' },
      { id: 'switch', label: 'Switch Toggle' },
      { id: 'slider', label: 'Slider & Range' },
      { id: 'spinner', label: 'Number Spinner' },
      { id: 'rating', label: 'Rating Stars' },
      { id: 'autocomplete', label: 'Autocomplete' }
    ]
  },
  {
    category: 'Pickers',
    icon: calendarOutline,
    items: [
      { id: 'calendar-standard', label: 'Calendar (Standard)' },
      { id: 'calendar-khmer', label: 'Calendar (Khmer Lunar)' },
      { id: 'date-range', label: 'Date Range Picker' },
      { id: 'month-picker', label: 'Month Picker' },
      { id: 'year-picker', label: 'Year Picker' },
      { id: 'time-picker', label: 'Time Picker' }
    ]
  },
  {
    category: 'Navigation',
    icon: compassOutline,
    items: [
      { id: 'm3-nav', label: 'Bottom Navigation' },
      { id: 'liquid-tab', label: 'Tabs & Segments' },
      { id: 'hide-appbar', label: 'Hide App Bar (Scroll)' },
      { id: 'collapse-appbar', label: 'Collapsing App Bar' },
      { id: 'nav-drawer', label: 'Navigation Drawer' },
      { id: 'nav-rail', label: 'Navigation Rail' },
      { id: 'dynamic-island', label: 'Dynamic Island' },
      { id: 'pull-refresh', label: 'Pull to Refresh' },
      { id: 'swipe-actions', label: 'Swipe Actions' },
      { id: 'feedback-sheets', label: 'Toasts & Action Sheets' },
      { id: 'notifications', label: 'Notifications & Scrolling' }
    ]
  },
  {
    category: 'Security',
    icon: lockClosedOutline,
    items: [
      { id: 'pin-security', label: 'PIN & Security' }
    ]
  },
  {
    category: 'Data Display',
    icon: barChartOutline,
    items: [
      { id: 'charts', label: 'Charts & Graphs' },
      { id: 'account-saving', label: 'Account Saving Sheets' },
      { id: 'account-reorder', label: 'Account Reorder List' },
      { id: 'image-transition', label: 'Image Transition' }
    ]
  },
  {
    category: 'Structure',
    icon: layersOutline,
    items: [
      { id: 'structure', label: 'Structural Components' }
    ]
  }
];

const selectComponent = (id: string) => {
  selectedComponentId.value = id;
};

const currentComponentTitle = computed(() => {
  for (const group of componentsMenu) {
    const found = group.items.find(i => i.id === selectedComponentId.value);
    if (found) return found.label;
  }
  return '';
});

// Map component IDs to their PascalCase component names
const sectionMap: Record<string, string> = {
  "installation": "InstallationSection",
  "button": "ButtonSection",
  "button-group": "ButtonGroupSection",
  "toggle-button": "ToggleButtonSection",
  "icon-button": "IconButtonSection",
  "fab": "FabSection",
  "info-card": "InfoCardSection",
  "account-card": "AccountCardSection",
  "action-card": "ActionCardSection",
  "skeleton": "SkeletonSection",
  "collapse": "CollapseSection",
  "input": "InputSection",
  "checkbox": "CheckboxSection",
  "radio": "RadioSection",
  "switch": "SwitchSection",
  "slider": "SliderSection",
  "spinner": "SpinnerSection",
  "rating": "RatingSection",
  "autocomplete": "AutocompleteSection",
  "calendar-standard": "CalendarStandardSection",
  "calendar-khmer": "CalendarKhmerSection",
  "date-range": "DateRangeSection",
  "month-picker": "MonthPickerSection",
  "year-picker": "YearPickerSection",
  "time-picker": "TimePickerSection",
  "m3-nav": "M3NavSection",
  "liquid-tab": "LiquidTabSection",
  "hide-appbar": "HideAppbarSection",
  "collapse-appbar": "CollapseAppbarSection",
  "nav-drawer": "NavDrawerSection",
  "nav-rail": "NavRailSection",
  "dynamic-island": "DynamicIslandSection",
  "pull-refresh": "PullRefreshSection",
  "swipe-actions": "SwipeActionsSection",
  "feedback-sheets": "FeedbackSheetsSection",
  "notifications": "NotificationsSection",
  "pin-security": "PinSecuritySection",
  "charts": "ChartsSection",
  "account-saving": "AccountSavingSection",
  "account-reorder": "AccountReorderSection",
  "image-transition": "ImageTransitionSection",
  "structure": "StructureSection"
};

const currentComponent = computed(() => {
  const compName = sectionMap[selectedComponentId.value];
  if (!compName) return null;
  return (GuideSections as any)[compName];
});

// Add copy functionality to code blocks when component changes
import { watch, nextTick } from 'vue';

watch(currentComponent, async () => {
  await nextTick();
  // Find all code blocks
  const blocks = document.querySelectorAll('.code-block');
  blocks.forEach(block => {
    // Prevent adding multiple buttons if already processed
    if (block.querySelector('.copy-btn')) return;
    
    // Create copy button
    const btn = document.createElement('button');
    btn.className = 'copy-btn';
    btn.innerHTML = 'Copy';
    
    btn.onclick = () => {
      const code = block.querySelector('code')?.textContent || block.textContent || '';
      navigator.clipboard.writeText(code).then(() => {
        btn.innerHTML = 'Copied!';
        setTimeout(() => { btn.innerHTML = 'Copy'; }, 2000);
      });
    };
    
    block.appendChild(btn);
  });
});

</script>

<style>
.menu-item:hover {
  background: #f4f5f8;
}
.menu-item.active {
  background: #e6f0ff;
  color: #003399 !important;
  font-weight: 600;
  border-right: 3px solid #003399;
}
</style>
