//
//  EUKQuestionViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 7/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

protocol EUKQuestionDelegate: AnyObject {
    func questionSelected(question: Question)
}

class EUKQuestionViewController: EUKBaseViewController {
    static let ViewControllerID = "QuestionViewController"
    let QuestionCellIdentifier = "QuestionCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    enum CellTags: Int {
        case button = 100
    }
    
    var question: Question?
    weak var delegate: EUKQuestionDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    //MARK: - IBActions
    
    @IBAction func selected(button: UIButton) {
        guard let index = button.superview?.tag, let question = self.question else {
            return
        }
        
        question.answerIndex = index
        self.delegate?.questionSelected(question: question)
        self.tableView.reloadData()
    }
    
    //MARK: - Private
    
    func setUIElements() {
        self.titleLabel.text = self.question?.title.localized
    }
    
    //MARK: - Public
    
    class func initViewController(question: Question) -> EUKQuestionViewController? {
        if let viewController = UIStoryboard(name: "Quiz", bundle: Bundle.main).instantiateViewController(withIdentifier: EUKQuestionViewController.ViewControllerID) as? EUKQuestionViewController {
            viewController.question = question
            return viewController
        }
        
        return nil
    }
    
}

extension EUKQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question?.options.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let question = self.question else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.QuestionCellIdentifier, for: indexPath)
        let isSelected = (question.answerIndex ?? -1) == indexPath.row
        
        if let button = cell.contentView.viewWithTag(CellTags.button.rawValue) as? UIButton {
            button.setTitle(question.options[indexPath.row].0.localized, for: .normal)
            button.setImage(isSelected ? #imageLiteral(resourceName: "IconAnswerSelectOn") : #imageLiteral(resourceName: "IconAnswerSelectOff"), for: .normal)
            button.superview?.tag = indexPath.row
            button.addTarget(self, action: #selector(EUKQuestionViewController.selected(button:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let question = self.question else {
            return 35
        }
        if question.options[indexPath.row].0 == "about_20_50_one_time"{
            return 50
        }
        return 35.0
    }
}
