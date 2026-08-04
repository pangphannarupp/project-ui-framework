<template>
  <ion-page>
    <PPHeaderBar theme="light" :bordered="false">
      <template #left>
        <ion-button router-link="/" fill="clear" style="--padding-start: 0; --padding-end: 0; margin-right: 8px; --color: #1e293b;">
          <ion-icon :icon="arrowBackOutline" />
        </ion-button>
        <h2 style="margin: 0; font-size: 18px; font-weight: 600; color: #1e293b; white-space: nowrap;">Full Component Catalog</h2>
      </template>
      <template #right>
        <div class="mobile-menu-btn-container">
          <ion-button fill="clear" style="--color: #1e293b;" @click="isRailExpanded = !isRailExpanded">
            <ion-icon :icon="menuOutline"></ion-icon>
          </ion-button>
        </div>
      </template>
    </PPHeaderBar>
    
    <div style="display: flex; height: 100vh; overflow: hidden; position: relative;">
      <!-- Mobile overlay -->
      <div 
        class="drawer-overlay" 
        :class="{ active: isRailExpanded }"
        @click="isRailExpanded = false"
      ></div>

      <!-- Navigation Drawer (Accordion) -->
      <div 
        class="rail-drawer" 
        :class="{ expanded: isRailExpanded }"
      >
        <div style="padding: 16px; width: 280px; flex-shrink: 0;">
          <PPSearch 
            v-model="searchQuery" 
            placeholder="Search components..." 
          />
        </div>
        
        <div style="width: 280px; flex: 1; display: flex; flex-direction: column; overflow-y: auto;">
          <PPSidebarNavigation
            v-model="selectedComponentId"
            v-model:expandedItems="expandedGroups"
            :items="sidebarMenuItems"
            theme="light"
            variant="pill"
          />
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
import { ref, computed, watch, onMounted, onUnmounted, nextTick } from 'vue';
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonIcon, IonButton } from '@ionic/vue';
import { rocketOutline, cubeOutline, calendarOutline, compassOutline, lockClosedOutline, barChartOutline, layersOutline, documentTextOutline, menuOutline, searchOutline, arrowBackOutline } from 'ionicons/icons';
import { PPNavigationRail, PPInput, PPSearch, PPCollapse, PPCollapseItem, PPSidebarNavigation, PPHeaderBar } from '@phanna/ui-framework';

import * as GuideSections from './guide-sections';

const isRailExpanded = ref(window.innerWidth > 768);
const searchQuery = ref('');
const expandedGroups = ref<string[]>([]);

const handleResize = () => {
  if (window.innerWidth > 768 && !isRailExpanded.value) {
    isRailExpanded.value = true;
  } else if (window.innerWidth <= 768 && isRailExpanded.value) {
    isRailExpanded.value = false;
  }
};

