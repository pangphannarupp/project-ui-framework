import type { App } from 'vue'
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
import PPImageCropper from './components/PPImageCropper.vue'
import PPImagePreview from './components/PPImagePreview.vue'
import PPPdfViewer from './components/PPPdfViewer.vue'
import PPFilePreview from './components/PPFilePreview.vue'
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
import PPKhmerKeyboard from './components/PPKhmerKeyboard.vue'
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
import PPKhmerCalendarIsland from './components/PPKhmerCalendarIsland.vue'
import PPCalendar from './components/PPCalendar.vue'
import PPDateRangePickerSheet from './components/PPDateRangePickerSheet.vue'
import PPDateRangePickerAlert from './components/PPDateRangePickerAlert.vue'
import PPDateRangePicker from './components/PPDateRangePicker.vue'
import PPCalendarSheet from './components/PPCalendarSheet.vue'
import PPCalendarAlert from './components/PPCalendarAlert.vue'
import PPCalendarIsland from './components/PPCalendarIsland.vue'
import PPMonthPicker from './components/PPMonthPicker.vue'
import PPMonthPickerSheet from './components/PPMonthPickerSheet.vue'
import PPMonthPickerAlert from './components/PPMonthPickerAlert.vue'
import PPMonthPickerIsland from './components/PPMonthPickerIsland.vue'
import PPDraggableGrid from './components/PPDraggableGrid.vue'
import PPMarquee from './components/PPMarquee.vue'
import PPCarousel from './components/PPCarousel.vue'
import PPCarouselItem from './components/PPCarouselItem.vue'
import PPRichTextEditor from './components/PPRichTextEditor.vue'
import PPAnimatedTabs from './components/PPAnimatedTabs.vue'
import PPMathEditor from './components/PPMathEditor.vue'
import PPMathPreview from './components/PPMathPreview.vue'
import PPKanbanBoard from './components/PPKanbanBoard.vue'
import PPYearPicker from './components/PPYearPicker.vue'
import PPYearPickerSheet from './components/PPYearPickerSheet.vue'
import PPYearPickerAlert from './components/PPYearPickerAlert.vue'
import PPYearPickerIsland from './components/PPYearPickerIsland.vue'
import PPAccountListCard from './components/PPAccountListCard.vue'
import PPAccountReorderList from './components/PPAccountReorderList.vue'
import PPTimePicker from './components/PPTimePicker.vue'
import PPTimePickerSheet from './components/PPTimePickerSheet.vue'
import PPTimePickerAlert from './components/PPTimePickerAlert.vue'
import PPTimePickerIsland from './components/PPTimePickerIsland.vue'
import PPNotificationItem from './components/PPNotificationItem.vue'
import PPColorPicker from './components/PPColorPicker.vue'
import PPColorPickerSheet from './components/PPColorPickerSheet.vue'
import PPColorPickerAlert from './components/PPColorPickerAlert.vue'
import PPColorPickerIsland from './components/PPColorPickerIsland.vue'
import PPNavigationDrawer from './components/PPNavigationDrawer.vue'
import PPNavigationRail from './components/PPNavigationRail.vue'
import PPDynamicIsland from './components/PPDynamicIsland.vue'
import PPRibbon from './components/PPRibbon.vue'
import PPRibbonTab from './components/PPRibbonTab.vue'
import PPRibbonGroup from './components/PPRibbonGroup.vue'
import PPRibbonButton from './components/PPRibbonButton.vue'
import PPCollapse from './components/PPCollapse.vue'
import PPCollapseItem from './components/PPCollapseItem.vue'
import PPTimeline from './components/PPTimeline.vue'
import PPTimelineItem from './components/PPTimelineItem.vue'
import PPTree from './components/PPTree.vue'
import PPTreeNode from './components/PPTreeNode.vue'
import PPWebToast from './components/PPWebToast.vue'
import PPPagination from './components/PPPagination.vue'
import PPTable from './components/PPTable.vue'

