//
//  PinaPregnancyViewController.swift
//  Euki
//
//  La Piña Pregnancy - Week selector and fetal development tracker
//

import UIKit

class PinaPregnancyViewController: UIViewController {

    // MARK: - Properties
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let mockData = PinaMockData.sharedInstance
    private var pickerDataSource: PregnancyWeekPickerDataSource?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        self.title = "Pregnancy"

        setupHeaderView()
        setupScrollView()
        setupContent()
    }

    // MARK: - Setup Methods

    private func setupHeaderView() {
        headerView.backgroundColor = UIColor(red: 0.0, green: 0.75, blue: 0.70, alpha: 1.0) // #00BFB3
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)

        titleLabel.text = "Pregnancy Tracker"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        descriptionLabel.text = "Track fetal development and pregnancy milestones"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 140),

            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.alignment = .fill
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func setupContent() {
        // Add Week Selector Label
        let selectorLabel = UILabel()
        selectorLabel.text = "Select Pregnancy Week"
        selectorLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        selectorLabel.textColor = .black
        contentStackView.addArrangedSubview(selectorLabel)

        // Add Week Picker
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 180).isActive = true
        contentStackView.addArrangedSubview(picker)

        pickerDataSource = PregnancyWeekPickerDataSource(mockData: mockData)
        picker.dataSource = pickerDataSource
        picker.delegate = pickerDataSource

        // Add Divider
        let divider1 = UIView()
        divider1.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        divider1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        contentStackView.addArrangedSubview(divider1)

        // Add Featured Week Card
        let featuredLabel = UILabel()
        featuredLabel.text = "Week Details"
        featuredLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        featuredLabel.textColor = .black
        contentStackView.addArrangedSubview(featuredLabel)

        // Display first pregnancy week as featured
        if let firstWeek = mockData.mockPregnancyWeeks.first {
            let weekCard = createWeekCard(week: firstWeek)
            contentStackView.addArrangedSubview(weekCard)
        }

        // Add all pregnancy weeks
        let allWeeksLabel = UILabel()
        allWeeksLabel.text = "All Weeks"
        allWeeksLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        allWeeksLabel.textColor = .black
        contentStackView.addArrangedSubview(allWeeksLabel)

        for week in mockData.mockPregnancyWeeks {
            let card = createWeekCard(week: week)
            contentStackView.addArrangedSubview(card)
        }
    }

    private func createWeekCard(week: PinaPregnancyWeek) -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 12
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.1
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 4

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelative = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: card.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: card.bottomAnchor),
            card.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])

        // Week Title
        let titleLabel = UILabel()
        titleLabel.text = week.title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        stackView.addArrangedSubview(titleLabel)

        // Description
        let descLabel = UILabel()
        descLabel.text = week.description
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLabel.textColor = UIColor(white: 0.4, alpha: 1.0)
        descLabel.numberOfLines = 0
        stackView.addArrangedSubview(descLabel)

        // Divider
        let divider = UIView()
        divider.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        stackView.addArrangedSubview(divider)

        // Fetal Development
        let devLabel = UILabel()
        devLabel.text = "Fetal Development"
        devLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        devLabel.textColor = UIColor(red: 0.0, green: 0.75, blue: 0.70, alpha: 1.0)
        stackView.addArrangedSubview(devLabel)

        let devTextLabel = UILabel()
        devTextLabel.text = week.fetalDevelopment
        devTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        devTextLabel.textColor = UIColor(white: 0.4, alpha: 1.0)
        devTextLabel.numberOfLines = 0
        stackView.addArrangedSubview(devTextLabel)

        // Tips
        if !week.tips.isEmpty {
            let divider2 = UIView()
            divider2.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
            divider2.heightAnchor.constraint(equalToConstant: 1).isActive = true
            stackView.addArrangedSubview(divider2)

            let tipsLabel = UILabel()
            tipsLabel.text = "Tips"
            tipsLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            tipsLabel.textColor = UIColor(red: 0.0, green: 0.75, blue: 0.70, alpha: 1.0)
            stackView.addArrangedSubview(tipsLabel)

            for tip in week.tips {
                let tipLabel = UILabel()
                tipLabel.text = "• " + tip
                tipLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
                tipLabel.textColor = UIColor(white: 0.4, alpha: 1.0)
                tipLabel.numberOfLines = 0
                stackView.addArrangedSubview(tipLabel)
            }
        }

        return card
    }
}

// MARK: - Pregnancy Week Picker Data Source

class PregnancyWeekPickerDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    let mockData: PinaMockData

    init(mockData: PinaMockData) {
        self.mockData = mockData
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 40 // Weeks 1-40 as specified
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Week \(row + 1)"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle selection - could update the featured week
    }
}