onMounted(() => window.addEventListener('resize', handleResize));
onUnmounted(() => window.removeEventListener('resize', handleResize));
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
      { id: 'select', label: 'Select' },
      { id: 'transfer-list', label: 'Transfer List' },
      { id: 'fab', label: 'Floating Action Button' },
      { id: 'info-card', label: 'Info Card' },
      // { id: 'account-card', label: 'Account Card' },
      // { id: 'action-card', label: 'Action Card' },
      { id: 'skeleton', label: 'Skeleton Loading' },
      { id: 'collapse', label: 'Collapse / Accordion' },
      { id: 'dev-console', label: 'Developer Console' }
    ]
  },
  {
    category: 'Forms',
    icon: documentTextOutline,
    items: [
      { id: 'search', label: 'Search & History' },
      { id: 'input', label: 'Text Input & Textarea' },
      { id: 'phone-input', label: 'Phone Input' },
      // { id: 'company-selector', label: 'Company Selector' },
      { id: 'checkbox', label: 'Checkbox & Group' },
      { id: 'radio', label: 'Radio & Group' },
      { id: 'switch', label: 'Switch Toggle' },
      { id: 'slider', label: 'Slider & Range' },
      { id: 'spinner', label: 'Number Spinner' },
      { id: 'rating', label: 'Rating Stars' },
      { id: 'autocomplete', label: 'Autocomplete' },
      { id: 'rich-text-editor', label: 'Rich Text Editor' },
      { id: 'math-editor', label: 'Math Editor' },
      { id: 'file-upload', label: 'File Upload (Dropzone)' },
      { id: 'image-cropper', label: 'Image Cropper' },
      { id: 'otp-input', label: 'OTP Input' },
      { id: 'color-picker', label: 'Color Picker' },
      { id: 'signature-pad', label: 'Signature Pad' }
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
      { id: 'quarter-picker', label: 'Quarter Picker' },
      { id: 'year-picker', label: 'Year Picker' },
      { id: 'tree-select', label: 'Tree Select' },
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
      { id: 'kanban', label: 'Kanban Board' },
      { id: 'nav-sidebar', label: 'Sidebar Navigation' },
      { id: 'material-app', label: 'Material App Scaffold' },
      { id: 'navigation-path', label: 'Breadcrumb & Stepper' },
      { id: 'dynamic-island', label: 'Dynamic Island' },
      { id: 'pull-refresh', label: 'Pull to Refresh' },
      { id: 'swipe-actions', label: 'Swipe Actions' },
      { id: 'scroll-segment', label: 'Scroll Segment' },
      { id: 'ribbon', label: 'Ribbon Menu' },
      // { id: 'feedback-sheets', label: 'Toasts & Action Sheets' },
      // { id: 'action-sheets', label: 'Specific Action Sheets' },
      { id: 'web-toast', label: 'Web Toast (Desktop)' },
      // { id: 'notifications', label: 'Notifications & Scrolling' },
      { id: 'tabs', label: 'Tabs' },
      { id: 'scroll-area', label: 'Scroll Area' },
      { id: 'segment', label: 'Segment Controls' },
      { id: 'accordion', label: 'Accordion' },
      { id: 'carousel', label: 'Carousel' }
    ]
  },
  {
    category: 'Templates & Screens',
    icon: layersOutline,
    items: [
      { id: 'auth-screen', label: 'Authentication' },
      { id: 'settings-screen', label: 'Settings & Profile' },
      { id: 'math-exam-screen', label: 'Math Examination' },
      { id: 'dashboard-screen', label: 'Dashboard Template' },
      { id: 'chat-screen', label: 'Chat List' },
      { id: 'chat-detail-screen', label: 'Chat Detail' },
      { id: 'chat-profile-screen', label: 'Chat Profile' },
      { id: 'contacts-screen', label: 'Contacts' },
      { id: 'onboard', label: 'Onboarding Flow' },
      { id: 'layout-patterns', label: '10 Mobile Layout Patterns' }
    ]
  },
  {
    category: 'Deprecated',
    icon: lockClosedOutline,
    items: [
      { id: 'pin-security', label: 'PIN & Security' }
    ]
  },
  {
    category: 'Data Display',
    icon: barChartOutline,
    items: [
      { id: 'data-display-basics', label: 'Basics (Avatar, Badge, Chip)' },
      { id: 'icons', label: 'Icons Collection' },
      { id: 'charts', label: 'Charts & Graphs' },
      // { id: 'account-saving', label: 'Account Saving Sheets' },
      // { id: 'account-reorder', label: 'Account Reorder List' },
      { id: 'image-transition', label: 'Image Transition' },
      { id: 'timeline', label: 'Timeline' },
      { id: 'tree', label: 'Tree View' },
      { id: 'table', label: 'Table & Pagination' },
      { id: 'progress-gauge', label: 'Progress Gauge' },
      { id: 'no-result', label: 'No Result State' },
      // { id: 'cards', label: 'Cards Collection' },
      { id: 'keypads', label: 'Keypads & Security' },
      { id: 'interactive-overlays', label: 'Interactive Overlays' },
      { id: 'bottom-sheet', label: 'Bottom Sheet' },
      { id: 'dialog', label: 'Dialogs' },
      { id: 'reaction-picker', label: 'Reaction Picker' },
      { id: 'advanced-components', label: 'Advanced Components' },
      { id: 'spin-wheel', label: 'Spin the Wheel' }
    ]
  },
  {
    category: 'Structure & Layout',
    icon: layersOutline,
    items: [
      { id: 'header-bottom-bar', label: 'Header & Bottom Bar' }
    ]
  }
];

const sidebarMenuItems = computed(() => {
  return [
    {
      items: filteredMenu.value.map(group => ({
        id: group.category,
        label: group.category,
        icon: group.icon,
        children: group.items.map(item => ({
          id: item.id,
          label: item.label
        }))
      }))
    }
  ];
});

watch(selectedComponentId, (newId) => {
  if (window.innerWidth <= 768) {
    isRailExpanded.value = false;
  }
});

const currentComponentTitle = computed(() => {
  for (const group of componentsMenu) {
    const found = group.items.find(i => i.id === selectedComponentId.value);
    if (found) return found.label;
  }
  return '';
});

const filteredMenu = computed(() => {
  if (!searchQuery.value) return componentsMenu;
  
  const query = searchQuery.value.toLowerCase();
  return componentsMenu.map(group => {
    return {
      ...group,
      items: group.items.filter(item => item.label.toLowerCase().includes(query))
    };
  }).filter(group => group.items.length > 0);
});

watch(searchQuery, (newVal) => {
  if (newVal && filteredMenu.value.length > 0) {
    expandedGroups.value = filteredMenu.value.map(g => g.category);
  }
});

