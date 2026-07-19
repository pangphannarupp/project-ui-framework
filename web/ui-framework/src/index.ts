import type { App } from 'vue'
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
import BizKhmerKeyboard from './components/BizKhmerKeyboard.vue'
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
import BizKhmerCalendarIsland from './components/BizKhmerCalendarIsland.vue'
import BizCalendar from './components/BizCalendar.vue'
import BizDateRangePickerSheet from './components/BizDateRangePickerSheet.vue'
import BizDateRangePickerAlert from './components/BizDateRangePickerAlert.vue'
import BizDateRangePicker from './components/BizDateRangePicker.vue'
import BizCalendarSheet from './components/BizCalendarSheet.vue'
import BizCalendarAlert from './components/BizCalendarAlert.vue'
import BizCalendarIsland from './components/BizCalendarIsland.vue'
import BizMonthPicker from './components/BizMonthPicker.vue'
import BizMonthPickerSheet from './components/BizMonthPickerSheet.vue'
import BizMonthPickerAlert from './components/BizMonthPickerAlert.vue'
import BizMonthPickerIsland from './components/BizMonthPickerIsland.vue'
import BizDraggableGrid from './components/BizDraggableGrid.vue'
import BizMarquee from './components/BizMarquee.vue'
import BizCarousel from './components/BizCarousel.vue'
import BizCarouselItem from './components/BizCarouselItem.vue'
import BizRichTextEditor from './components/BizRichTextEditor.vue'
import BizMathEditor from './components/BizMathEditor.vue'
import BizMathPreview from './components/BizMathPreview.vue'
import BizKanbanBoard from './components/BizKanbanBoard.vue'
import BizYearPicker from './components/BizYearPicker.vue'
import BizYearPickerSheet from './components/BizYearPickerSheet.vue'
import BizYearPickerAlert from './components/BizYearPickerAlert.vue'
import BizYearPickerIsland from './components/BizYearPickerIsland.vue'
import BizAccountListCard from './components/BizAccountListCard.vue'
import BizAccountReorderList from './components/BizAccountReorderList.vue'
import BizTimePicker from './components/BizTimePicker.vue'
import BizTimePickerSheet from './components/BizTimePickerSheet.vue'
import BizTimePickerAlert from './components/BizTimePickerAlert.vue'
import BizTimePickerIsland from './components/BizTimePickerIsland.vue'
import BizNotificationItem from './components/BizNotificationItem.vue'
import BizColorPicker from './components/BizColorPicker.vue'
import BizColorPickerSheet from './components/BizColorPickerSheet.vue'
import BizColorPickerAlert from './components/BizColorPickerAlert.vue'
import BizColorPickerIsland from './components/BizColorPickerIsland.vue'
import BizNavigationDrawer from './components/BizNavigationDrawer.vue'
import BizNavigationRail from './components/BizNavigationRail.vue'
import BizDynamicIsland from './components/BizDynamicIsland.vue'
import BizRibbon from './components/BizRibbon.vue'
import BizRibbonTab from './components/BizRibbonTab.vue'
import BizRibbonGroup from './components/BizRibbonGroup.vue'
import BizRibbonButton from './components/BizRibbonButton.vue'
import BizCollapse from './components/BizCollapse.vue'
import BizCollapseItem from './components/BizCollapseItem.vue'
import BizTimeline from './components/BizTimeline.vue'
import BizTimelineItem from './components/BizTimelineItem.vue'
import BizTree from './components/BizTree.vue'
import BizTreeNode from './components/BizTreeNode.vue'
import BizWebToast from './components/BizWebToast.vue'
import BizPagination from './components/BizPagination.vue'
import BizTable from './components/BizTable.vue'

