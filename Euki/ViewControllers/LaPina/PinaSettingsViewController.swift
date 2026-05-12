//
//  PinaSettingsViewController.swift
//  Euki
//
//  La Piña Settings - App settings and preferences
//

import UIKit

class PinaSettingsViewController: UIViewController {

    // MARK: - Properties
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let closeButton = UIButton()

    private enum SettingsSection: Int {
        case account = 0
        case privacy = 1
        case about = 2
        case premium = 3

        static var count: Int { 4 }
    }

    private let settingsData: [[(String, String)]] = [
        [
            ("Account Settings", "Manage your profile"),
            ("Notifications", "Control app notifications"),
            ("Data & Privacy", "Export or delete your data")
        ],
        [
            ("Privacy Policy", "Read our privacy terms"),
            ("Terms of Service", "View terms of service")
        ],
        [
            ("About La Piña", "Learn about our app"),
            ("Version 1.0", "Current app version"),
            ("Contact Support", "Get help from our team")
        ],
        [
            ("Upgrade to Premium", "Unlock premium features")
        ]
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        setupCloseButton()
        setupHeaderView()
        setupTableView()
    }

    // MARK: - Setup Methods

    private func setupCloseButton() {
        closeButton.setTitle("✕", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupHeaderView() {
        headerView.backgroundColor = UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.0) // #8E44AD
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)

        titleLabel.text = "Settings"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        descriptionLabel.text = "Manage your app preferences"
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

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1.0)

        self.view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func closeAction() {
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PinaSettingsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let settingSection = SettingsSection(rawValue: section) else { return 0 }
        return settingsData[settingSection.rawValue].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.backgroundColor = .white

        guard let settingSection = SettingsSection(rawValue: indexPath.section) else { return cell }

        let (title, subtitle) = settingsData[settingSection.rawValue][indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = title
        config.secondaryText = subtitle
        config.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        config.textProperties.color = .black
        config.secondaryTextProperties.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        config.secondaryTextProperties.color = .gray

        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .gray

        // Apply theme color for premium section
        if settingSection == .premium {
            config.textProperties.color = UIColor(red: 0.88, green: 0.0, blue: 0.60, alpha: 1.0)
            config.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            config.secondaryTextProperties.color = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
            cell.contentConfiguration = config
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let settingSection = SettingsSection(rawValue: section) else { return nil }

        switch settingSection {
        case .account:
            return "Account"
        case .privacy:
            return "Legal"
        case .about:
            return "About"
        case .premium:
            return "Premium"
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let settingSection = SettingsSection(rawValue: indexPath.section) else { return }

        let (title, _) = settingsData[settingSection.rawValue][indexPath.row]

        switch settingSection {
        case .account:
            handleAccountAction(title: title)
        case .privacy:
            handlePrivacyAction(title: title)
        case .about:
            handleAboutAction(title: title)
        case .premium:
            handlePremiumAction(title: title)
        }
    }

    // MARK: - Action Handlers

    private func handleAccountAction(title: String) {
        switch title {
        case "Account Settings":
            showAlert(title: "Account Settings", message: "Navigate to account configuration")
        case "Notifications":
            showAlert(title: "Notifications", message: "Manage notification preferences")
        case "Data & Privacy":
            showAlert(title: "Data & Privacy", message: "Export or delete your data")
        default:
            break
        }
    }

    private func handlePrivacyAction(title: String) {
        switch title {
        case "Privacy Policy":
            showAlert(title: "Privacy Policy", message: "View our privacy policy at www.lapina.app/privacy")
        case "Terms of Service":
            showAlert(title: "Terms of Service", message: "View our terms at www.lapina.app/terms")
        default:
            break
        }
    }

    private func handleAboutAction(title: String) {
        switch title {
        case "About La Piña":
            showAlert(title: "About La Piña", message: "La Piña is a premium women's health app for cycle tracking, pregnancy planning, and wellness insights.")
        case "Version 1.0":
            showAlert(title: "Version", message: "La Piña v1.0\nBuild 1")
        case "Contact Support":
            showAlert(title: "Support", message: "Email: support@lapina.app\nWeb: www.lapina.app/support")
        default:
            break
        }
    }

    private func handlePremiumAction(title: String) {
        switch title {
        case "Upgrade to Premium":
            presentPaywall()
        default:
            break
        }
    }

    private func presentPaywall() {
        let paywallVC = PinaPaywallViewController()
        paywallVC.modalPresentationStyle = .automatic
        self.present(paywallVC, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