// Export components individually
export { 
  MyButton, 
  MyList, 
  PPButton, 
  PPButtonGroup,
  PPDraggableGrid,
  PPMarquee,
  PPCarousel,
  PPCarouselItem,
  PPSegment, 
  PPSegmentButton, 
  PPInput,
  PPTextField,
  PPToggleButton,
  PPSelect,
  PPRichTextEditor,
  PPMathEditor,
  PPMathPreview,
  PPKanbanBoard,
  PPFileUpload,
  PPImageCropper,
  PPImagePreview,
  PPPdfViewer,
  PPFilePreview,
  PPTransferList,
  PPAutocomplete, 
  PPCheckbox,
  PPCheckboxGroup,
  PPFab,
  PPFabList,
  PPFabAction,
  PPNumberSpinner,
  PPRadio,
  PPRadioGroup,
  PPRating,
  PPCollapsingToolbar,
  PPPullToRefresh,
  PPSlider,
  PPSwitch,
  PPImageTransition,
  PPSwipeItem,
  PPBarChart,
  PPLineChart,
  PPDonutChart,
  PPPieChart,
  PPRadarChart,
  PPProgressGauge,
  PPScatterChart,
  PPFunnelChart,
  PPSkeleton,
  PPSkeletonItem,
  PPSkeletonList,
  PPSkeletonDetail,
  PPHideAppBar,
  PPBottomNav,
  PPBottomSheet,
  PPBiometricSheet,
  PPLanguageSheet,
  PPCountryCodeSheet,
  PPFeedbackSheet,
  PPFilterSheet,
  PPSortSheet,
  PPScrollSegment,
  PPScrollSegmentButton,
  PPUserCard,
  PPUpgradeCard,
  PPVerificationCard,
  PPSkipButton,
  PPIconButton,
  PPUserProfile,
  PPCompanySelector,
  PPActionCard,
  PPAccountCard,
  PPPhoneInput,
  PPOtpInput,
  PPInfoCard,
  PPPinDots,
  PPKeypad,
  PPSecureKeypad,
  PPSecureKeyboard,
  PPKhmerKeyboard,
  PPNoResult,
  PPAppBar,
  PPToast,
  PPConfirmSheet,
  PPReceiveAmountSheet,
  PPAccountSavingCard,
  PPReceivingAccountSheet,
  PPKhmerCalendar,
  PPKhmerCalendarSheet,
  PPKhmerCalendarAlert,
  PPKhmerCalendarIsland,
  PPCalendar,
  PPDateRangePickerSheet,
  PPDateRangePickerAlert,
  PPDateRangePicker,
  PPCalendarSheet,
  PPCalendarAlert,
  PPCalendarIsland,
  PPMonthPicker,
  PPMonthPickerSheet,
  PPMonthPickerAlert,
  PPMonthPickerIsland,
  PPYearPicker,
  PPYearPickerSheet,
  PPYearPickerAlert,
  PPYearPickerIsland,
  PPAccountListCard,
  PPAccountReorderList,
  PPTimePicker,
  PPTimePickerSheet,
  PPTimePickerAlert,
  PPTimePickerIsland,
  PPNotificationItem,
  PPColorPicker,
  PPColorPickerSheet,
  PPColorPickerAlert,
  PPColorPickerIsland,
  PPNavigationDrawer,
  PPNavigationRail,
  PPDynamicIsland,
  PPRibbon,
  PPRibbonTab,
  PPRibbonGroup,
  PPRibbonButton,
  PPCollapse,
  PPCollapseItem,
  PPTimeline,
  PPTimelineItem,
  PPTree,
  PPTreeNode,
  PPWebToast,
  PPPagination,
  PPTable,
  PPAnimatedTabs
}