// Export components individually
export { 
  MyButton, 
  MyList, 
  BizButton, 
  BizButtonGroup,
  BizDraggableGrid,
  BizMarquee,
  BizCarousel,
  BizCarouselItem,
  BizSegment, 
  BizSegmentButton, 
  BizInput,
  BizTextField,
  BizToggleButton,
  BizSelect,
  BizRichTextEditor,
  BizMathEditor,
  BizMathPreview,
  BizKanbanBoard,
  BizFileUpload,
  BizTransferList,
  BizAutocomplete, 
  BizCheckbox,
  BizCheckboxGroup,
  BizFab,
  BizFabList,
  BizFabAction,
  BizNumberSpinner,
  BizRadio,
  BizRadioGroup,
  BizRating,
  BizCollapsingToolbar,
  BizPullToRefresh,
  BizSlider,
  BizSwitch,
  BizImageTransition,
  BizSwipeItem,
  BizBarChart,
  BizLineChart,
  BizDonutChart,
  BizPieChart,
  BizRadarChart,
  BizProgressGauge,
  BizScatterChart,
  BizFunnelChart,
  BizSkeleton,
  BizSkeletonItem,
  BizSkeletonList,
  BizSkeletonDetail,
  BizHideAppBar,
  BizBottomNav,
  BizBottomSheet,
  BizBiometricSheet,
  BizLanguageSheet,
  BizCountryCodeSheet,
  BizFeedbackSheet,
  BizFilterSheet,
  BizSortSheet,
  BizScrollSegment,
  BizScrollSegmentButton,
  BizUserCard,
  BizUpgradeCard,
  BizVerificationCard,
  BizSkipButton,
  BizIconButton,
  BizUserProfile,
  BizCompanySelector,
  BizActionCard,
  BizAccountCard,
  BizPhoneInput,
  BizOtpInput,
  BizInfoCard,
  BizPinDots,
  BizKeypad,
  BizSecureKeypad,
  BizSecureKeyboard,
  BizKhmerKeyboard,
  BizNoResult,
  BizAppBar,
  BizToast,
  BizConfirmSheet,
  BizReceiveAmountSheet,
  BizAccountSavingCard,
  BizReceivingAccountSheet,
  BizKhmerCalendar,
  BizKhmerCalendarSheet,
  BizKhmerCalendarAlert,
  BizKhmerCalendarIsland,
  BizCalendar,
  BizDateRangePickerSheet,
  BizDateRangePickerAlert,
  BizDateRangePicker,
  BizCalendarSheet,
  BizCalendarAlert,
  BizCalendarIsland,
  BizMonthPicker,
  BizMonthPickerSheet,
  BizMonthPickerAlert,
  BizMonthPickerIsland,
  BizYearPicker,
  BizYearPickerSheet,
  BizYearPickerAlert,
  BizYearPickerIsland,
  BizAccountListCard,
  BizAccountReorderList,
  BizTimePicker,
  BizTimePickerSheet,
  BizTimePickerAlert,
  BizTimePickerIsland,
  BizNotificationItem,
  BizColorPicker,
  BizColorPickerSheet,
  BizColorPickerAlert,
  BizColorPickerIsland,
  BizNavigationDrawer,
  BizNavigationRail,
  BizDynamicIsland,
  BizRibbon,
  BizRibbonTab,
  BizRibbonGroup,
  BizRibbonButton,
  BizCollapse,
  BizCollapseItem,
  BizTimeline,
  BizTimelineItem,
  BizTree,
  BizTreeNode,
  BizWebToast,
  BizPagination,
  BizTable
}

