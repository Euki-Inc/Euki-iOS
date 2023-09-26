//
//  EUKGlobalSearchViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 1/21/19.
//  Copyright © 2019 Ibis. All rights reserved.
//

import UIKit

class EUKGlobalSearchViewController: EUKBasePinCheckViewController {
    let SearchCell = "SearchCell"
    
    enum CellTags: Int {
        case title = 100,
        description
    }
    
    @IBOutlet weak var searchTextInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var contentItems = [ContentItem]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchTextInput.becomeFirstResponder()
    }
    
    //MARK: - IBActions
    
    @IBAction func searchTextChanged() {
        self.searchContentItems(text: self.searchTextInput.text)
    }
	
	@IBAction func doneAction() {
		self.presentingViewController?.dismiss(animated: true)
	}

    //MARK: - Private
    
    func setUIElements() {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done".localized.uppercased(), style: .plain, target: self, action: #selector(EUKGlobalSearchViewController.doneAction))
		
        self.searchTextInput.addTarget(self, action: #selector(EUKGlobalSearchViewController.searchTextChanged), for: .editingChanged)
        self.searchTextInput.delegate = self
    }
    
    func searchContentItems(text: String?) {
        self.contentItems.removeAll()
        if let text = text, !text.isEmpty {
            let foundItems = ContentManager.sharedInstance.requestContentItem(searchText: text)
            self.contentItems.append(contentsOf: foundItems)
        }
        self.tableView.reloadData()
    }
}

extension EUKGlobalSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.SearchCell, for: indexPath)
        let contentItem = self.contentItems[indexPath.row]
        
        if let titleLabel = cell.contentView.viewWithTag(CellTags.title.rawValue) as? UILabel {
            titleLabel.text = contentItem.title?.localized ?? contentItem.id.localized
        }
        
        if let descriptionLabel = cell.contentView.viewWithTag(CellTags.description.rawValue) as? UILabel {
            descriptionLabel.text = contentItem.content.localized
            descriptionLabel.isHidden = contentItem.content.isEmpty
            descriptionLabel.numberOfLines = 3
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.addBorders(edges: .bottom, color: UIColor.eukiMain, thickness: 0.5)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contentItem = self.contentItems[indexPath.row]
        self.viewController(item: contentItem) { [unowned self] (viewController) in
            if let viewController = viewController {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

extension EUKGlobalSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