// Map component IDs to their PascalCase component names
const sectionMap: Record<string, string> = {
  "search": "SearchSection",
  "installation": "InstallationSection",
  "input": "InputSection",
  "phone-input": "PhoneInputSection",
  "company-selector": "CompanySelectorSection",
  "button": "ButtonSection",
  "button-group": "ButtonGroupSection",
  "select": "SelectSection",
  "transfer-list": "TransferListSection",
  "text-field": "TextFieldSection",
  "rich-text-editor": "RichTextEditorSection",
  "math-editor": "MathEditorSection",
  "file-upload": "FileUploadSection",
  "image-cropper": "ImageCropperSection",
  "otp-input": "OtpInputSection",
  "color-picker": "ColorPickerSection",
  "signature-pad": "SignaturePadSection",
  "data-display-basics": "DataDisplayBasicsSection",
  "toggle-button": "ToggleButtonSection",
  "icon-button": "IconButtonSection",
  "fab": "FabSection",
  "info-card": "InfoCardSection",
  "account-card": "AccountCardSection",
  "action-card": "ActionCardSection",
  "skeleton": "SkeletonSection",
  "collapse": "CollapseSection",
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
  "quarter-picker": "QuarterPickerSection",
  "year-picker": "YearPickerSection",
  "tree-select": "TreeSelectSection",
  "time-picker": "TimePickerSection",
  "m3-nav": "M3NavSection",
  "liquid-tab": "LiquidTabSection",
  "hide-appbar": "HideAppbarSection",
  "collapse-appbar": "CollapseAppbarSection",
  "nav-drawer": "NavDrawerSection",
  "nav-rail": "NavRailSection",
  "nav-sidebar": "NavSidebarSection",
  "material-app": "MaterialAppSection",
  "navigation-path": "NavigationPathSection",
  "dynamic-island": "DynamicIslandSection",
  "pull-refresh": "PullRefreshSection",
  "swipe-actions": "SwipeActionsSection",
  "feedback-sheets": "FeedbackSheetsSection",
  "web-toast": "WebToastSection",
  "notifications": "NotificationsSection",
  "tabs": "TabsSection",
  "scroll-area": "ScrollAreaSection",
  "accordion": "CollapseSection",
  "interactive-overlays": "InteractiveOverlaysSection",
  "scroll-segment": "ScrollSegmentSection",
  "ribbon": "RibbonSection",
  "action-sheets": "ActionSheetsSection",
  "cards": "CardsSection",
  "keypads": "KeypadsSection",
  "progress-gauge": "ProgressGaugeSection",
  "no-result": "NoResultSection",
  "pin-security": "PinSecuritySection",
  "draggable-grid": "DraggableGridSection",
  "tree": "TreeSection",
  "carousel": "CarouselSection",
  "kanban": "KanbanSection",
  "auth-screen": "AuthScreen",
  "settings-screen": "SettingsScreen",
  "math-exam-screen": "MathExamScreen",
  "dashboard-screen": "DashboardScreen",
  "chat-screen": "ChatScreen",
  "chat-detail-screen": "ChatDetailScreen",
  "chat-profile-screen": "ChatProfileScreen",
  "contacts-screen": "ContactsScreen",
  "layout-patterns": "LayoutPatternsSection",
  "onboard": "OnboardSection",
  "timeline": "TimelineSection",
  "charts": "ChartsSection",
  "account-saving": "AccountSavingSection",
  "account-reorder": "AccountReorderSection",
  "image-transition": "ImageTransitionSection",
  "structure": "StructureSection",
  "header-bottom-bar": "HeaderBottomBarSection",
  "table": "TableSection",
  "dev-console": "DevConsoleSection",
  "reaction-picker": "ReactionPickerSection",
  "advanced-components": "AdvancedComponentsSection",
  "icons": "IconsSection",
  "segment": "SegmentSection",
  "bottom-sheet": "BottomSheetSection",
  "dialog": "DialogSection",
  "spin-wheel": "SpinWheelSection"
};

const currentComponent = computed(() => {
  const compName = sectionMap[selectedComponentId.value];
  if (!compName) return null;
  return (GuideSections as any)[compName];
});

// Add copy functionality to code blocks when component changes

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

<style scoped>
.menu-item:hover {
  background: #f4f5f8;
}
.menu-item.active {
  background: #e6f0ff;
  color: #003399 !important;
  font-weight: 600;
  border-right: 3px solid #003399;
}

.rail-drawer {
  background: #ffffff;
  height: 100%;
  transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1), transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow-y: auto;
  overflow-x: hidden;
  width: 0px;
}

.rail-drawer.expanded {
  width: 280px;
}

.drawer-overlay {
  display: none;
}

.mobile-menu-btn-container {
  display: none;
}

@media (max-width: 768px) {
  .mobile-menu-btn-container {
    display: flex;
  }
  
  .rail-drawer {
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    z-index: 100;
    width: 280px !important;
    transform: translateX(-100%);
  }
  
  .rail-drawer.expanded {
    transform: translateX(0);
  }
  
  .drawer-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.5);
    z-index: 99;
    display: none;
  }
  
  .drawer-overlay.active {
    display: block;
  }
}
</style>