// Export a Vue plugin to install all components
export default {
  install: (app: App) => {
    app.component('MyButton', MyButton)
    app.component('MyList', MyList)
    app.component('BizButton', BizButton)
    app.component('BizButtonGroup', BizButtonGroup)
    app.component('BizSegment', BizSegment)
    app.component('BizSegmentButton', BizSegmentButton)
    app.component('BizInput', BizInput)
    app.component('BizTextField', BizTextField)
    app.component('BizToggleButton', BizToggleButton)
    app.component('BizSelect', BizSelect)
    app.component('BizFileUpload', BizFileUpload)
    app.component('BizTransferList', BizTransferList)
    app.component('BizAutocomplete', BizAutocomplete)
    app.component('BizCheckbox', BizCheckbox)
    app.component('BizCheckboxGroup', BizCheckboxGroup)
    app.component('BizFab', BizFab)
    app.component('BizFabList', BizFabList)
    app.component('BizFabAction', BizFabAction)
    app.component('BizNumberSpinner', BizNumberSpinner)
    app.component('BizRadio', BizRadio)
    app.component('BizRadioGroup', BizRadioGroup)
    app.component('BizRating', BizRating)
    app.component('BizCollapsingToolbar', BizCollapsingToolbar)
    app.component('BizPullToRefresh', BizPullToRefresh)
    app.component('BizPinDots', BizPinDots)
    app.component('BizKeypad', BizKeypad)
    app.component('BizSecureKeypad', BizSecureKeypad)
    app.component('BizSecureKeyboard', BizSecureKeyboard)
    app.component('BizKhmerKeyboard', BizKhmerKeyboard)
    app.component('BizImageTransition', BizImageTransition)
    app.component('BizSwipeItem', BizSwipeItem)
    app.component('BizBarChart', BizBarChart)
    app.component('BizLineChart', BizLineChart)
    app.component('BizDonutChart', BizDonutChart)
    app.component('BizPieChart', BizPieChart)
    app.component('BizRadarChart', BizRadarChart)
    app.component('BizProgressGauge', BizProgressGauge)
    app.component('BizScatterChart', BizScatterChart)
    app.component('BizFunnelChart', BizFunnelChart)
    app.component('BizSkeleton', BizSkeleton)
    app.component('BizSkeletonItem', BizSkeletonItem)
    app.component('BizSkeletonList', BizSkeletonList)
    app.component('BizSkeletonDetail', BizSkeletonDetail)
    app.component('BizHideAppBar', BizHideAppBar)
    app.component('BizBottomSheet', BizBottomSheet)
    app.component('BizBiometricSheet', BizBiometricSheet)
    app.component('BizLanguageSheet', BizLanguageSheet)
    app.component('BizCountryCodeSheet', BizCountryCodeSheet)
    app.component('BizFeedbackSheet', BizFeedbackSheet)
    app.component('BizFilterSheet', BizFilterSheet)
    app.component('BizSortSheet', BizSortSheet)
    app.component('BizScrollSegment', BizScrollSegment)
    app.component('BizScrollSegmentButton', BizScrollSegmentButton)
    app.component('BizUserCard', BizUserCard)
    app.component('BizUpgradeCard', BizUpgradeCard)
    app.component('BizVerificationCard', BizVerificationCard)
    app.component('BizSkipButton', BizSkipButton)
    app.component('BizIconButton', BizIconButton)
    app.component('BizUserProfile', BizUserProfile)
    app.component('BizCompanySelector', BizCompanySelector)
    app.component('BizActionCard', BizActionCard)
    app.component('BizAccountCard', BizAccountCard)
    app.component('BizBottomNav', BizBottomNav)
    app.component('BizPhoneInput', BizPhoneInput)
    app.component('BizOtpInput', BizOtpInput)
    app.component('BizInfoCard', BizInfoCard)
    app.component('BizNoResult', BizNoResult)
    app.component('BizAppBar', BizAppBar)
    app.component('BizToast', BizToast)
    app.component('BizKhmerCalendar', BizKhmerCalendar)
    app.component('BizKhmerCalendarSheet', BizKhmerCalendarSheet)
    app.component('BizKhmerCalendarAlert', BizKhmerCalendarAlert)
    app.component('BizKhmerCalendarIsland', BizKhmerCalendarIsland)
    app.component('BizCalendar', BizCalendar)
    app.component('BizDateRangePickerSheet', BizDateRangePickerSheet)
    app.component('BizDateRangePickerAlert', BizDateRangePickerAlert)
    app.component('BizDateRangePicker', BizDateRangePicker)
    app.component('BizCalendarSheet', BizCalendarSheet)
    app.component('BizCalendarAlert', BizCalendarAlert)
    app.component('BizCalendarIsland', BizCalendarIsland)
    app.component('BizConfirmSheet', BizConfirmSheet)
    app.component('BizReceiveAmountSheet', BizReceiveAmountSheet)
    app.component('BizAccountSavingCard', BizAccountSavingCard)
    app.component('BizReceivingAccountSheet', BizReceivingAccountSheet)
    app.component('BizMonthPicker', BizMonthPicker)
    app.component('BizMonthPickerSheet', BizMonthPickerSheet)
    app.component('BizMonthPickerAlert', BizMonthPickerAlert)
    app.component('BizMonthPickerIsland', BizMonthPickerIsland)
    app.component('BizYearPicker', BizYearPicker)
    app.component('BizYearPickerSheet', BizYearPickerSheet)
    app.component('BizYearPickerAlert', BizYearPickerAlert)
    app.component('BizYearPickerIsland', BizYearPickerIsland)
    app.component('BizAccountListCard', BizAccountListCard)
    app.component('BizAccountReorderList', BizAccountReorderList)
    app.component('BizTimePicker', BizTimePicker)
    app.component('BizTimePickerSheet', BizTimePickerSheet)
    app.component('BizTimePickerAlert', BizTimePickerAlert)
    app.component('BizTimePickerIsland', BizTimePickerIsland)
    app.component('BizNotificationItem', BizNotificationItem)
    app.component('BizColorPicker', BizColorPicker)
    app.component('BizColorPickerSheet', BizColorPickerSheet)
    app.component('BizColorPickerAlert', BizColorPickerAlert)
    app.component('BizColorPickerIsland', BizColorPickerIsland)
    app.component('BizNavigationDrawer', BizNavigationDrawer)
    app.component('BizNavigationRail', BizNavigationRail)
    app.component('BizDynamicIsland', BizDynamicIsland)
    app.component('BizRibbon', BizRibbon)
    app.component('BizRibbonTab', BizRibbonTab)
    app.component('BizRibbonGroup', BizRibbonGroup)
    app.component('BizRibbonButton', BizRibbonButton)
    app.component('BizCollapse', BizCollapse)
    app.component('BizCollapseItem', BizCollapseItem)
    app.component('BizTimeline', BizTimeline)
    app.component('BizTimelineItem', BizTimelineItem)
    app.component('BizTree', BizTree)
    app.component('BizTreeNode', BizTreeNode)
    app.component('BizWebToast', BizWebToast)
    app.component('BizPagination', BizPagination)
    app.component('BizTable', BizTable)
  }
}
