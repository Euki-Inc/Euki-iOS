//
//  EUKBaseViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/18/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBaseViewController: UIViewController {
	@IBOutlet var resizableConstraints: [NSLayoutConstraint]?
	@IBOutlet var resizableStacksViews: [UIStackView]?
	
    let DoneSegueIdentifier = "DoneSegueIdentifier"
    
    var bookmarkButtonOffItem: UIBarButtonItem!
    var bookmarkButtonOnItem: UIBarButtonItem!
    
    var mustShowBookmarkButton = true
    var index = 0
    var progressView: AJProgressView?
    var navigationTitle: String?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookmarkButtonOffItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BtnBookmarkOff"), style: .done, target: self, action: #selector(EUKBaseViewController.addBookmarkAction))
        self.bookmarkButtonOnItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BtnBookmarkOn"), style: .done, target: self, action: #selector(EUKBaseViewController.removeBookmarkAction))
        
        if self.mustShowBookmarkButton {
            self.showBookmarkButton()
        }
        self.showNavigationTitle()
        self.showBackButton()
		
		if UIScreen.main.bounds.height < 700 {
			self.updateConstraint()
		}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PrivacyManager.sharedInstance.verifyAutoRemoveData()
    }
    
    //MARK: - IBActions
    
    @IBAction func addBookmarkAction() {
    }
    
    @IBAction func removeBookmarkAction() {
    }
    
    @IBAction func done(segue: UIStoryboardSegue) {
    }
    
    //MARK: - Private
    
    func showBackButton() {
    }
    
    func showBookmarkButton() {
    }
    
    func showNavigationTitle() {
        if let navigationTitle = self.navigationTitle{
            self.title = navigationTitle.localized
            self.navigationItem.title = navigationTitle.localized
            
            if let view = navigationItem.titleView, view.subviews.count > 0{
                if let stackView = view.subviews[0] as? UIStackView{
                    for view in stackView.subviews{
                        if let label = view as? UILabel{
                            label.text = navigationTitle.localized
                        }
                    }
                }
            }
        }
    }
	
	func updateConstraint() {
		if let resizableConstraints = self.resizableConstraints {
			for constraint in resizableConstraints {
				constraint.constant = constraint.constant / 2
			}
		}
		
		if let resizableStackViews = self.resizableStacksViews {
			for stackView in resizableStackViews {
				stackView.spacing = stackView.spacing / 2
			}
		}
	}
	
	func showError(message: String) {
		let alertViewController = UIAlertController(title: "error".localized, message: message.localized, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "ok".localized, style: .cancel, handler: nil)
		alertViewController.addAction(okAction)
		self.present(alertViewController, animated: true, completion: nil)
	}
    
    //MARK: - Content Manager
    
    func showContentItem(item: ContentItem) {
        switch item.id {
        case "compare_methods":
            if let viewController = EUKBaseQuizViewController.initViewController(quizType: .contraception) {
                self.present(viewController, animated: true, completion: nil)
            }
        case "product_quiz":
            if let viewController = EUKBaseQuizViewController.initViewController(quizType: .menstruation) {
                if let viewC = viewController.visibleViewController() as? EUKBaseQuizViewController {
                    viewC.quizType = .menstruation
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        case "medical_abortion":
            let viewController = EUKMedicalAbortionViewController.initViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case "suction_or_vacuum":
            let contentItem = AbortionContentManager.sharedInstance.abortionSuctionVacuum()
            if let viewController = EUKAbortionInfoViewController.initViewController() {
                viewController.contentItem = contentItem
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        case "dilation_evacuation":
            let contentItem = AbortionContentManager.sharedInstance.abortiondilationEvacuation()
            if let viewController = EUKAbortionInfoViewController.initViewController() {
                viewController.contentItem = contentItem
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        case "concerned_sti_hiv":
            ContentManager.sharedInstance.requestSTIs { [unowned self] (contentItem) in
                self.pushContentItem(contentItem: contentItem)
            }
        case "concerned_pregnancy":
            ContentManager.sharedInstance.requestPregnancyOptions { [unowned self] (contentItem) in
                self.pushContentItem(contentItem: contentItem)
            }
        default:
            self.pushContentItem(contentItem: item)
        }
    }
    
    func viewController(item: ContentItem, responseHandler: @escaping (UIViewController?) -> Void) {
        switch item.id {
        case "compare_methods":
            responseHandler(EUKBaseQuizViewController.initViewController(quizType: .contraception))
        case "product_quiz":
            responseHandler(EUKBaseQuizViewController.initViewController(quizType: .menstruation))
        case "medical_abortion":
            responseHandler(EUKMedicalAbortionViewController.initViewController())
        case "suction_or_vacuum":
            let contentItem = AbortionContentManager.sharedInstance.abortionSuctionVacuum()
            if let viewController = EUKAbortionInfoViewController.initViewController() {
                viewController.contentItem = contentItem
                responseHandler(viewController)
            } else {
                responseHandler(nil)
            }
        case "dilation_evacuation":
            let contentItem = AbortionContentManager.sharedInstance.abortiondilationEvacuation()
            if let viewController = EUKAbortionInfoViewController.initViewController() {
                viewController.contentItem = contentItem
                responseHandler(viewController)
            }
            responseHandler(nil)
        case "concerned_sti_hiv":
            ContentManager.sharedInstance.requestSTIs { (contentItem) in
                if let viewController = EUKAutoContentViewController.initViewController() {
                    viewController.contentItem = contentItem
                    responseHandler(viewController)
                } else {
                    responseHandler(nil)
                }
            }
        case "concerned_pregnancy":
            ContentManager.sharedInstance.requestPregnancyOptions { (contentItem) in
                if let viewController = EUKAutoContentViewController.initViewController() {
                    viewController.contentItem = contentItem
                    responseHandler(viewController)
                } else {
                    responseHandler(nil)
                }
            }
        default:
            if item.isAbortionItem {
                if let viewController = EUKAbortionInfoViewController.initViewController() {
                    viewController.contentItem = item
                    responseHandler(viewController)
                } else {
                    responseHandler(nil)
                }
            } else {
                if let viewController = EUKAutoContentViewController.initViewController() {
                    viewController.contentItem = item
                    responseHandler(viewController)
                } else {
                    responseHandler(nil)
                }
            }
        }
    }
    
    //MARK: - Public
    
    func showLoading() {
        if self.progressView == nil {
            let progressView = AJProgressView()
            progressView.imgLogo = #imageLiteral(resourceName: "IconLoader")
            progressView.firstColor = UIColor.eukiMain
            progressView.secondColor = UIColor.eukiAccent
            progressView.duration = 5.0
            progressView.lineWidth = 4.0
            progressView.bgColor  = UIColor.black.withAlphaComponent(0.3)
            self.progressView = progressView
        }
        
        if let progressView = self.progressView {
            if progressView.isAnimating ?? false == false {
                progressView.show()
            }
        }
    }
    
    func dismissLoading() {
        if let progressView = self.progressView {
            progressView.hide()
            self.progressView = nil
        }
    }
    
    func pushContentItem(contentItem: ContentItem?) {
        if let viewController = EUKAutoContentViewController.initViewController() {
            viewController.contentItem = contentItem
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension EUKBaseViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "abortion" {
            EUKHomeViewController.ShouldShowAbortion = true
            self.navigationController?.popToRootViewController(animated: true)
        }
        if URL.absoluteString == "reminders" {
            let remindersViewConroller = EUKRemindersViewController.initNavViewController()
            self.present(remindersViewConroller, animated: true, completion: nil)
            return false
        }
        if URL.absoluteString == "resources" || URL.absoluteString == "sexuality_resources" || URL.absoluteString == "contraception" || URL.absoluteString == "method_information"  || URL.absoluteString == "symptom_management" {
            if let item = ContentManager.sharedInstance.requestContentItem(id: URL.absoluteString) {
                self.showContentItem(item: item)
            }
            return false
        }
        if URL.absoluteString == "implant_content_3_info" || URL.absoluteString == "telehealth_popup_info" {
            let alertController = self.alertViewController(title: nil, message: URL.absoluteString.localized, okHandler: nil)
            self.present(alertController, animated: true)
            return false
        }
        if URL.absoluteString.isUrl() {
            if URL.isTelephone() {
                if UIApplication.shared.canOpenURL(URL) {
                    UIApplication.shared.open(URL, options: [:], completionHandler: nil)
                }
            } else {
                self.showURL(url: URL)
            }
            return false
        }
        return true
    }
}



extension UIViewController {
    func visibleViewController() -> UIViewController? {
        if let nav = self as? UINavigationController {
            return nav.visibleViewController
        }
        return self
    }
    
}
