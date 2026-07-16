import { defineCustomElement } from 'vue'
import MyButton from './components/MyButton.vue'
import MyList from './components/MyList.vue'
import BizButton from './components/BizButton.vue'
import BizButtonGroup from './components/BizButtonGroup.vue'
import BizSegment from './components/BizSegment.vue'
import BizSegmentButton from './components/BizSegmentButton.vue'
import BizInput from './components/BizInput.vue'
import BizTextField from './components/BizTextField.vue'
import BizToggleButton from './components/BizToggleButton.vue'
import BizSelect from './components/BizSelect.vue'
import BizFileUpload from './components/BizFileUpload.vue'
import BizTransferList from './components/BizTransferList.vue'
import BizAutocomplete from './components/BizAutocomplete.vue'
import BizCheckbox from './components/BizCheckbox.vue'
import BizCheckboxGroup from './components/BizCheckboxGroup.vue'
import BizFab from './components/BizFab.vue'
import BizFabList from './components/BizFabList.vue'
import BizFabAction from './components/BizFabAction.vue'
import BizNumberSpinner from './components/BizNumberSpinner.vue'
import BizRadio from './components/BizRadio.vue'
import BizRadioGroup from './components/BizRadioGroup.vue'
import BizRating from './components/BizRating.vue'
import BizCollapsingToolbar from './components/BizCollapsingToolbar.vue'
import BizPullToRefresh from './components/BizPullToRefresh.vue'
import BizImageTransition from './components/BizImageTransition.vue'
import BizSlider from './components/BizSlider.vue'
import BizSwitch from './components/BizSwitch.vue'
import BizSwipeItem from './components/BizSwipeItem.vue'
import BizBarChart from './components/BizBarChart.vue'
import BizLineChart from './components/BizLineChart.vue'
import BizDonutChart from './components/BizDonutChart.vue'
import BizPieChart from './components/BizPieChart.vue'
import BizRadarChart from './components/BizRadarChart.vue'
import BizProgressGauge from './components/BizProgressGauge.vue'
import BizScatterChart from './components/BizScatterChart.vue'
import BizFunnelChart from './components/BizFunnelChart.vue'
import BizSkeleton from './components/BizSkeleton.vue'
import BizSkeletonItem from './components/BizSkeletonItem.vue'
import BizSkeletonList from './components/BizSkeletonList.vue'
import BizSkeletonDetail from './components/BizSkeletonDetail.vue'
import BizHideAppBar from './components/BizHideAppBar.vue'
import BizBottomNav from './components/BizBottomNav.vue'
import BizBottomSheet from './components/BizBottomSheet.vue'
import BizBiometricSheet from './components/BizBiometricSheet.vue'
import BizLanguageSheet from './components/BizLanguageSheet.vue'
import BizFilterSheet from './components/BizFilterSheet.vue'
import BizSortSheet from './components/BizSortSheet.vue'
import BizScrollSegment from './components/BizScrollSegment.vue'
import BizScrollSegmentButton from './components/BizScrollSegmentButton.vue'
import BizUserCard from './components/BizUserCard.vue'
import BizCountryCodeSheet from './components/BizCountryCodeSheet.vue'
import BizUpgradeCard from './components/BizUpgradeCard.vue'
import BizVerificationCard from './components/BizVerificationCard.vue'
import BizSkipButton from './components/BizSkipButton.vue'
import BizFeedbackSheet from './components/BizFeedbackSheet.vue'
import BizIconButton from './components/BizIconButton.vue'
import BizUserProfile from './components/BizUserProfile.vue'
import BizCompanySelector from './components/BizCompanySelector.vue'
import BizActionCard from './components/BizActionCard.vue'
import BizAccountCard from './components/BizAccountCard.vue'
import BizPhoneInput from './components/BizPhoneInput.vue'
import BizOtpInput from './components/BizOtpInput.vue'
import BizInfoCard from './components/BizInfoCard.vue'
import BizPinDots from './components/BizPinDots.vue'
import BizKeypad from './components/BizKeypad.vue'
import BizSecureKeypad from './components/BizSecureKeypad.vue'
import BizSecureKeyboard from './components/BizSecureKeyboard.vue'
import BizNoResult from './components/BizNoResult.vue'
import BizAppBar from './components/BizAppBar.vue'
import BizToast from './components/BizToast.vue'
import BizConfirmSheet from './components/BizConfirmSheet.vue'
import BizReceiveAmountSheet from './components/BizReceiveAmountSheet.vue'
import BizAccountSavingCard from './components/BizAccountSavingCard.vue'
import BizReceivingAccountSheet from './components/BizReceivingAccountSheet.vue'
import BizKhmerCalendar from './components/BizKhmerCalendar.vue'
import BizKhmerCalendarSheet from './components/BizKhmerCalendarSheet.vue'
import BizKhmerCalendarAlert from './components/BizKhmerCalendarAlert.vue'
import BizCalendar from './components/BizCalendar.vue'
import BizCalendarSheet from './components/BizCalendarSheet.vue'
import BizCalendarAlert from './components/BizCalendarAlert.vue'
import BizMonthPicker from './components/BizMonthPicker.vue'
import BizMonthPickerSheet from './components/BizMonthPickerSheet.vue'
import BizMonthPickerAlert from './components/BizMonthPickerAlert.vue'
import BizYearPicker from './components/BizYearPicker.vue'
import BizYearPickerSheet from './components/BizYearPickerSheet.vue'
import BizYearPickerAlert from './components/BizYearPickerAlert.vue'
import BizAccountListCard from './components/BizAccountListCard.vue'
import BizAccountReorderList from './components/BizAccountReorderList.vue'

