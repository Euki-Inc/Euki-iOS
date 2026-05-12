//
//  PinaPaywallViewController.swift
//  Euki
//
//  La Piña Premium Paywall - Shows features and handles subscription
//

import UIKit

class PinaPaywallViewController: UIViewController {

    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let mockData = PinaMockData.sharedInstance
    private let stripeStub = PinaStripeStub.sharedInstance
    private let closeButton = UIButton()
    private let subscribeButton = UIButton()
    private var isProcessing = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupCloseButton()
        setupScrollView()
        setupContent()
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

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        contentStackView.axis = .vertical
        contentStackView.spacing = 24
        contentStackView.alignment = .fill
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func setupContent() {
        // Header
        let headerStack = UIStackView()
        headerStack.axis = .vertical
        headerStack.spacing = 8
        headerStack.alignment = .center
        contentStackView.addArrangedSubview(headerStack)

        let badgeLabel = UILabel()
        badgeLabel.text = "✨ PREMIUM"
        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        badgeLabel.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
        headerStack.addArrangedSubview(badgeLabel)

        let titleLabel = UILabel()
        titleLabel.text = "Unlock La Piña Premium"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        headerStack.addArrangedSubview(titleLabel)

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Access exclusive features and advanced insights"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2
        headerStack.addArrangedSubview(subtitleLabel)

        // Price Card
        let priceCard = createPriceCard()
        contentStackView.addArrangedSubview(priceCard)

        // Features Section
        let featuresLabel = UILabel()
        featuresLabel.text = "Premium Features"
        featuresLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        featuresLabel.textColor = .black
        contentStackView.addArrangedSubview(featuresLabel)

        let featuresStack = UIStackView()
        featuresStack.axis = .vertical
        featuresStack.spacing = 12
        contentStackView.addArrangedSubview(featuresStack)

        for feature in mockData.mockPremiumFeatures {
            let featureRow = createFeatureRow(feature: feature)
            featuresStack.addArrangedSubview(featureRow)
        }

        // Subscribe Button
        subscribeButton.setTitle("Subscribe Now", for: .normal)
        subscribeButton.setTitleColor(.white, for: .normal)
        subscribeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        subscribeButton.backgroundColor = UIColor(red: 0.88, green: 0.0, blue: 0.60, alpha: 1.0) // #E10098
        subscribeButton.layer.cornerRadius = 12
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        subscribeButton.addTarget(self, action: #selector(subscribeAction), for: .touchUpInside)
        subscribeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        contentStackView.addArrangedSubview(subscribeButton)

        // Terms
        let termsLabel = UILabel()
        termsLabel.text = "Free trial available. Cancel anytime from your account settings."
        termsLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        termsLabel.textColor = .gray
        termsLabel.textAlignment = .center
        termsLabel.numberOfLines = 2
        contentStackView.addArrangedSubview(termsLabel)

        // Restore Purchases Button
        let restoreButton = UIButton(type: .system)
        restoreButton.setTitle("Restore Purchases", for: .normal)
        restoreButton.setTitleColor(UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.0), for: .normal)
        restoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        restoreButton.addTarget(self, action: #selector(restorePurchasesAction), for: .touchUpInside)
        contentStackView.addArrangedSubview(restoreButton)
    }

    private func createPriceCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        card.layer.cornerRadius = 16
        card.layer.borderColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 0.3).cgColor
        card.layer.borderWidth = 2

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20)
        stackView.isLayoutMarginsRelative = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: card.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: card.bottomAnchor)
        ])

        let priceLabel = UILabel()
        priceLabel.text = stripeStub.getPremiumPrice()
        priceLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        priceLabel.textColor = UIColor(red: 0.88, green: 0.0, blue: 0.60, alpha: 1.0)
        stackView.addArrangedSubview(priceLabel)

        let billingLabel = UILabel()
        billingLabel.text = "per year"
        billingLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        billingLabel.textColor = .gray
        stackView.addArrangedSubview(billingLabel)

        return card
    }

    private func createFeatureRow(feature: String) -> UIView {
        let row = UIView()

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        row.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: row.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: row.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: row.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: row.bottomAnchor),
            row.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])

        let checkmarkLabel = UILabel()
        checkmarkLabel.text = "✓"
        checkmarkLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        checkmarkLabel.textColor = UIColor(red: 0.0, green: 0.75, blue: 0.70, alpha: 1.0)
        checkmarkLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        stackView.addArrangedSubview(checkmarkLabel)

        let featureLabel = UILabel()
        featureLabel.text = feature
        featureLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        featureLabel.textColor = .black
        featureLabel.numberOfLines = 0
        stackView.addArrangedSubview(featureLabel)

        return row
    }

    // MARK: - Actions

    @objc private func closeAction() {
        self.dismiss(animated: true)
    }

    @objc private func subscribeAction() {
        guard !isProcessing else { return }

        isProcessing = true
        subscribeButton.isEnabled = false
        subscribeButton.alpha = 0.5

        stripeStub.purchaseSubscription(productId: "la_pina_premium_annual", price: stripeStub.getPremiumPrice()) { [weak self] response in
            self?.isProcessing = false
            self?.subscribeButton.isEnabled = true
            self?.subscribeButton.alpha = 1.0

            if response.success {
                self?.showSuccessAlert()
            } else {
                self?.showErrorAlert(message: response.message)
            }
        }
    }

    @objc private func restorePurchasesAction() {
        stripeStub.restorePurchases { [weak self] response in
            if response.success && response.subscription != nil {
                self?.showSuccessAlert(message: "Purchases restored successfully")
            } else {
                self?.showInfoAlert(message: "No previous purchases found")
            }
        }
    }

    private func showSuccessAlert() {
        let alert = UIAlertController(title: "Welcome to Premium! 🎉", message: "You now have access to all premium features", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        self.present(alert, animated: true)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    private func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    private func showInfoAlert(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
