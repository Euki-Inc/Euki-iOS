//
//  PinaInsightsViewController.swift
//  Euki
//
//  La Piña Insights - Health alerts and pattern analysis
//

import UIKit

class PinaInsightsViewController: UIViewController {

    // MARK: - Properties
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let mockData = PinaMockData.sharedInstance

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        self.title = "Insights"

        setupHeaderView()
        setupScrollView()
        setupContent()
    }

    // MARK: - Setup Methods

    private func setupHeaderView() {
        headerView.backgroundColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0) // #FFD600
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)

        titleLabel.text = "Your Insights"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = UIColor(white: 0.2, alpha: 1.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        descriptionLabel.text = "Health alerts and pattern analysis"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor(white: 0.3, alpha: 1.0)
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
        // Add Health Alerts Section
        let alertsLabel = UILabel()
        alertsLabel.text = "Health Alerts"
        alertsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        alertsLabel.textColor = .black
        contentStackView.addArrangedSubview(alertsLabel)

        // Display mock insights as cards
        for insight in mockData.mockInsights {
            let card = createInsightCard(insight: insight)
            contentStackView.addArrangedSubview(card)
        }

        // Add Divider
        let divider = UIView()
        divider.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        contentStackView.addArrangedSubview(divider)

        // Add Saved Resources Section
        let savedLabel = UILabel()
        savedLabel.text = "Saved Resources"
        savedLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        savedLabel.textColor = .black
        contentStackView.addArrangedSubview(savedLabel)

        // Try to embed EUKBookmarksViewController
        let bookmarksVC = loadBookmarksViewController()
        if let bookmarksVC = bookmarksVC {
            self.addChild(bookmarksVC)
            bookmarksVC.view.translatesAutoresizingMaskIntoConstraints = false
            contentStackView.addArrangedSubview(bookmarksVC.view)

            NSLayoutConstraint.activate([
                bookmarksVC.view.heightAnchor.constraint(equalToConstant: 300)
            ])

            bookmarksVC.didMove(toParent: self)
        } else {
            let placeholderCard = UIView()
            placeholderCard.backgroundColor = .white
            placeholderCard.layer.cornerRadius = 12
            placeholderCard.heightAnchor.constraint(equalToConstant: 150).isActive = true

            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 8
            stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            stackView.isLayoutMarginsRelative = true
            stackView.translatesAutoresizingMaskIntoConstraints = false
            placeholderCard.addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: placeholderCard.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: placeholderCard.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: placeholderCard.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: placeholderCard.bottomAnchor)
            ])

            let titleLabel = UILabel()
            titleLabel.text = "Bookmarks"
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            titleLabel.textColor = .black
            stackView.addArrangedSubview(titleLabel)

            let messageLabel = UILabel()
            messageLabel.text = "Save articles and resources for later"
            messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            messageLabel.textColor = .gray
            stackView.addArrangedSubview(messageLabel)

            contentStackView.addArrangedSubview(placeholderCard)
        }
    }

    private func createInsightCard(insight: PinaInsight) -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 12
        card.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        card.layer.borderWidth = 1

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        stackView.isLayoutMarginsRelative = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: card.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: card.bottomAnchor),
            card.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])

        // Top row with icon and severity
        let topRowStackView = UIStackView()
        topRowStackView.axis = .horizontal
        topRowStackView.spacing = 8
        topRowStackView.alignment = .top
        stackView.addArrangedSubview(topRowStackView)

        // Icon/Badge
        let iconLabel = UILabel()
        iconLabel.text = "⚠"
        iconLabel.font = UIFont.systemFont(ofSize: 20)
        iconLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        topRowStackView.addArrangedSubview(iconLabel)

        // Title and Severity
        let titleStackView = UIStackView()
        titleStackView.axis = .vertical
        titleStackView.spacing = 4
        topRowStackView.addArrangedSubview(titleStackView)

        let titleLabel = UILabel()
        titleLabel.text = insight.title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleStackView.addArrangedSubview(titleLabel)

        let severityLabel = UILabel()
        severityLabel.text = insight.severity.uppercased()
        severityLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        severityLabel.textColor = severityColor(for: insight.severity)
        titleStackView.addArrangedSubview(severityLabel)

        // Message
        let messageLabel = UILabel()
        messageLabel.text = insight.message
        messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        messageLabel.textColor = UIColor(white: 0.4, alpha: 1.0)
        messageLabel.numberOfLines = 0
        stackView.addArrangedSubview(messageLabel)

        return card
    }

    private func severityColor(for severity: String) -> UIColor {
        switch severity.lowercased() {
        case "high":
            return UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
        case "medium":
            return UIColor(red: 1.0, green: 0.65, blue: 0.0, alpha: 1.0)
        case "low":
            return UIColor(red: 0.0, green: 0.75, blue: 0.70, alpha: 1.0)
        default:
            return UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.0)
        }
    }

    private func loadBookmarksViewController() -> UIViewController? {
        // Try to load EUKBookmarksViewController
        if let storyboard = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "EUKBookmarksViewController") as? UIViewController {
            return storyboard
        }
        return nil
    }
}
