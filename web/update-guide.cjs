const fs = require('fs');
const path = require('path');

const srcFile = path.join(__dirname, 'src/views/UsageGuide.vue');
const content = fs.readFileSync(srcFile, 'utf8');

// 1. Find the start and end of the guide sections in the template
const firstSectionStart = content.indexOf('<div class="guide-section" v-show="selectedComponentId === \'installation\'">');
const lastSectionEndString = '<!-- ==============================';
const lastSectionIndex = content.lastIndexOf('<div class="guide-section" v-show="selectedComponentId === \'structure\'">');

let endIndex = content.indexOf('</div>', lastSectionIndex) + 6;

if (firstSectionStart === -1 || lastSectionIndex === -1) {
  console.error("Could not find sections");
  process.exit(1);
}

// 2. Replace the HTML
const mapJson = {
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

const replacementHtml = `
      <component :is="currentComponent" />
`;

// Remove all the comment separators that were above sections too
// We'll just slice from the first section start to the end index
let beforeHtml = content.substring(0, firstSectionStart);
// remove trailing comments before first section
beforeHtml = beforeHtml.replace(/<!--[\s\S]*?-->\s*$/, '');

const afterHtml = content.substring(endIndex);

let newContent = beforeHtml + replacementHtml + afterHtml;

// 3. Add script variables
const scriptAdditions = `
import * as GuideSections from './guide-sections';

const sectionMap: Record<string, string> = ${JSON.stringify(mapJson, null, 2)};

const currentComponent = computed(() => {
  const compName = sectionMap[selectedComponentId.value];
  return (GuideSections as any)[compName] || null;
});
`;

newContent = newContent.replace('const handleSecureKeypadPress = (v: string) => {', scriptAdditions + '\nconst handleSecureKeypadPress = (v: string) => {');

fs.writeFileSync(srcFile, newContent);
console.log('UsageGuide updated.');
