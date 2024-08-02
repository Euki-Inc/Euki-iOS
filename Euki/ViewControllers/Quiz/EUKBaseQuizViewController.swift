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
    @IBOutlet weak var quizCollectionView: UICollectionView!
    
    var quiz: Quiz?
    var currentQuestion: Question?
    var results: (String, [Int])?
    var quizType: QuizType = .contraception

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EUKBaseQuizViewController - View Did Load")
        self.setUIElements()
        self.requestQuiz()
    }
    
    //MARK: - IBActions
    
    @IBAction func showMethod(button: UIButton) {
        guard let index = button.superview?.tag else {
            return
        }
        switch quizType {
        case .contraception:
            if let contentItem = ContraceptionContentManager.sharedInstance.methodContentItem(index: index) {
                self.pushContentItem(contentItem: contentItem)
            }
        case .menstruation:
            if let contentItem = MenstruationContentManager.sharedInstance.methodContentItem(index: index) {
                self.pushContentItem(contentItem: contentItem)
            }
        }
     
    }
    
    //MARK: - Private
    
    func setUIElements() {
        self.questionsCollectionView.contentInset = UIEdgeInsetsMake(0, 30, 0, 30)
        self.questionsCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    func updateUIElements() {
        self.questionsCollectionView.reloadData()
        self.quizCollectionView.reloadData()
    }
    
    func requestQuiz() {
        switch quizType {
        case .contraception:
            requestContraceptionQuiz()
        case .menstruation:
            requestMenstruationQuiz()
        }
     
    }
    
    func requestContraceptionQuiz(){
        QuizManager.sharedInstance.requestContraceptionQuiz { [unowned self] (quiz) in
            if let quiz = quiz {
                self.quiz = quiz
                self.updateUIElements()
            }
        }
    }
    
    func requestMenstruationQuiz(){
        QuizManager.sharedInstance.requestMenstruationQuiz { [unowned self] (quiz) in
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
        
        if quizType == .contraception {
                self.results = QuizManager.sharedInstance.resultContraception(quiz: quiz)
                self.quizCollectionView.reloadData()
            } else {
                self.results = QuizManager.sharedInstance.resultMenstruation(quiz: quiz)
                self.quizCollectionView.reloadData()
            }
    }
    
    class func initViewController(quizType: QuizType) -> UIViewController? {
          let storyboard = UIStoryboard(name: "Quiz", bundle: Bundle.main)
          let viewController = storyboard.instantiateInitialViewController()
              return viewController
       }
}

extension EUKBaseQuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.quizCollectionView {
            return quizType == .contraception ? 12 : (quizType == .menstruation ? 7 : 0)
        }

        if let quiz = self.quiz {
            return quiz.questions.count + 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.quizCollectionView {
            return self.configureContraceptionCell(collectionView: collectionView, cellForItemAt: indexPath)
        }
        
        guard let quiz = self.quiz else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == 0 {
            return self.configureTextCell(collectionView: collectionView, cellForItemAt: indexPath, text: self.quiz?.instructions)
        } else if indexPath.row == (self.collectionView(collectionView, numberOfItemsInSection: 0)) - 1 {
            switch quizType {
            case .contraception:
                if let quiz = self.quiz {
                    let result = QuizManager.sharedInstance.resultContraception(quiz: quiz)
                    return self.configureTextCell(collectionView: collectionView, cellForItemAt: indexPath, text: result.0)
                }
            case .menstruation:
                
                if let quiz = self.quiz {
                    let result = QuizManager.sharedInstance.resultMenstruation(quiz: quiz)
                    return self.configureTextCell(collectionView: collectionView, cellForItemAt: indexPath, text: result.0)
                }
                
            }
          
        }
        
        let question = quiz.questions[indexPath.row - 1]
        return self.configureQuestionCell(collectionView: collectionView, cellForItemAt: indexPath, question: question)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.bounds.size
        if collectionView == self.quizCollectionView {
            return CGSize(width: collectionViewSize.width / 3, height: collectionViewSize.height / 4)
        }
        
        var cellSize: CGSize = collectionView.bounds.size
        cellSize.width -= collectionView.contentInset.left
        cellSize.width -= collectionView.contentInset.right
        return cellSize
    }
    
    func configureContraceptionCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.CellIdentifier, for: indexPath)
        
        var titleText: String?
        var iconName: String?

         if quizType == .contraception {
             iconName = "IconContraception\(indexPath.row + 1)"
             titleText = "contraception_\(indexPath.row + 1)"
         } else if quizType == .menstruation {
             if indexPath.row < bleedingProductsUIOrder.count{
                 let item = bleedingProductsUIOrder[indexPath.row]
                 
                 iconName = "IconMenstruation\(item.rawValue + 1)"
                 titleText = "menstruation_\(item.rawValue + 1)"
             }
             
         }

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
            button.setImage(UIImage(named: iconName ?? ""), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.alpha = alpha
            button.superview?.tag = indexPath.row
            button.addTarget(self, action: #selector(EUKBaseQuizViewController.showMethod(button:)), for: .touchUpInside)
        }
        if let titleLabel = cell.contentView.viewWithTag(CellTags.title.rawValue) as? UILabel {
            titleLabel.text =  titleText?.localized
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
                self.quizCollectionView.reloadData()
            } else if index == self.collectionView(self.questionsCollectionView, numberOfItemsInSection: 0) - 1 {
                self.currentQuestion = nil
                self.showResults()
            } else {
                self.currentQuestion = self.quiz?.questions[index - 1]
                self.quizCollectionView.reloadData()
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
        self.quizCollectionView.reloadData()
    }
}
