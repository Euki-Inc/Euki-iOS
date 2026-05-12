//
//  PinaCycleHomeViewController.swift
//  Euki
//
//  La Piña Cycle Home - Wraps EUKCalendarTabViewController with branded header
//

import UIKit

class PinaCycleHomeViewController: UIViewController {

    // MARK: - Properties
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let childContainerView = UIView()
    private var childViewController: UIViewController?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        self.title = "Cycle"

        setupHeaderView()
        setupChildViewController()
    }

    // MARK: - Setup Methods

    private func setupHeaderView() {
        // Header background with La Piña primary color
        headerView.backgroundColor = UIColor(red: 0.88, green: 0.0, blue: 0.60, alpha: 1.0) // #E10098
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)

        // Title Label
        titleLabel.text = "Your Cycle"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        // Description Label
        descriptionLabel.text = "Track your period, predictions, and ovulation"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(descriptionLabel)

        // Header Constraints
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

    private func setupChildViewController() {
        // Create or load the child view controller (EUKCalendarTabViewController)
        // For now, we'll create a fallback if the controller isn't available

        let childVC: UIViewController

        // Try to instantiate EUKCalendarTabViewController if available
        if let storyboard = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "EUKCalendarTabViewController") as? UIViewController {
            childVC = storyboard
        } else if let storyboard = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "EUKBleedingViewController") as? UIViewController {
            childVC = storyboard
        } else {
            // Fallback: Create a simple placeholder
            childVC = createPlaceholderViewController(title: "Cycle Calendar", message: "Cycle tracking interface")
        }

        self.addChild(childVC)
        childContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(childContainerView)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        childContainerView.addSubview(childVC.view)

        // Container Constraints
        NSLayoutConstraint.activate([
            childContainerView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            childContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            childContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            childContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            childVC.view.topAnchor.constraint(equalTo: childContainerView.topAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: childContainerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: childContainerView.trailingAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: childContainerView.bottomAnchor)
        ])

        childVC.didMove(toParent: self)
        self.childViewController = childVC
    }

    private func createPlaceholderViewController(title: String, message: String) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(stackView)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .black
        stackView.addArrangedSubview(titleLabel)

        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = .gray
        stackView.addArrangedSubview(messageLabel)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
        ])

        return vc
    }
}
