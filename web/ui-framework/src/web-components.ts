import { defineCustomElement } from 'vue'
import MyButton from './components/MyButton.vue'
import MyList from './components/MyList.vue'
import PPButton from './components/PPButton.vue'
import PPButtonGroup from './components/PPButtonGroup.vue'
import PPSegment from './components/PPSegment.vue'
import PPSegmentButton from './components/PPSegmentButton.vue'
import PPInput from './components/PPInput.vue'
import PPTextField from './components/PPTextField.vue'
import PPToggleButton from './components/PPToggleButton.vue'
import PPSelect from './components/PPSelect.vue'
import PPFileUpload from './components/PPFileUpload.vue'
import PPTransferList from './components/PPTransferList.vue'
import PPAutocomplete from './components/PPAutocomplete.vue'
import PPCheckbox from './components/PPCheckbox.vue'
import PPCheckboxGroup from './components/PPCheckboxGroup.vue'
import PPFab from './components/PPFab.vue'
import PPFabList from './components/PPFabList.vue'
import PPFabAction from './components/PPFabAction.vue'
import PPNumberSpinner from './components/PPNumberSpinner.vue'
import PPRadio from './components/PPRadio.vue'
import PPRadioGroup from './components/PPRadioGroup.vue'
import PPRating from './components/PPRating.vue'
import PPCollapsingToolbar from './components/PPCollapsingToolbar.vue'
import PPPullToRefresh from './components/PPPullToRefresh.vue'
import PPImageTransition from './components/PPImageTransition.vue'
import PPSlider from './components/PPSlider.vue'
import PPSwitch from './components/PPSwitch.vue'
import PPSwipeItem from './components/PPSwipeItem.vue'
import PPBarChart from './components/PPBarChart.vue'
import PPLineChart from './components/PPLineChart.vue'
import PPDonutChart from './components/PPDonutChart.vue'
import PPPieChart from './components/PPPieChart.vue'
import PPRadarChart from './components/PPRadarChart.vue'
import PPProgressGauge from './components/PPProgressGauge.vue'
import PPScatterChart from './components/PPScatterChart.vue'
import PPFunnelChart from './components/PPFunnelChart.vue'
import PPSkeleton from './components/PPSkeleton.vue'
import PPSkeletonItem from './components/PPSkeletonItem.vue'
import PPSkeletonList from './components/PPSkeletonList.vue'
import PPSkeletonDetail from './components/PPSkeletonDetail.vue'
import PPHideAppBar from './components/PPHideAppBar.vue'
import PPBottomNav from './components/PPBottomNav.vue'
import PPBottomSheet from './components/PPBottomSheet.vue'
import PPBiometricSheet from './components/PPBiometricSheet.vue'
import PPLanguageSheet from './components/PPLanguageSheet.vue'
import PPFilterSheet from './components/PPFilterSheet.vue'
import PPSortSheet from './components/PPSortSheet.vue'
import PPScrollSegment from './components/PPScrollSegment.vue'
import PPScrollSegmentButton from './components/PPScrollSegmentButton.vue'
import PPUserCard from './components/PPUserCard.vue'
import PPCountryCodeSheet from './components/PPCountryCodeSheet.vue'
import PPUpgradeCard from './components/PPUpgradeCard.vue'
import PPVerificationCard from './components/PPVerificationCard.vue'
import PPSkipButton from './components/PPSkipButton.vue'
import PPFeedbackSheet from './components/PPFeedbackSheet.vue'
import PPIconButton from './components/PPIconButton.vue'
import PPUserProfile from './components/PPUserProfile.vue'
import PPCompanySelector from './components/PPCompanySelector.vue'
import PPActionCard from './components/PPActionCard.vue'
import PPAccountCard from './components/PPAccountCard.vue'
import PPPhoneInput from './components/PPPhoneInput.vue'
import PPOtpInput from './components/PPOtpInput.vue'
import PPInfoCard from './components/PPInfoCard.vue'
import PPPinDots from './components/PPPinDots.vue'
import PPKeypad from './components/PPKeypad.vue'
import PPSecureKeypad from './components/PPSecureKeypad.vue'
import PPSecureKeyboard from './components/PPSecureKeyboard.vue'
import PPNoResult from './components/PPNoResult.vue'
import PPAppBar from './components/PPAppBar.vue'
import PPToast from './components/PPToast.vue'
import PPConfirmSheet from './components/PPConfirmSheet.vue'
import PPReceiveAmountSheet from './components/PPReceiveAmountSheet.vue'
import PPAccountSavingCard from './components/PPAccountSavingCard.vue'
import PPReceivingAccountSheet from './components/PPReceivingAccountSheet.vue'
import PPKhmerCalendar from './components/PPKhmerCalendar.vue'
import PPKhmerCalendarSheet from './components/PPKhmerCalendarSheet.vue'
import PPKhmerCalendarAlert from './components/PPKhmerCalendarAlert.vue'
import PPCalendar from './components/PPCalendar.vue'
import PPDateRangePickerSheet from './components/PPDateRangePickerSheet.vue'
import PPDateRangePickerAlert from './components/PPDateRangePickerAlert.vue'
import PPDateRangePicker from './components/PPDateRangePicker.vue'
import PPCalendarSheet from './components/PPCalendarSheet.vue'
import PPCalendarAlert from './components/PPCalendarAlert.vue'
import PPMonthPicker from './components/PPMonthPicker.vue'
import PPMonthPickerSheet from './components/PPMonthPickerSheet.vue'
import PPMonthPickerAlert from './components/PPMonthPickerAlert.vue'
import PPYearPicker from './components/PPYearPicker.vue'
import PPYearPickerSheet from './components/PPYearPickerSheet.vue'
import PPYearPickerAlert from './components/PPYearPickerAlert.vue'
import PPAccountListCard from './components/PPAccountListCard.vue'
import PPAccountReorderList from './components/PPAccountReorderList.vue'
import PPColorPicker from './components/PPColorPicker.vue'
import PPColorPickerSheet from './components/PPColorPickerSheet.vue'
import PPColorPickerAlert from './components/PPColorPickerAlert.vue'
import PPRibbon from './components/PPRibbon.vue'
import PPRibbonTab from './components/PPRibbonTab.vue'
import PPRibbonGroup from './components/PPRibbonGroup.vue'
import PPRibbonButton from './components/PPRibbonButton.vue'
import PPTimeline from './components/PPTimeline.vue'
import PPTimelineItem from './components/PPTimelineItem.vue'
import PPTree from './components/PPTree.vue'
import PPTreeNode from './components/PPTreeNode.vue'
import PPWebToast from './components/PPWebToast.vue'
import PPPagination from './components/PPPagination.vue'
import PPTable from './components/PPTable.vue'

