//
//  EUKBaseQuizViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 7/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBaseQuizViewController: EUKBasePinCheckViewController {
    let CellIdentifier = "CellIdentifier"
    let TextCellIdentifier = "TextCellIdentifier"
    let QuestionCellIdentifier = "QuestionCellIdentifier"
    
    enum CellTags: Int {
        case button = 100,
        title, container
    }
    
    @IBOutlet weak var questionsCollectionView: UICollectionView!
    @IBOutlet weak var contraceptionCollectionView: UICollectionView!
    
    var quiz: Quiz?
    var currentQuestion: Question?
    var results: (String, [Int])?

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        self.requestQuiz()
    }
    
    //MARK: - IBActions
    
    @IBAction func showMethod(button: UIButton) {
        guard let index = button.superview?.tag else {
            return
        }
        
        if let contentItem = ContraceptionContentManager.sharedInstance.methodContentItem(index: index) {
            self.pushContentItem(contentItem: contentItem)
        }
    }
    
    //MARK: - Private
    
    func setUIElements() {
        self.questionsCollectionView.contentInset = UIEdgeInsetsMake(0, 30, 0, 30)
        self.questionsCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    func updateUIElements() {
        self.questionsCollectionView.reloadData()
        self.contraceptionCollectionView.reloadData()
    }
    
    func requestQuiz() {
        QuizManager.sharedInstance.requestContraceptionQuiz { [unowned self] (quiz) in
            if let quiz = quiz {
                self.quiz = quiz
                self.updateUIElements()
            }
        }
    }
    
    func showResults() {
        guard let quiz = self.quiz else {
            return
        }
        
        self.results = QuizManager.sharedInstance.resultContraception(quiz: quiz)
        self.contraceptionCollectionView.reloadData()
    }
    
    class func initViewController() -> UIViewController? {
        if let viewController = UIStoryboard(name: "Quiz", bundle: Bundle.main).instantiateInitialViewController() {
            return viewController
        }
        
        return nil
    }
}

extension EUKBaseQuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.contraceptionCollectionView {
            return 12
        }
        
        if let quiz = self.quiz {
            return quiz.questions.count + 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.contraceptionCollectionView {
            return self.configureContraceptionCell(collectionView: collectionView, cellForItemAt: indexPath)
        }
        
        guard let quiz = self.quiz else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == 0 {
            return self.configureTextCell(collectionView: collectionView, cellForItemAt: indexPath, text: self.quiz?.instructions)
        } else if indexPath.row == (self.collectionView(collectionView, numberOfItemsInSection: 0)) - 1 {
            if let quiz = self.quiz {
                let result = QuizManager.sharedInstance.resultContraception(quiz: quiz)
                return self.configureTextCell(collectionView: collectionView, cellForItemAt: indexPath, text: result.0)
            }
        }
        
        let question = quiz.questions[indexPath.row - 1]
        return self.configureQuestionCell(collectionView: collectionView, cellForItemAt: indexPath, question: question)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.bounds.size
        if collectionView == self.contraceptionCollectionView {
            return CGSize(width: collectionViewSize.width / 3, height: collectionViewSize.height / 4)
        }
        
        var cellSize: CGSize = collectionView.bounds.size
        cellSize.width -= collectionView.contentInset.left
        cellSize.width -= collectionView.contentInset.right
        return cellSize
    }
    
    func configureContraceptionCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.CellIdentifier, for: indexPath)
        
        var alpha: CGFloat = 0.3
        if let currentQuestion = self.currentQuestion, let answerIndex = currentQuestion.answerIndex {
            if currentQuestion.options[answerIndex].1.contains(indexPath.row + 1) {
                alpha = 1.0
            }
        }
        
        if let results = self.results {
            if results.1.contains(indexPath.row + 1) {
                alpha = 1.0
            }
        }
        
        if let button = cell.contentView.viewWithTag(CellTags.button.rawValue) as? UIButton {
            button.setImage(UIImage(named: "IconContraception\(indexPath.row + 1)"), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.alpha = alpha
            button.superview?.tag = indexPath.row
            button.addTarget(self, action: #selector(EUKBaseQuizViewController.showMethod(button:)), for: .touchUpInside)
        }
        if let titleLabel = cell.contentView.viewWithTag(CellTags.title.rawValue) as? UILabel {
            titleLabel.text = "contraception_\(indexPath.row + 1)".localized
            titleLabel.alpha = alpha
        }
        
        return cell
    }
    
    func configureTextCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, text: String?) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.TextCellIdentifier, for: indexPath)
        
        if let textLabel = cell.contentView.viewWithTag(CellTags.title.rawValue) as? UILabel {
            textLabel.text = text?.localized
        }
        
        return cell
    }
    
    func configureQuestionCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, question: Question) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.QuestionCellIdentifier, for: indexPath)
        
        if let viewController = EUKQuestionViewController.initViewController(question: question) {
            if let containerView = cell.contentView.viewWithTag(CellTags.container.rawValue) {
                self.configureChildViewController(childController: viewController, onView: containerView)
                viewController.delegate = self
            }
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.bounds.size.height == 250.0 {
            self.results = nil
            let indexPaths = self.questionsCollectionView.indexPathsForVisibleItems
            
            var min = 1000
            var max = -1
            for indexPath in indexPaths {
                if indexPath.row > max {
                    max = indexPath.row
                }
                if indexPath.row < min {
                    min = indexPath.row
                }
            }
            
            var index: Int
            if indexPaths.count == 2 {
                if min == 0 {
                    index = min
                } else {
                    index = max
                }
            } else {
                index = (max + min) / 2
            }
            
            if index == 0 {
                self.currentQuestion = nil
                self.contraceptionCollectionView.reloadData()
            } else if index == self.collectionView(self.questionsCollectionView, numberOfItemsInSection: 0) - 1 {
                self.currentQuestion = nil
                self.showResults()
            } else {
                self.currentQuestion = self.quiz?.questions[index - 1]
                self.contraceptionCollectionView.reloadData()
            }
            
            if max == self.collectionView(self.questionsCollectionView, numberOfItemsInSection: 0) - 1 {
                self.questionsCollectionView.reloadData()
            }
        }
    }
}

extension EUKBaseQuizViewController: EUKQuestionDelegate {
    func questionSelected(question: Question) {
        self.results = nil
        self.currentQuestion = question
        self.contraceptionCollectionView.reloadData()
    }
}
