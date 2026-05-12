//
//  EUKAdminDashboardViewController.swift
//  Euki
//
//  Created by OpenAI on 2026-01-14.
//  Copyright © 2026 Ibis. All rights reserved.
//

import UIKit

final class EUKAdminDashboardViewController: EUKBaseViewController {
    private enum Section: Int, CaseIterable {
        case overview
        case aiWorkflows
        case integrations
        case dataAndSync

        var titleKey: String {
            switch self {
            case .overview:
                return "admin_section_overview"
            case .aiWorkflows:
                return "admin_section_ai"
            case .integrations:
                return "admin_section_integrations"
            case .dataAndSync:
                return "admin_section_data"
            }
        }
    }

    private struct Row {
        let titleKey: String
        let detailKey: String
        let isToggle: Bool
        var isOn: Bool
    }

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var rowsBySection: [Section: [Row]] = [:]

    override func viewDidLoad() {
        navigationTitle = "admin_dashboard"
        super.viewDidLoad()
        configureRows()
        configureTableView()
    }

    private func configureRows() {
        rowsBySection = [
            .overview: [
                Row(titleKey: "admin_dashboard_overview_title",
                    detailKey: "admin_dashboard_overview_detail",
                    isToggle: false,
                    isOn: false)
            ],
            .aiWorkflows: [
                Row(titleKey: "admin_ai_agents",
                    detailKey: "admin_ai_agents_detail",
                    isToggle: true,
                    isOn: true),
                Row(titleKey: "admin_ai_workflows",
                    detailKey: "admin_ai_workflows_detail",
                    isToggle: true,
                    isOn: false)
            ],
            .integrations: [
                Row(titleKey: "admin_integration_n8n",
                    detailKey: "admin_integration_n8n_detail",
                    isToggle: true,
                    isOn: false),
                Row(titleKey: "admin_integration_calendar_sync",
                    detailKey: "admin_integration_calendar_sync_detail",
                    isToggle: true,
                    isOn: true)
            ],
            .dataAndSync: [
                Row(titleKey: "admin_data_offline_cache",
                    detailKey: "admin_data_offline_cache_detail",
                    isToggle: true,
                    isOn: true),
                Row(titleKey: "admin_data_export",
                    detailKey: "admin_data_export_detail",
                    isToggle: false,
                    isOn: false)
            ]
        ]
    }

    private func configureTableView() {
        view.backgroundColor = UIColor(named: "GreenClear") ?? UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AdminCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension EUKAdminDashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section),
              let rows = rowsBySection[section] else {
            return 0
        }
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section),
              var rows = rowsBySection[section] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminCell", for: indexPath)
        let row = rows[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = row.titleKey.localized
        content.secondaryText = row.detailKey.localized
        content.textProperties.color = UIColor.eukiMain
        content.secondaryTextProperties.color = UIColor.eukiMain
        cell.contentConfiguration = content
        cell.selectionStyle = row.isToggle ? .none : .default

        if row.isToggle {
            let toggle = UISwitch()
            toggle.isOn = row.isOn
            toggle.onTintColor = UIColor.eukiAccent
            toggle.tag = indexPath.section * 100 + indexPath.row
            toggle.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
            cell.accessoryView = toggle
        } else {
            cell.accessoryView = nil
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
}

extension EUKAdminDashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else {
            return nil
        }
        return section.titleKey.localized
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section),
              let rows = rowsBySection[section] else {
            return
        }
        let row = rows[indexPath.row]
        if row.isToggle {
            return
        }

        let alert = UIAlertController(
            title: row.titleKey.localized,
            message: row.detailKey.localized,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc private func toggleChanged(_ sender: UISwitch) {
        let sectionIndex = sender.tag / 100
        let rowIndex = sender.tag % 100
        guard let section = Section(rawValue: sectionIndex),
              var rows = rowsBySection[section],
              rows.indices.contains(rowIndex) else {
            return
        }

        rows[rowIndex].isOn = sender.isOn
        rowsBySection[section] = rows
    }
}