const components = {
  'my-button': MyButton,
  'my-list': MyList,
  'pp-button': PPButton,
  'pp-button-group': PPButtonGroup,
  'pp-segment': PPSegment,
  'pp-segment-button': PPSegmentButton,
  'pp-input': PPInput,
  'pp-text-field': PPTextField,
  'pp-toggle-button': PPToggleButton,
  'pp-select': PPSelect,
  'pp-file-upload': PPFileUpload,
  'pp-transfer-list': PPTransferList,
  'pp-autocomplete': PPAutocomplete,
  'pp-checkbox': PPCheckbox,
  'pp-checkbox-group': PPCheckboxGroup,
  'pp-fab': PPFab,
  'pp-fab-list': PPFabList,
  'pp-fab-action': PPFabAction,
  'pp-number-spinner': PPNumberSpinner,
  'pp-radio': PPRadio,
  'pp-radio-group': PPRadioGroup,
  'pp-rating': PPRating,
  'pp-collapsing-toolbar': PPCollapsingToolbar,
  'pp-pull-to-refresh': PPPullToRefresh,
  'pp-slider': PPSlider,
  'pp-switch': PPSwitch,
  'pp-image-transition': PPImageTransition,
  'pp-swipe-item': PPSwipeItem,
  'pp-bar-chart': PPBarChart,
  'pp-line-chart': PPLineChart,
  'pp-donut-chart': PPDonutChart,
  'pp-pie-chart': PPPieChart,
  'pp-radar-chart': PPRadarChart,
  'pp-progress-gauge': PPProgressGauge,
  'pp-scatter-chart': PPScatterChart,
  'pp-funnel-chart': PPFunnelChart,
  'pp-skeleton': PPSkeleton,
  'pp-skeleton-item': PPSkeletonItem,
  'pp-skeleton-list': PPSkeletonList,
  'pp-skeleton-detail': PPSkeletonDetail,
  'pp-hide-appbar': PPHideAppBar,
  'pp-bottom-sheet': PPBottomSheet,
  'pp-biometric-sheet': PPBiometricSheet,
  'pp-language-sheet': PPLanguageSheet,
  'pp-filter-sheet': PPFilterSheet,
  'pp-sort-sheet': PPSortSheet,
  'pp-scroll-segment': PPScrollSegment,
  'pp-scroll-segment-button': PPScrollSegmentButton,
  'pp-user-card': PPUserCard,
  'pp-country-code-sheet': PPCountryCodeSheet,
  'pp-upgrade-card': PPUpgradeCard,
  'pp-verification-card': PPVerificationCard,
  'pp-skip-button': PPSkipButton,
  'pp-feedback-sheet': PPFeedbackSheet,
  'pp-icon-button': PPIconButton,
  'pp-user-profile': PPUserProfile,
  'pp-company-selector': PPCompanySelector,
  'pp-action-card': PPActionCard,
  'pp-account-card': PPAccountCard,
  'pp-bottom-nav': PPBottomNav,
  'pp-phone-input': PPPhoneInput,
  'pp-otp-input': PPOtpInput,
  'pp-info-card': PPInfoCard,
  'pp-pin-dots': PPPinDots,
  'pp-keypad': PPKeypad,
  'pp-secure-keypad': PPSecureKeypad,
  'pp-secure-keyboard': PPSecureKeyboard,
  'pp-no-result': PPNoResult,
  'pp-app-bar': PPAppBar,
  'pp-toast': PPToast,
  'pp-confirm-sheet': PPConfirmSheet,
  'pp-receive-amount-sheet': PPReceiveAmountSheet,
  'pp-account-saving-card': PPAccountSavingCard,
  'pp-receiving-account-sheet': PPReceivingAccountSheet,
  'pp-khmer-calendar': PPKhmerCalendar,
  'pp-khmer-calendar-sheet': PPKhmerCalendarSheet,
  'pp-khmer-calendar-alert': PPKhmerCalendarAlert,
  'pp-calendar': PPCalendar,
  'pp-date-range-picker-sheet': PPDateRangePickerSheet,
  'pp-date-range-picker-alert': PPDateRangePickerAlert,
  'pp-date-range-picker': PPDateRangePicker,
  'pp-calendar-sheet': PPCalendarSheet,
  'pp-calendar-alert': PPCalendarAlert,
  'pp-month-picker': PPMonthPicker,
  'pp-month-picker-sheet': PPMonthPickerSheet,
  'pp-month-picker-alert': PPMonthPickerAlert,
  'pp-year-picker': PPYearPicker,
  'pp-year-picker-sheet': PPYearPickerSheet,
  'pp-year-picker-alert': PPYearPickerAlert,
  'pp-account-list-card': PPAccountListCard,
  'pp-account-reorder-list': PPAccountReorderList,
  'pp-color-picker': PPColorPicker,
  'pp-color-picker-sheet': PPColorPickerSheet,
  'pp-color-picker-alert': PPColorPickerAlert,
  'pp-ribbon': PPRibbon,
  'pp-ribbon-tab': PPRibbonTab,
  'pp-ribbon-group': PPRibbonGroup,
  'pp-ribbon-button': PPRibbonButton,
  'pp-timeline': PPTimeline,
  'pp-timeline-item': PPTimelineItem,
  'pp-tree': PPTree,
  'pp-tree-node': PPTreeNode,
  'pp-web-toast': PPWebToast,
  'pp-pagination': PPPagination,
  'pp-table': PPTable
};

export function registerWebComponents() {
  for (const [name, component] of Object.entries(components)) {
    if (!customElements.get(name)) {
      const CustomElement = defineCustomElement(component as any);
      customElements.define(name, CustomElement);
    }
  }
}