const components = {
  'my-button': MyButton,
  'my-list': MyList,
  'biz-button': BizButton,
  'biz-button-group': BizButtonGroup,
  'biz-segment': BizSegment,
  'biz-segment-button': BizSegmentButton,
  'biz-input': BizInput,
  'biz-text-field': BizTextField,
  'biz-toggle-button': BizToggleButton,
  'biz-select': BizSelect,
  'biz-file-upload': BizFileUpload,
  'biz-transfer-list': BizTransferList,
  'biz-autocomplete': BizAutocomplete,
  'biz-checkbox': BizCheckbox,
  'biz-checkbox-group': BizCheckboxGroup,
  'biz-fab': BizFab,
  'biz-fab-list': BizFabList,
  'biz-fab-action': BizFabAction,
  'biz-number-spinner': BizNumberSpinner,
  'biz-radio': BizRadio,
  'biz-radio-group': BizRadioGroup,
  'biz-rating': BizRating,
  'biz-collapsing-toolbar': BizCollapsingToolbar,
  'biz-pull-to-refresh': BizPullToRefresh,
  'biz-slider': BizSlider,
  'biz-switch': BizSwitch,
  'biz-image-transition': BizImageTransition,
  'biz-swipe-item': BizSwipeItem,
  'biz-bar-chart': BizBarChart,
  'biz-line-chart': BizLineChart,
  'biz-donut-chart': BizDonutChart,
  'biz-pie-chart': BizPieChart,
  'biz-radar-chart': BizRadarChart,
  'biz-progress-gauge': BizProgressGauge,
  'biz-scatter-chart': BizScatterChart,
  'biz-funnel-chart': BizFunnelChart,
  'biz-skeleton': BizSkeleton,
  'biz-skeleton-item': BizSkeletonItem,
  'biz-skeleton-list': BizSkeletonList,
  'biz-skeleton-detail': BizSkeletonDetail,
  'biz-hide-appbar': BizHideAppBar,
  'biz-bottom-sheet': BizBottomSheet,
  'biz-biometric-sheet': BizBiometricSheet,
  'biz-language-sheet': BizLanguageSheet,
  'biz-filter-sheet': BizFilterSheet,
  'biz-sort-sheet': BizSortSheet,
  'biz-scroll-segment': BizScrollSegment,
  'biz-scroll-segment-button': BizScrollSegmentButton,
  'biz-user-card': BizUserCard,
  'biz-country-code-sheet': BizCountryCodeSheet,
  'biz-upgrade-card': BizUpgradeCard,
  'biz-verification-card': BizVerificationCard,
  'biz-skip-button': BizSkipButton,
  'biz-feedback-sheet': BizFeedbackSheet,
  'biz-icon-button': BizIconButton,
  'biz-user-profile': BizUserProfile,
  'biz-company-selector': BizCompanySelector,
  'biz-action-card': BizActionCard,
  'biz-account-card': BizAccountCard,
  'biz-bottom-nav': BizBottomNav,
  'biz-phone-input': BizPhoneInput,
  'biz-otp-input': BizOtpInput,
  'biz-info-card': BizInfoCard,
  'biz-pin-dots': BizPinDots,
  'biz-keypad': BizKeypad,
  'biz-secure-keypad': BizSecureKeypad,
  'biz-secure-keyboard': BizSecureKeyboard,
  'biz-no-result': BizNoResult,
  'biz-app-bar': BizAppBar,
  'biz-toast': BizToast,
  'biz-confirm-sheet': BizConfirmSheet,
  'biz-receive-amount-sheet': BizReceiveAmountSheet,
  'biz-account-saving-card': BizAccountSavingCard,
  'biz-receiving-account-sheet': BizReceivingAccountSheet,
  'biz-khmer-calendar': BizKhmerCalendar,
  'biz-khmer-calendar-sheet': BizKhmerCalendarSheet,
  'biz-khmer-calendar-alert': BizKhmerCalendarAlert,
  'biz-calendar': BizCalendar,
  'biz-calendar-sheet': BizCalendarSheet,
  'biz-calendar-alert': BizCalendarAlert,
  'biz-month-picker': BizMonthPicker,
  'biz-month-picker-sheet': BizMonthPickerSheet,
  'biz-month-picker-alert': BizMonthPickerAlert,
  'biz-year-picker': BizYearPicker,
  'biz-year-picker-sheet': BizYearPickerSheet,
  'biz-year-picker-alert': BizYearPickerAlert,
  'biz-account-list-card': BizAccountListCard,
  'biz-account-reorder-list': BizAccountReorderList
};

export function registerWebComponents() {
  for (const [name, component] of Object.entries(components)) {
    if (!customElements.get(name)) {
      const CustomElement = defineCustomElement(component as any);
      customElements.define(name, CustomElement);
    }
  }
}