// Export a Vue plugin to install all components
export default {
  install: (app: App) => {
    app.component('MyButton', MyButton)
    app.component('MyList', MyList)
    app.component('PPButton', PPButton)
    app.component('PPButtonGroup', PPButtonGroup)
    app.component('PPSegment', PPSegment)
    app.component('PPSegmentButton', PPSegmentButton)
    app.component('PPInput', PPInput)
    app.component('PPTextField', PPTextField)
    app.component('PPToggleButton', PPToggleButton)
    app.component('PPSelect', PPSelect)
    app.component('PPFileUpload', PPFileUpload)
    app.component('PPImageCropper', PPImageCropper)
    app.component('PPImagePreview', PPImagePreview)
    app.component('PPPdfViewer', PPPdfViewer)
    app.component('PPFilePreview', PPFilePreview)
    app.component('PPTransferList', PPTransferList)
    app.component('PPAutocomplete', PPAutocomplete)
    app.component('PPCheckbox', PPCheckbox)
    app.component('PPCheckboxGroup', PPCheckboxGroup)
    app.component('PPFab', PPFab)
    app.component('PPFabList', PPFabList)
    app.component('PPFabAction', PPFabAction)
    app.component('PPNumberSpinner', PPNumberSpinner)
    app.component('PPRadio', PPRadio)
    app.component('PPRadioGroup', PPRadioGroup)
    app.component('PPRating', PPRating)
    app.component('PPCollapsingToolbar', PPCollapsingToolbar)
    app.component('PPPullToRefresh', PPPullToRefresh)
    app.component('PPPinDots', PPPinDots)
    app.component('PPKeypad', PPKeypad)
    app.component('PPSecureKeypad', PPSecureKeypad)
    app.component('PPSecureKeyboard', PPSecureKeyboard)
    app.component('PPKhmerKeyboard', PPKhmerKeyboard)
    app.component('PPImageTransition', PPImageTransition)
    app.component('PPSwipeItem', PPSwipeItem)
    app.component('PPBarChart', PPBarChart)
    app.component('PPLineChart', PPLineChart)
    app.component('PPDonutChart', PPDonutChart)
    app.component('PPPieChart', PPPieChart)
    app.component('PPRadarChart', PPRadarChart)
    app.component('PPProgressGauge', PPProgressGauge)
    app.component('PPScatterChart', PPScatterChart)
    app.component('PPFunnelChart', PPFunnelChart)
    app.component('PPSkeleton', PPSkeleton)
    app.component('PPSkeletonItem', PPSkeletonItem)
    app.component('PPSkeletonList', PPSkeletonList)
    app.component('PPSkeletonDetail', PPSkeletonDetail)
    app.component('PPHideAppBar', PPHideAppBar)
    app.component('PPBottomSheet', PPBottomSheet)
    app.component('PPBiometricSheet', PPBiometricSheet)
    app.component('PPLanguageSheet', PPLanguageSheet)
    app.component('PPCountryCodeSheet', PPCountryCodeSheet)
    app.component('PPFeedbackSheet', PPFeedbackSheet)
    app.component('PPFilterSheet', PPFilterSheet)
    app.component('PPSortSheet', PPSortSheet)
    app.component('PPScrollSegment', PPScrollSegment)
    app.component('PPScrollSegmentButton', PPScrollSegmentButton)
    app.component('PPUserCard', PPUserCard)
    app.component('PPUpgradeCard', PPUpgradeCard)
    app.component('PPVerificationCard', PPVerificationCard)
    app.component('PPSkipButton', PPSkipButton)
    app.component('PPIconButton', PPIconButton)
    app.component('PPUserProfile', PPUserProfile)
    app.component('PPCompanySelector', PPCompanySelector)
    app.component('PPActionCard', PPActionCard)
    app.component('PPAccountCard', PPAccountCard)
    app.component('PPBottomNav', PPBottomNav)
    app.component('PPPhoneInput', PPPhoneInput)
    app.component('PPOtpInput', PPOtpInput)
    app.component('PPInfoCard', PPInfoCard)
    app.component('PPNoResult', PPNoResult)
    app.component('PPAppBar', PPAppBar)
    app.component('PPToast', PPToast)
    app.component('PPKhmerCalendar', PPKhmerCalendar)
    app.component('PPKhmerCalendarSheet', PPKhmerCalendarSheet)
    app.component('PPKhmerCalendarAlert', PPKhmerCalendarAlert)
    app.component('PPKhmerCalendarIsland', PPKhmerCalendarIsland)
    app.component('PPCalendar', PPCalendar)
    app.component('PPDateRangePickerSheet', PPDateRangePickerSheet)
    app.component('PPDateRangePickerAlert', PPDateRangePickerAlert)
    app.component('PPDateRangePicker', PPDateRangePicker)
    app.component('PPCalendarSheet', PPCalendarSheet)
    app.component('PPCalendarAlert', PPCalendarAlert)
    app.component('PPCalendarIsland', PPCalendarIsland)
    app.component('PPConfirmSheet', PPConfirmSheet)
    app.component('PPReceiveAmountSheet', PPReceiveAmountSheet)
    app.component('PPAccountSavingCard', PPAccountSavingCard)
    app.component('PPReceivingAccountSheet', PPReceivingAccountSheet)
    app.component('PPMonthPicker', PPMonthPicker)
    app.component('PPMonthPickerSheet', PPMonthPickerSheet)
    app.component('PPMonthPickerAlert', PPMonthPickerAlert)
    app.component('PPMonthPickerIsland', PPMonthPickerIsland)
    app.component('PPYearPicker', PPYearPicker)
    app.component('PPYearPickerSheet', PPYearPickerSheet)
    app.component('PPYearPickerAlert', PPYearPickerAlert)
    app.component('PPYearPickerIsland', PPYearPickerIsland)
    app.component('PPAccountListCard', PPAccountListCard)
    app.component('PPAccountReorderList', PPAccountReorderList)
    app.component('PPTimePicker', PPTimePicker)
    app.component('PPTimePickerSheet', PPTimePickerSheet)
    app.component('PPTimePickerAlert', PPTimePickerAlert)
    app.component('PPTimePickerIsland', PPTimePickerIsland)
    app.component('PPNotificationItem', PPNotificationItem)
    app.component('PPColorPicker', PPColorPicker)
    app.component('PPColorPickerSheet', PPColorPickerSheet)
    app.component('PPColorPickerAlert', PPColorPickerAlert)
    app.component('PPColorPickerIsland', PPColorPickerIsland)
    app.component('PPNavigationDrawer', PPNavigationDrawer)
    app.component('PPNavigationRail', PPNavigationRail)
    app.component('PPDynamicIsland', PPDynamicIsland)
    app.component('PPRibbon', PPRibbon)
    app.component('PPRibbonTab', PPRibbonTab)
    app.component('PPRibbonGroup', PPRibbonGroup)
    app.component('PPRibbonButton', PPRibbonButton)
    app.component('PPCollapse', PPCollapse)
    app.component('PPCollapseItem', PPCollapseItem)
    app.component('PPTimeline', PPTimeline)
    app.component('PPTimelineItem', PPTimelineItem)
    app.component('PPTree', PPTree)
    app.component('PPTreeNode', PPTreeNode)
    app.component('PPWebToast', PPWebToast)
    app.component('PPPagination', PPPagination)
    app.component('PPTable', PPTable)
    app.component('PPAnimatedTabs', PPAnimatedTabs)
  }
}
