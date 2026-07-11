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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var components: [UIComponent] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UI Framework Components"
        view.backgroundColor = .systemBackground
        
        setupComponents()
        setupTableView()
    }
    
    private func setupComponents() {
        components = [
            UIComponent(
                name: "BizButton",
                description: "A modern SwiftUI button designed for the Biz platform. It utilizes View modifiers to achieve consistent padding, rounded corners, and background color.",
                codeSnippet: "BizButton(text: \"Biz SwiftUI Button\") { print(\"Tapped\") }",
                viewFactory: {
                    return UIHostingController(rootView: BizButton(text: "Biz SwiftUI Button") { print("Tapped") })
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
    
    // MARK: - UITableViewDataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = components[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let component = components[indexPath.row]
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
