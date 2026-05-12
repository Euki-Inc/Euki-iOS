//
//  PinaSymptomsViewController.swift
//  Euki
//
//  La Piña Symptoms - Tab-based interface for Mood, Body, and Notes
//

import UIKit

class PinaSymptomsViewController: UIViewController {

    // MARK: - Properties
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let segmentedControl = UISegmentedControl(items: ["Mood", "Body", "Notes"])
    private let containerView = UIView()
    private var currentChildViewController: UIViewController?

    private enum SymptomsTab: Int {
        case mood = 0
        case body = 1
        case notes = 2
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        self.title = "Symptoms"

        setupHeaderView()
        setupSegmentedControl()
        setupContainerView()
        loadInitialTab()
    }

    // MARK: - Setup Methods

    private func setupHeaderView() {
        headerView.backgroundColor = UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.0) // #8E44AD
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)

        titleLabel.text = "Your Symptoms"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        descriptionLabel.text = "Track mood, body changes, and notes"
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

    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        // Style the segmented control with La Piña colors
        segmentedControl.selectedSegmentTintColor = UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.0)
        if #available(iOS 13.0, *) {
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
            let unselectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(white: 0.4, alpha: 1.0)]
            segmentedControl.setTitleTextAttributes(unselectedTextAttributes, for: .normal)
        }

        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        self.view.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    private func loadInitialTab() {
        loadTab(at: 0)
    }

    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        loadTab(at: sender.selectedSegmentIndex)
    }

    private func loadTab(at index: Int) {
        // Remove current child view controller
        if let currentVC = currentChildViewController {
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }

        let childVC: UIViewController

        guard let tab = SymptomsTab(rawValue: index) else { return }

        switch tab {
        case .mood:
            childVC = loadMoodViewController()
        case .body:
            childVC = loadBodyViewController()
        case .notes:
            childVC = loadNotesViewController()
        }

        self.addChild(childVC)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childVC.view)

        NSLayoutConstraint.activate([
            childVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        childVC.didMove(toParent: self)
        self.currentChildViewController = childVC
    }

    private func loadMoodViewController() -> UIViewController {
        // Try to load EUKEmotionsViewController
        if let vc = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "EUKEmotionsViewController") as? UIViewController {
            return vc
        }
        return createPlaceholderViewController(title: "Mood Tracking", message: "Log your emotional state")
    }

    private func loadBodyViewController() -> UIViewController {
        // Try to load EUKBodyViewController
        if let vc = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "EUKBodyViewController") as? UIViewController {
            return vc
        }
        return createPlaceholderViewController(title: "Body Symptoms", message: "Track physical symptoms")
    }

    private func loadNotesViewController() -> UIViewController {
        // Try to load EUKNoteViewController
        if let vc = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "EUKNoteViewController") as? UIViewController {
            return vc
        }
        return createPlaceholderViewController(title: "Notes", message: "Write journal entries")
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
