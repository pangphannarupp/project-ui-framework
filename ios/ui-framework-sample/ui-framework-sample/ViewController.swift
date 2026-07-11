//
//  ViewController.swift
//  ui-framework-sample
//
//  Created by Pang Phanna on 10/7/26.
//

import UIKit
import SwiftUI
import UIFramework

struct UIComponent {
    let name: String
    let description: String
    let codeSnippet: String
    let viewFactory: () -> UIViewController
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    private let tableView = UITableView()
    private var components: [UIComponent] = []
    private var filteredComponents: [UIComponent] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UI Framework Components"
        view.backgroundColor = .systemBackground
        
        setupSearchController()
        setupComponents()
        setupTableView()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search components..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupComponents() {
        components = [
            UIComponent(
                name: "BizButton",
                description: "A modern SwiftUI button designed for the Biz platform. It utilizes View modifiers to achieve consistent padding, rounded corners, and background color.",
                codeSnippet: "BizButton(text: \"Biz SwiftUI Button\") { print(\"Tapped\") }",
                viewFactory: {
                    return UIHostingController(rootView: BizButton("Biz SwiftUI Button") { print("Tapped") })
                }
            ),
            UIComponent(
                name: "BizBottomMenu (SwiftUI M3)",
                description: "A custom SwiftUI implementation of the Material Design 3 Bottom Navigation bar. It features pill-shaped active indicators, smooth spring animations, and standard M3 layout.",
                codeSnippet: """
                let bottomMenuView = BizBottomMenuDemo()
                let hostingController = UIHostingController(rootView: bottomMenuView)
                addChild(hostingController)
                view.addSubview(hostingController.view)
                hostingController.didMove(toParent: self)
                """,
                viewFactory: {
                    let view = BizBottomMenuDemo()
                    return UIHostingController(rootView: view)
                }
            ),
            UIComponent(
                name: "BizCollapsingToolbar (SwiftUI)",
                description: "A custom SwiftUI implementation of a collapsing toolbar, mimicking web behavior with a dynamic header that shrinks as you scroll.",
                codeSnippet: """
                let collapsingToolbarView = BizCollapsingToolbar(
                    title: "Collapsing Title"
                ) {
                    Image(systemName: "photo")
                } content: {
                    Text("Scrollable Content")
                }
                """,
                viewFactory: {
                    let view = BizCollapsingToolbar(
                        title: "Collapsing Toolbar",
                        collapsedHeight: 50,
                        expandedHeight: 250,
                        onBackClick: nil,
                        header: {
                            ZStack {
                                Color.blue
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 60))
                                    .foregroundColor(.white)
                            }
                        },
                        content: {
                            VStack(spacing: 20) {
                                ForEach(0..<20) { i in
                                    Text("Scrollable Item \\(i + 1)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .background(Color(UIColor.secondarySystemGroupedBackground))
                                        .cornerRadius(8)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.top, 20)
                        }
                    )
                    return UIHostingController(rootView: view)
                }
            ),
            UIComponent(
                name: "BizCheckbox",
                description: "A standard Checkbox mapped to the Biz design system.",
                codeSnippet: """
                @State var isChecked = false
                BizCheckbox(
                    isChecked: $isChecked,
                    label: "Accept Terms"
                )
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizCheckboxDemo())
                }
            ),
            UIComponent(
                name: "BizRadio",
                description: "A standard Radio Button mapped to the Biz design system.",
                codeSnippet: """
                @State var selectedOption = 1
                BizRadio(
                    isSelected: selectedOption == 1,
                    label: "Option 1"
                ) {
                    selectedOption = 1
                }
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizRadioDemo())
                }
            ),
            UIComponent(
                name: "BizSwitch",
                description: "A standard Switch mapped to the Biz design system.",
                codeSnippet: """
                @State var isOn = false
                BizSwitch(
                    isOn: $isOn,
                    label: "Enable Notifications"
                )
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizSwitchDemo())
                }
            ),
            UIComponent(
                name: "BizIconButton",
                description: "A standard Icon Button.",
                codeSnippet: """
                BizIconButton(iconName: "gear") {
                    print("Tapped")
                }
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizIconButtonDemo())
                }
            ),
            UIComponent(
                name: "BizFab",
                description: "A Floating Action Button.",
                codeSnippet: """
                BizFab(iconName: "checkmark") {
                    print("FAB Tapped")
                }
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizFabDemo())
                }
            ),
            UIComponent(
                name: "BizTextField",
                description: "An outlined Text Field.",
                codeSnippet: """
                @State var text = ""
                BizTextField(text: $text, placeholder: "Enter text...")
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizTextFieldDemo())
                }
            ),
            UIComponent(
                name: "BizInput",
                description: "A filled Input Field.",
                codeSnippet: """
                @State var text = ""
                BizInput(text: $text, placeholder: "Search...")
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizInputDemo())
                }
            ),
            UIComponent(
                name: "BizAppBar",
                description: "A standard App Bar.",
                codeSnippet: """
                BizAppBar(title: "Home", onBackClick: {}) {
                    BizIconButton(iconName: "magnifyingglass", tint: .white) {}
                }
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizAppBarDemo())
                }
            ),
            UIComponent(
                name: "BizInfoCard",
                description: "An info/warning card for important messages.",
                codeSnippet: """
                BizInfoCard(text: "Please check your network connection.", type: .warning)
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizInfoCardDemo())
                }
            ),
            UIComponent(
                name: "BizRating",
                description: "A 5-star rating component.",
                codeSnippet: """
                @State var rating = 3
                BizRating(rating: $rating)
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizRatingDemo())
                }
            ),
            UIComponent(
                name: "BizToast",
                description: "A custom toast notification.",
                codeSnippet: """
                @State var showToast = false
                // ... button sets showToast to true
                .bizToast(isPresented: $showToast, message: "Action successful!")
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizToastDemo())
                }
            ),
            UIComponent(
                name: "BizSkeleton",
                description: "A shimmer loading effect placeholder.",
                codeSnippet: """
                BizSkeletonText()
                    .frame(height: 20)
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizSkeletonDemo())
                }
            ),
            UIComponent(
                name: "BizProgressGauge",
                description: "A half-circle progress gauge.",
                codeSnippet: """
                BizProgressGauge(value: 75, max: 100, label: "Completion")
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizProgressGaugeDemo())
                }
            ),
            UIComponent(
                name: "BizAccountCard",
                description: "A card showing account balance.",
                codeSnippet: """
                BizAccountCard(count: 2, balance: 12500.50, type: .deposit)
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizAccountCardDemo())
                }
            ),
            UIComponent(
                name: "BizSegment",
                description: "A segmented control for tab selection.",
                codeSnippet: """
                @State var selected = 0
                BizSegment(items: ["Day", "Week", "Month"], selectedIndex: $selected)
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizSegmentDemo())
                }
            ),
            UIComponent(
                name: "BizSlider",
                description: "A slider for numeric input.",
                codeSnippet: """
                @State var value: Double = 50
                BizSlider(value: $value, label: "Volume", showValue: true)
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizSliderDemo())
                }
            ),
            UIComponent(
                name: "BizPieChart",
                description: "A simple pie chart visualizing data segments.",
                codeSnippet: """
                BizPieChart(data: [
                    BizPieSegment(value: 40, color: Color(hex: "#1A75FF")),
                    BizPieSegment(value: 30, color: Color(hex: "#FF3366")),
                    BizPieSegment(value: 30, color: Color(hex: "#00CC66"))
                ])
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizPieChartDemo())
                }
            ),
            UIComponent(
                name: "BizBarChart",
                description: "A simple bar chart visualizing data columns.",
                codeSnippet: """
                BizBarChart(data: [
                    BizBarChartData(label: "Jan", value: 65),
                    BizBarChartData(label: "Feb", value: 59),
                    BizBarChartData(label: "Mar", value: 80),
                    BizBarChartData(label: "Apr", value: 81),
                    BizBarChartData(label: "May", value: 56)
                ])
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizBarChartDemo())
                }
            ),
            UIComponent(
                name: "BizLineChart",
                description: "A simple line chart visualizing trends.",
                codeSnippet: """
                BizLineChart(
                    data: [65, 59, 80, 81, 56, 55, 40],
                    labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                )
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizLineChartDemo())
                }
            ),
            UIComponent(
                name: "BizCalendar",
                description: "A standard Gregorian calendar with selection capabilities.",
                codeSnippet: "BizCalendar()",
                viewFactory: {
                    return UIHostingController(rootView: BizCalendarDemo())
                }
            ),
            UIComponent(
                name: "BizMonthPicker",
                description: "A month picker for selecting single or range of months.",
                codeSnippet: "BizMonthPicker()",
                viewFactory: {
                    return UIHostingController(rootView: BizMonthPickerDemo())
                }
            ),
            UIComponent(
                name: "BizKhmerCalendar",
                description: "A Khmer calendar that shows Gregorian dates with lunar dates and zodiac information.",
                codeSnippet: """
                BizKhmerCalendar(onDateSelected: { selection in })
                """,
                viewFactory: {
                    return UIHostingController(rootView: BizKhmerCalendarDemo())
                }
            ),
            UIComponent(
                name: "BizButtonGroup",
                description: "A group of buttons that are visually connected together.",
                codeSnippet: "BizButtonGroup { BizButton(...) }",
                viewFactory: {
                    return UIHostingController(rootView: BizButtonGroupDemo())
                }
            ),
            UIComponent(
                name: "BizAutocomplete",
                description: "An input field that provides suggestions while typing.",
                codeSnippet: "BizAutocomplete(text: $text, options: options)",
                viewFactory: {
                    return UIHostingController(rootView: BizAutocompleteDemo())
                }
            ),
            UIComponent(
                name: "BizSelect",
                description: "A dropdown select input for choosing from a list of options.",
                codeSnippet: "BizSelect(selectedValue: $val, options: opts)",
                viewFactory: {
                    return UIHostingController(rootView: BizSelectDemo())
                }
            ),
            UIComponent(
                name: "BizTimePicker",
                description: "A wheel picker to select a specific hour and minute.",
                codeSnippet: "BizTimePicker(time: $time)",
                viewFactory: {
                    return UIHostingController(rootView: BizTimePickerDemo())
                }
            ),
            UIComponent(
                name: "BizScrollSegment",
                description: "A horizontally scrollable segment of tabs.",
                codeSnippet: "BizScrollSegment(selectedId: $id, options: opts)",
                viewFactory: {
                    return UIHostingController(rootView: BizScrollSegmentDemo())
                }
            ),
            UIComponent(
                name: "BizBottomSheet",
                description: "A customizable bottom sheet that can be dragged down to dismiss.",
                codeSnippet: "BizBottomSheet(isPresented: $show)",
                viewFactory: {
                    return UIHostingController(rootView: BizBottomSheetDemo())
                }
            ),
            UIComponent(
                name: "BizHideAppBar",
                description: "An app bar that hides when scrolling down and shows when scrolling up.",
                codeSnippet: "BizHideAppBar(header: { ... }, content: { ... })",
                viewFactory: {
                    return UIHostingController(rootView: BizHideAppBarDemo())
                }
            ),
            UIComponent(
                name: "BizUserCard",
                description: "A card displaying user information, avatar, and badges.",
                codeSnippet: "BizUserCard(name: \"John Doe\", phone: \"123\")",
                viewFactory: {
                    return UIHostingController(rootView: BizUserCardDemo())
                }
            ),
            UIComponent(
                name: "BizSwipeItem",
                description: "A list item that can be swiped to reveal left and right actions.",
                codeSnippet: "BizSwipeItem { ... } leftActions: { ... }",
                viewFactory: {
                    return UIHostingController(rootView: BizSwipeItemDemo())
                }
            ),
            UIComponent(
                name: "BizPullToRefresh",
                description: "A pull-to-refresh wrapper with custom animation.",
                codeSnippet: "BizPullToRefresh(onRefresh: { ... }) { ... }",
                viewFactory: {
                    return UIHostingController(rootView: BizPullToRefreshDemo())
                }
            ),
            UIComponent(
                name: "BizSkeleton",
                description: "Animated placeholders for loading states.",
                codeSnippet: "BizSkeletonList(count: 3)",
                viewFactory: {
                    return UIHostingController(rootView: BizSkeletonDemo())
                }
            ),
            UIComponent(
                name: "BizNoResult",
                description: "A component to show empty states or no search results.",
                codeSnippet: "BizNoResult(title: \"No data\")",
                viewFactory: {
                    return UIHostingController(rootView: BizNoResultDemo())
                }
            ),
            UIComponent(
                name: "BizToast",
                description: "A transient notification message.",
                codeSnippet: ".bizToast(isPresented: $show, message: \"Done\")",
                viewFactory: {
                    return UIHostingController(rootView: BizToastDemo())
                }
            ),
            UIComponent(
                name: "BizProgressGauge",
                description: "A circular gauge indicating progress.",
                codeSnippet: "BizProgressGauge(progress: 65)",
                viewFactory: {
                    return UIHostingController(rootView: BizProgressGaugeDemo())
                }
            ),
            UIComponent(
                name: "BizRating",
                description: "A star rating component.",
                codeSnippet: "BizRating(rating: $rating)",
                viewFactory: {
                    return UIHostingController(rootView: BizRatingDemo())
                }
            ),
            UIComponent(
                name: "BizCharts",
                description: "Simple data visualization charts (Bar, Line, Pie).",
                codeSnippet: "BizBarChart(data: [...], labels: [...])",
                viewFactory: {
                    return UIHostingController(rootView: BizChartsDemo())
                }
            ),
            UIComponent(
                name: "BizCheckboxGroup",
                description: "A group of checkboxes sharing a selection set.",
                codeSnippet: "BizCheckboxGroup(selection: $selection, options: options)",
                viewFactory: {
                    return UIHostingController(rootView: BizCheckboxGroupDemo())
                }
            ),
            UIComponent(
                name: "BizRadioGroup",
                description: "A group of radio buttons for mutually exclusive selection.",
                codeSnippet: "BizRadioGroup(selection: $selection, options: options)",
                viewFactory: {
                    return UIHostingController(rootView: BizRadioGroupDemo())
                }
            ),
            UIComponent(
                name: "BizPhoneInput",
                description: "An input tailored for phone numbers with country code selector.",
                codeSnippet: "BizPhoneInput(text: $phone)",
                viewFactory: {
                    return UIHostingController(rootView: BizPhoneInputDemo())
                }
            ),
            UIComponent(
                name: "BizNumberSpinner",
                description: "A numeric input with increment and decrement buttons.",
                codeSnippet: "BizNumberSpinner(value: $count)",
                viewFactory: {
                    return UIHostingController(rootView: BizNumberSpinnerDemo())
                }
            ),
            UIComponent(
                name: "BizOtpInput",
                description: "A specialized input for One-Time Passwords with auto-advance.",
                codeSnippet: "BizOtpInput(value: $otp, length: 6)",
                viewFactory: {
                    return UIHostingController(rootView: BizOtpInputDemo())
                }
            ),
            UIComponent(
                name: "BizPinDots",
                description: "Visual dots representing a secure PIN entry with animations.",
                codeSnippet: "BizPinDots(length: 6, value: pin)",
                viewFactory: {
                    return UIHostingController(rootView: BizPinDotsDemo())
                }
            ),
            UIComponent(
                name: "BizKeypad",
                description: "A standard numeric keypad for generic input.",
                codeSnippet: "BizKeypad(onPress: { val in ... })",
                viewFactory: {
                    return UIHostingController(rootView: BizKeypadDemo())
                }
            ),
            UIComponent(
                name: "BizSecureKeypad",
                description: "A randomized numeric keypad for secure PIN entry.",
                codeSnippet: "BizSecureKeypad(onPress: { val in ... })",
                viewFactory: {
                    return UIHostingController(rootView: BizSecureKeypadDemo())
                }
            ),
            UIComponent(
                name: "BizSecureKeyboard",
                description: "A full randomized alphanumeric keyboard.",
                codeSnippet: "BizSecureKeyboard(onPress: { val in ... })",
                viewFactory: {
                    return UIHostingController(rootView: BizSecureKeyboardDemo())
                }
            ),
            UIComponent(
                name: "BizKhmerKeyboard",
                description: "A randomized Khmer keyboard with shift and symbols.",
                codeSnippet: "BizKhmerKeyboard(onPress: { val in ... })",
                viewFactory: {
                    return UIHostingController(rootView: BizKhmerKeyboardDemo())
                }
            ),
            
            // PHASE 5: Specialized Sheets & Dialogs
            UIComponent(
                name: "Phase 5 Sheets (Batch 1)",
                description: "BizConfirmSheet, BizFilterSheet, BizSortSheet, BizLanguageSheet, BizCountryCodeSheet, BizFeedbackSheet, BizBiometricSheet",
                codeSnippet: "view.bizConfirmSheet(...) / view.bizFilterSheet(...)",
                viewFactory: {
                    return UIHostingController(rootView: BizSheetsBatch1Demo())
                }
            ),
            UIComponent(
                name: "Phase 5 Pickers & Calendars (Batch 2)",
                description: "BizCalendarAlert, BizCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarSheet, BizMonthPickerAlert, BizMonthPickerSheet, BizTimePickerAlert, BizTimePickerSheet",
                codeSnippet: "view.bizCalendarAlert(...) / view.bizTimePickerSheet(...)",
                viewFactory: {
                    return UIHostingController(rootView: BizPhase5PickersDemo())
                }
            ),
            
            // PHASE 6: Domain-Specific Cards & Lists
            UIComponent(
                name: "Phase 6 Cards & Lists (Batch 1)",
                description: "BizAccountListCard, BizAccountReorderList, BizAccountSavingCard, BizActionCard, BizUpgradeCard, BizVerificationCard",
                codeSnippet: "BizAccountSavingCard(...) / BizActionCard(...)",
                viewFactory: {
                    return UIHostingController(rootView: BizPhase6Batch1Demo())
                }
            ),
            UIComponent(
                name: "Phase 6 Lists & Profiles (Batch 2)",
                description: "BizNotificationItem, BizTransferList, BizUserProfile, BizFabList, BizFabAction",
                codeSnippet: "BizNotificationItem(...) / BizTransferList(...)",
                viewFactory: {
                    return UIHostingController(rootView: BizPhase6Batch2Demo())
                }
            )
        ]
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let searchText = searchBar.text {
            filteredComponents = components.filter { (component: UIComponent) -> Bool in
                return component.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredComponents.count : components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let component = isFiltering ? filteredComponents[indexPath.row] : components[indexPath.row]
        cell.textLabel?.text = component.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let component = isFiltering ? filteredComponents[indexPath.row] : components[indexPath.row]
        let detailVC = ComponentDetailViewController(component: component)
        let navController = UINavigationController(rootViewController: detailVC)
        
        present(navController, animated: true)
    }
}

// MARK: - Detail View Controller

class ComponentDetailViewController: UIViewController {
    let component: UIComponent
    
    init(component: UIComponent) {
        self.component = component
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = component.name
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        // Setup Component View (Top)
        let componentVC = component.viewFactory()
        addChild(componentVC)
        componentVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(componentVC.view)
        componentVC.didMove(toParent: self)
        
        // Setup Usage Guide Container (Bottom)
        let descContainer = UIView()
        descContainer.backgroundColor = .secondarySystemBackground
        descContainer.layer.cornerRadius = 12
        descContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let descTitle = UILabel()
        descTitle.text = "Usage Guide"
        descTitle.font = .boldSystemFont(ofSize: 18)
        descTitle.textColor = .label
        descTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = component.description
        descLabel.numberOfLines = 0
        descLabel.font = .systemFont(ofSize: 15)
        descLabel.textColor = .label
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let codeContainer = UIView()
        codeContainer.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        codeContainer.layer.cornerRadius = 8
        codeContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let copyButton = UIButton(type: .system)
        copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        copyButton.setTitle(" Copy", for: .normal)
        copyButton.tintColor = .white
        copyButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.addAction(UIAction(handler: { [weak self] _ in
            UIPasteboard.general.string = self?.component.codeSnippet
            copyButton.setTitle(" Copied!", for: .normal)
            copyButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            copyButton.tintColor = .systemGreen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                copyButton.setTitle(" Copy", for: .normal)
                copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
                copyButton.tintColor = .white
            }
        }), for: .touchUpInside)
        
        let codeTextView = UITextView()
        codeTextView.text = component.codeSnippet
        codeTextView.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        codeTextView.textColor = .systemGreen
        codeTextView.backgroundColor = .clear
        codeTextView.isEditable = false
        codeTextView.isSelectable = true
        codeTextView.translatesAutoresizingMaskIntoConstraints = false
        
        codeContainer.addSubview(copyButton)
        codeContainer.addSubview(codeTextView)
        
        descContainer.addSubview(descTitle)
        descContainer.addSubview(descLabel)
        descContainer.addSubview(codeContainer)
        view.addSubview(descContainer)
        
        NSLayoutConstraint.activate([
            // Container constraints
            descContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            descContainer.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.45),
            
            // Title constraints
            descTitle.topAnchor.constraint(equalTo: descContainer.topAnchor, constant: 16),
            descTitle.leadingAnchor.constraint(equalTo: descContainer.leadingAnchor, constant: 16),
            descTitle.trailingAnchor.constraint(equalTo: descContainer.trailingAnchor, constant: -16),
            
            // Description constraints
            descLabel.topAnchor.constraint(equalTo: descTitle.bottomAnchor, constant: 8),
            descLabel.leadingAnchor.constraint(equalTo: descContainer.leadingAnchor, constant: 16),
            descLabel.trailingAnchor.constraint(equalTo: descContainer.trailingAnchor, constant: -16),
            
            // Code Container constraints
            codeContainer.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 12),
            codeContainer.leadingAnchor.constraint(equalTo: descContainer.leadingAnchor, constant: 16),
            codeContainer.trailingAnchor.constraint(equalTo: descContainer.trailingAnchor, constant: -16),
            codeContainer.bottomAnchor.constraint(equalTo: descContainer.bottomAnchor, constant: -16),
            
            // Copy button
            copyButton.topAnchor.constraint(equalTo: codeContainer.topAnchor, constant: 8),
            copyButton.trailingAnchor.constraint(equalTo: codeContainer.trailingAnchor, constant: -8),
            
            // Code Text View
            codeTextView.topAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 0),
            codeTextView.leadingAnchor.constraint(equalTo: codeContainer.leadingAnchor, constant: 8),
            codeTextView.trailingAnchor.constraint(equalTo: codeContainer.trailingAnchor, constant: -8),
            codeTextView.bottomAnchor.constraint(equalTo: codeContainer.bottomAnchor, constant: -8),
            codeTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            // Component view constraints
            componentVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            componentVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            componentVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            componentVC.view.bottomAnchor.constraint(equalTo: descContainer.topAnchor, constant: -16)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissDetail))
    }
    
    @objc private func dismissDetail() {
        dismiss(animated: true)
    }
}

// MARK: - Demo Wrapper Views

struct BizCheckboxDemo: View {
    @State private var isChecked = false
    var body: some View {
        BizCheckbox(isChecked: $isChecked, label: "Accept Terms")
            .padding()
    }
}

struct BizRadioDemo: View {
    @State private var selectedOption = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            BizRadio(isSelected: selectedOption == 1, label: "Option 1") {
                selectedOption = 1
            }
            BizRadio(isSelected: selectedOption == 2, label: "Option 2") {
                selectedOption = 2
            }
        }
        .padding()
    }
}

struct BizSwitchDemo: View {
    @State private var isOn = false
    var body: some View {
        BizSwitch(isOn: $isOn, label: "Enable Notifications")
            .padding()
    }
}

struct BizIconButtonDemo: View {
    var body: some View {
        BizIconButton(iconName: "gear") {}
            .padding()
    }
}

struct BizFabDemo: View {
    var body: some View {
        BizFab(iconName: "checkmark") {}
            .padding()
    }
}

struct BizTextFieldDemo: View {
    @State private var text = ""
    var body: some View {
        BizTextField(text: $text, placeholder: "Enter text...")
            .padding()
    }
}

struct BizInputDemo: View {
    @State private var text = ""
    var body: some View {
        BizInput(text: $text, placeholder: "Search...")
            .padding()
    }
}

struct BizAppBarDemo: View {
    var body: some View {
        VStack {
            BizAppBar(title: "Home", onBackClick: {}) {
                BizIconButton(iconName: "magnifyingglass", tint: .white) {}
            }
            Spacer()
        }
    }
}

struct BizInfoCardDemo: View {
    var body: some View {
        BizInfoCard(text: "Please check your network connection.", type: .warning)
            .padding()
    }
}

struct BizRatingDemo: View {
    @State private var rating = 3
    var body: some View {
        BizRating(rating: $rating)
            .padding()
    }
}

struct BizToastDemo: View {
    @State private var showToast = false
    var body: some View {
        ZStack {
            Button("Show Toast") {
                showToast = true
            }
            .padding()
        }
        .bizToast(isPresented: $showToast, message: "Action successful!")
    }
}

struct BizSkeletonDemo: View {
    var body: some View {
        VStack(spacing: 8) {
            BizSkeletonText().frame(height: 20)
            BizSkeletonText().frame(height: 20).padding(.trailing, 40)
            BizSkeletonText().frame(height: 20).padding(.trailing, 80)
        }
        .padding()
    }
}

struct BizProgressGaugeDemo: View {
    var body: some View {
        BizProgressGauge(value: 75, max: 100, label: "Completion")
            .padding(32)
    }
}

struct BizAccountCardDemo: View {
    var body: some View {
        BizAccountCard(count: 2, balance: 12500.50, type: .deposit) {}
            .padding()
    }
}

struct BizSegmentDemo: View {
    @State private var selected = 0
    var body: some View {
        BizSegment(items: ["Day", "Week", "Month"], selectedIndex: $selected)
            .padding()
    }
}

struct BizSliderDemo: View {
    @State private var value: Double = 50
    var body: some View {
        BizSlider(value: $value, label: "Volume", showValue: true)
            .padding()
    }
}

struct BizPieChartDemo: View {
    var body: some View {
        BizPieChart(data: [
            BizPieSegment(value: 40, color: Color(hex: "#1A75FF")),
            BizPieSegment(value: 30, color: Color(hex: "#FF3366")),
            BizPieSegment(value: 30, color: Color(hex: "#00CC66"))
        ])
        .frame(width: 200, height: 200)
        .padding()
    }
}

struct BizBarChartDemo: View {
    var body: some View {
        BizBarChart(data: [
            BizBarChartData(label: "Jan", value: 65),
            BizBarChartData(label: "Feb", value: 59),
            BizBarChartData(label: "Mar", value: 80),
            BizBarChartData(label: "Apr", value: 81),
            BizBarChartData(label: "May", value: 56)
        ])
        .frame(height: 240)
        .padding()
    }
}

struct BizLineChartDemo: View {
    var body: some View {
        BizLineChart(
            data: [65, 59, 80, 81, 56, 55, 40],
            labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        )
        .frame(height: 240)
        .padding()
    }
}

struct CalendarSettingsPanel: View {
    @Binding var modeIndex: Int
    @Binding var startDayIndex: Int
    @Binding var minDateEnabled: Bool
    @Binding var maxDateEnabled: Bool
    @Binding var selectedDateEnabled: Bool
    @Binding var weeksBefore: Int
    @Binding var weeksAfter: Int

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Selection Mode").font(.caption).foregroundColor(.gray)
                BizSegment(items: ["Single", "Range", "Week"], selectedIndex: $modeIndex)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Start Day").font(.caption).foregroundColor(.gray)
                BizSegment(items: ["Sunday", "Monday"], selectedIndex: $startDayIndex)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Toggle("Set Min Date (Today)", isOn: $minDateEnabled)
                Toggle("Set Max Date (+30 Days)", isOn: $maxDateEnabled)
                Toggle("Initial Date (+2 Days)", isOn: $selectedDateEnabled)
            }
            
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Extra Weeks Before (\(weeksBefore))").font(.caption).foregroundColor(.gray)
                    Stepper("", value: $weeksBefore, in: 0...5)
                }
                VStack(alignment: .leading) {
                    Text("Extra Weeks After (\(weeksAfter))").font(.caption).foregroundColor(.gray)
                    Stepper("", value: $weeksAfter, in: 0...5)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct BizCalendarDemo: View {
    @State private var modeIndex = 0
    @State private var startDayIndex = 0
    @State private var minDateEnabled = false
    @State private var maxDateEnabled = false
    @State private var weeksBefore = 0
    @State private var weeksAfter = 0
    @State private var selectedDateEnabled = false
    @State private var showBottomSheet = false
    @State private var showAlert = false
    
    private var currentMode: SelectionMode {
        switch modeIndex {
        case 0: return .single
        case 1: return .range
        case 2: return .week
        default: return .single
        }
    }
    
    private var config: CalendarConfig {
        let today = Date()
        let minDate = minDateEnabled ? today : nil
        let maxDate = maxDateEnabled ? Calendar.current.date(byAdding: .day, value: 30, to: today) : nil
        return CalendarConfig(
            firstDayOfWeek: startDayIndex,
            showAdjacentMonths: true,
            extraWeeksBefore: weeksBefore,
            extraWeeksAfter: weeksAfter,
            minDate: minDate,
            maxDate: maxDate,
            selectionMode: currentMode
        )
    }
    
    private var initialDate: Date {
        let today = Date()
        return selectedDateEnabled ? Calendar.current.date(byAdding: .day, value: 2, to: today)! : today
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CalendarSettingsPanel(
                    modeIndex: $modeIndex,
                    startDayIndex: $startDayIndex,
                    minDateEnabled: $minDateEnabled,
                    maxDateEnabled: $maxDateEnabled,
                    selectedDateEnabled: $selectedDateEnabled,
                    weeksBefore: $weeksBefore,
                    weeksAfter: $weeksAfter
                )
                
                Button(action: { showBottomSheet = true }) {
                    Text("Open in Bottom Sheet")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Button(action: { showAlert = true }) {
                    Text("Open in Alert")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                BizCalendar(
                    config: config,
                    initialDate: initialDate,
                    onDateSelected: { _ in },
                    onRangeSelected: { _, _ in }
                )
                .padding()
            }
            .padding(.top, 16)
        }
        .sheet(isPresented: $showBottomSheet) {
            ScrollView {
                BizCalendar(
                    config: config,
                    initialDate: initialDate,
                    showActionButtons: true,
                    onDateSelected: { _ in },
                    onRangeSelected: { _, _ in },
                    onConfirm: { _, _ in showBottomSheet = false }, onCancel: { showBottomSheet = false }
                )
                .padding()
            }
            .background(Color(UIColor.systemBackground))
        }
        .overlay(
            Group {
                if showAlert {
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture { showAlert = false }
                        
                        BizCalendar(
                            config: config,
                            initialDate: initialDate,
                            showActionButtons: true,
                            onDateSelected: { _ in },
                            onRangeSelected: { _, _ in },
                            onConfirm: { _, _ in showAlert = false }, onCancel: { showAlert = false }
                        )
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(24)
                    }
                }
            }
        )
    }
}

struct BizKhmerCalendarDemo: View {
    @State private var modeIndex = 0
    @State private var startDayIndex = 0
    @State private var minDateEnabled = false
    @State private var maxDateEnabled = false
    @State private var weeksBefore = 0
    @State private var weeksAfter = 0
    @State private var selectedDateEnabled = false
    @State private var showBottomSheet = false
    @State private var showAlert = false
    
    private var currentMode: SelectionMode {
        switch modeIndex {
        case 0: return .single
        case 1: return .range
        case 2: return .week
        default: return .single
        }
    }
    
    private var config: CalendarConfig {
        let today = Date()
        let minDate = minDateEnabled ? today : nil
        let maxDate = maxDateEnabled ? Calendar.current.date(byAdding: .day, value: 30, to: today) : nil
        return CalendarConfig(
            firstDayOfWeek: startDayIndex,
            showAdjacentMonths: true,
            extraWeeksBefore: weeksBefore,
            extraWeeksAfter: weeksAfter,
            minDate: minDate,
            maxDate: maxDate,
            selectionMode: currentMode
        )
    }
    
    private var initialDate: Date {
        let today = Date()
        return selectedDateEnabled ? Calendar.current.date(byAdding: .day, value: 2, to: today)! : today
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CalendarSettingsPanel(
                    modeIndex: $modeIndex,
                    startDayIndex: $startDayIndex,
                    minDateEnabled: $minDateEnabled,
                    maxDateEnabled: $maxDateEnabled,
                    selectedDateEnabled: $selectedDateEnabled,
                    weeksBefore: $weeksBefore,
                    weeksAfter: $weeksAfter
                )
                
                Button(action: { showBottomSheet = true }) {
                    Text("Open in Bottom Sheet")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Button(action: { showAlert = true }) {
                    Text("Open in Alert")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                BizKhmerCalendar(
                    config: config,
                    initialDate: initialDate,
                    onDateSelected: { _ in },
                    onRangeSelected: { _, _ in }
                )
                .padding()
            }
            .padding(.top, 16)
        }
        .sheet(isPresented: $showBottomSheet) {
            ScrollView {
                BizKhmerCalendar(
                    config: config,
                    initialDate: initialDate,
                    showActionButtons: true,
                    onDateSelected: { _ in },
                    onRangeSelected: { _, _ in },
                    onConfirm: { _, _ in showBottomSheet = false }, onCancel: { showBottomSheet = false }
                )
                .padding()
            }
            .background(Color(UIColor.systemBackground))
        }
        .overlay(
            Group {
                if showAlert {
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture { showAlert = false }
                        
                        BizKhmerCalendar(
                            config: config,
                            initialDate: initialDate,
                            showActionButtons: true,
                            onDateSelected: { _ in },
                            onRangeSelected: { _, _ in },
                            onConfirm: { _, _ in showAlert = false }, onCancel: { showAlert = false }
                        )
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(24)
                    }
                }
            }
        )
    }
}
import SwiftUI
import UIFramework

struct BizMonthPickerDemo: View {
    @State private var modeIndex = 0
    @State private var minDateEnabled = false
    @State private var maxDateEnabled = false
    @State private var showBottomSheet = false
    @State private var showAlert = false
    
    private var config: CalendarConfig {
        var cfg = CalendarConfig()
        cfg.selectionMode = modeIndex == 0 ? .single : .range
        
        let today = Date()
        cfg.minDate = minDateEnabled ? today : nil
        cfg.maxDate = maxDateEnabled ? Calendar.current.date(byAdding: .day, value: 30, to: today) : nil
        return cfg
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Configuration")
                        .font(.headline)
                    
                    Picker("Selection Mode", selection: $modeIndex) {
                        Text("Single").tag(0)
                        Text("Range").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Toggle("Set Min Date (Today)", isOn: $minDateEnabled)
                    Toggle("Set Max Date (+30 Days)", isOn: $maxDateEnabled)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                
                HStack(spacing: 16) {
                    Button(action: { showBottomSheet = true }) {
                        Text("Bottom Sheet")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    Button(action: { showAlert = true }) {
                        Text("Alert")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                BizMonthPicker(
                    config: config,
                    showActionButtons: false
                )
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                .padding()
            }
            .padding(.vertical)
        }
        .navigationTitle("BizMonthPicker")
        .sheet(isPresented: $showBottomSheet) {
            ScrollView {
                BizMonthPicker(
                    config: config,
                    showActionButtons: true,
                    onCancel: { showBottomSheet = false },
                    onConfirm: { _, _ in showBottomSheet = false }
                )
                .padding()
            }
            .background(Color(UIColor.systemBackground))
        }
        .overlay(
            Group {
                if showAlert {
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture { showAlert = false }
                        
                        BizMonthPicker(
                            config: config,
                            showActionButtons: true,
                            onCancel: { showAlert = false },
                            onConfirm: { _, _ in showAlert = false }
                        )
                        .cornerRadius(12)
                        .padding(24)
                    }
                }
            }
        )
    }
}

struct BizButtonGroupDemo: View {
    var body: some View {
        VStack(spacing: 24) {
            BizButtonGroup {
                BizButton("Left", variant: .outline) {}
                BizButton("Middle", variant: .outline) {}
                BizButton("Right", variant: .outline) {}
            }
            
            BizButtonGroup(isVertical: true) {
                BizButton("Top", variant: .outline) {}
                BizButton("Middle", variant: .outline) {}
                BizButton("Bottom", variant: .outline) {}
            }
        }
        .padding()
    }
}

struct BizAutocompleteDemo: View {
    @State private var text = ""
    let options = [
        BizAutocompleteOption(label: "Apple", value: "apple"),
        BizAutocompleteOption(label: "Banana", value: "banana"),
        BizAutocompleteOption(label: "Cherry", value: "cherry")
    ]
    
    var body: some View {
        VStack {
            BizAutocomplete(
                text: $text,
                label: "Select Fruit",
                placeholder: "Search...",
                options: options
            )
            Spacer()
        }
        .padding()
    }
}

struct BizSelectDemo: View {
    @State private var selectedValue = ""
    let options = [
        BizSelectOption(label: "Option 1", value: "1"),
        BizSelectOption(label: "Option 2", value: "2"),
        BizSelectOption(label: "Option 3", value: "3")
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            BizSelect(selectedValue: $selectedValue, options: options, label: "Outlined", variant: .outlined)
            BizSelect(selectedValue: $selectedValue, options: options, label: "Filled", variant: .filled)
            BizSelect(selectedValue: $selectedValue, options: options, label: "Underlined", variant: .underlined)
        }
        .padding()
    }
}

struct BizTimePickerDemo: View {
    @State private var time = "14:30"
    
    var body: some View {
        VStack {
            Text("Selected Time: \(time)")
                .font(.headline)
            BizTimePicker(time: $time, title: "Select Time", showActionButtons: true)
        }
        .padding()
    }
}

struct BizScrollSegmentDemo: View {
    @State private var selectedId = "1"
    let options = [
        BizScrollSegmentOption(id: "1", label: "All"),
        BizScrollSegmentOption(id: "2", label: "Payments"),
        BizScrollSegmentOption(id: "3", label: "Transfers"),
        BizScrollSegmentOption(id: "4", label: "Deposits")
    ]
    
    var body: some View {
        VStack {
            BizScrollSegment(selectedId: $selectedId, options: options)
            Spacer()
        }
    }
}
