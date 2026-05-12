//
//  PinaBlogViewController.swift
//  Euki
//
//  La Piña Blog - WKWebView for blog content
//

import UIKit
import WebKit

class PinaBlogViewController: UIViewController {

    // MARK: - Properties
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let webView = WKWebView()
    private let placeholderView = UIView()
    private let pinaEnv = PinaEnv.sharedInstance

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        self.title = "Blog"

        setupHeaderView()
        setupWebView()
        loadBlogContent()
    }

    // MARK: - Setup Methods

    private func setupHeaderView() {
        headerView.backgroundColor = UIColor(red: 0.88, green: 0.0, blue: 0.60, alpha: 1.0) // #E10098
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)

        titleLabel.text = "La Piña Blog"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        descriptionLabel.text = "Luxury wellness articles and expert content"
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

    private func setupWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        // Optional: Set up web view delegate for navigation
        webView.navigationDelegate = self
    }

    private func loadBlogContent() {
        let blogURL = pinaEnv.blogBaseURL

        if blogURL.isEmpty {
            showPlaceholder()
        } else {
            if let url = URL(string: blogURL) {
                let request = URLRequest(url: url)
                webView.load(request)
            } else {
                showPlaceholder()
            }
        }
    }

    private func showPlaceholder() {
        webView.isHidden = true

        placeholderView.backgroundColor = .white
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(placeholderView)

        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: placeholderView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: placeholderView.centerYAnchor)
        ])

        // Icon
        let iconLabel = UILabel()
        iconLabel.text = "📚"
        iconLabel.font = UIFont.systemFont(ofSize: 48)
        stackView.addArrangedSubview(iconLabel)

        // Title
        let titleLabel = UILabel()
        titleLabel.text = "Blog Coming Soon"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        stackView.addArrangedSubview(titleLabel)

        // Message
        let messageLabel = UILabel()
        messageLabel.text = "Deploy web preview to enable blog"
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 2
        stackView.addArrangedSubview(messageLabel)

        // Details
        let detailsLabel = UILabel()
        detailsLabel.text = "Check back soon for luxury wellness articles, AR flipbooks, and expert content"
        detailsLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        detailsLabel.textColor = UIColor(white: 0.5, alpha: 1.0)
        detailsLabel.textAlignment = .center
        detailsLabel.numberOfLines = 3
        stackView.addArrangedSubview(detailsLabel)
    }
}

// MARK: - WKNavigationDelegate

extension PinaBlogViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Blog load error: \(error.localizedDescription)")
        showPlaceholder()
    }
}
