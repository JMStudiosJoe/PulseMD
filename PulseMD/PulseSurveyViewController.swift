//
//  PulseSurveyViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/11/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

protocol JMSurveyQuestionsPresentationDelegate
{
    func removeBlur()
    func makeAnswerObjectWithCorrectTypeAndStore()
}



class PulseSurveyViewController: UIViewController, JMSurveyQuestionsPresentationDelegate {

    //question container
    @IBOutlet weak var surveyQuestionContainer: UIView!
    @IBOutlet weak var nextButton: UIButton!   //just next is a reserve word or something
    @IBOutlet weak var questionText: UITextView!
    
    var blurEffectView : UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nc.addObserver(forName:Notification.Name(rawValue:"nextButtonFadeIn"),
                       object:nil, queue:nil,
                       using:nextButtonFadeIn)
        nc.addObserver(forName:Notification.Name(rawValue:"nextButtonFadeOut"),
                       object:nil, queue:nil,
                       using:nextButtonFadeOut)
        nc.addObserver(forName:Notification.Name(rawValue:"surveyAnswerCreation"),
                       object:nil, queue:nil,
                       using:surveyAnswerCreation)

        startSurvey()
        //surveyAnswerCreation
        // Do any additional setup after loading the view.
    }
    
    //MARK: Next button event handlers for when user selects an answer to fade in the next button and fade it out
    func nextButtonFadeIn(notification:Notification) -> Void {
        
        nextButton.fadeIn()
        
    }
    
    func nextButtonFadeOut(notification:Notification) -> Void {
        
        nextButton.fadeOut()
        
    }
    //MARK: end next button
    
    func startSurvey() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        currentSurveyQuestionIndex = 0
        nc.post(name:Notification.Name(rawValue:"nextButtonFadeOut"),
                object: nil)
        // Instantiate View Controller
        let StarRatingViewController = storyboard.instantiateViewController(withIdentifier: "StarRatingViewController") as! StarRatingViewController
        addViewControllerAsChildViewController(viewController: StarRatingViewController)
        determinQuestionType()
        
    }
    
    @IBAction func nextQuestion(_ sender: AnyObject) {
        
        self.surveyQuestionContainer.slideOut()
        self.questionText.slideOut()
        nc.post(name:Notification.Name(rawValue:"nextButtonFadeOut"),
                object: nil)
        if( deployedSurveyQuestions?[currentSurveyQuestionIndex].type == "text" ||
            deployedSurveyQuestions?[currentSurveyQuestionIndex].type == "text_area" ||
            deployedSurveyQuestions?[currentSurveyQuestionIndex].type == "email") {
            
            
            nc.post(name:Notification.Name(rawValue:"surveyAnswerCreation"),
                    object: nil)
        }
        
        incrementSurveyIndex()
        
        self.questionText.fadeOut()
        self.surveyQuestionContainer.fadeOut()

    }
    
    @IBAction func backQuestion(_ sender: AnyObject) {
        decrementSurveyIndex()
    }
    
    func decrementSurveyIndex() {
        if ( currentSurveyQuestionIndex < (deployedSurveyQuestions?.count)! && currentSurveyQuestionIndex > 0 ) {
            
            surveyAnswers.remove( at: surveyAnswers.count - 1 )
            currentSurveyQuestionIndex! -= 1
            determinQuestionType()
        }
    }
    func incrementSurveyIndex() {
        if ( currentSurveyQuestionIndex < ( deployedSurveyQuestions?.count )! - 1 && currentSurveyQuestionIndex >= 0 ) {
            
            currentSurveyQuestionIndex! += 1
            determinQuestionType()
        }
        else {
            //finish the survey
            performSegue(withIdentifier: "endSurvey", sender: self)
        }
    }
    func determinQuestionType() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let StarRatingViewController = storyboard.instantiateViewController(withIdentifier: "StarRatingViewController") as! StarRatingViewController
        let ProvidersViewController = storyboard.instantiateViewController(withIdentifier: "ProvidersViewController") as! ProvidersViewController
        let MultiChoiceViewController = storyboard.instantiateViewController(withIdentifier: "MultiChoiceViewController") as! MultiChoiceViewController
        let ShortAnswerViewController = storyboard.instantiateViewController(withIdentifier: "ShortAnswerViewController") as! ShortAnswerViewController
        let EmailQuestionViewController = storyboard.instantiateViewController(withIdentifier: "EmailQuestionViewController") as! EmailQuestionViewController
        let YesNoChoiceViewController = storyboard.instantiateViewController(withIdentifier: "YesNoChoiceViewController") as! YesNoChoiceViewController
        let CommentViewController = storyboard.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
        let NPSRatingViewController = storyboard.instantiateViewController(withIdentifier: "NPSRatingViewController") as! NPSRatingViewController
        
        if ( !surveyQuestionContainer.subviews.isEmpty ) {
            surveyQuestionContainer.subviews[0].removeFromSuperview()
        }
    
        let currentQuestion: Question = deployedSurveyQuestions![ currentSurveyQuestionIndex ]
        
        if ( currentQuestion.type == "star_rating" ) {
            self.addViewControllerAsChildViewController(viewController: StarRatingViewController)
        }
        else if ( currentQuestion.type == "provider" ) {
            self.addViewControllerAsChildViewController(viewController: ProvidersViewController)
        }
        else if ( currentQuestion.type == "multi" ) {
            self.addViewControllerAsChildViewController(viewController: MultiChoiceViewController)
        }
        else if ( currentQuestion.type == "text" ) {
            self.addViewControllerAsChildViewController(viewController: ShortAnswerViewController)
        }
        else if ( currentQuestion.type == "email" ) {
            self.addViewControllerAsChildViewController(viewController: EmailQuestionViewController)
        }
        else if ( currentQuestion.type == "yes_no" ) {
            self.addViewControllerAsChildViewController(viewController: YesNoChoiceViewController)
        }
        else if ( currentQuestion.type == "text_area" ) {
            self.addViewControllerAsChildViewController(viewController: CommentViewController)
        }
        else if ( currentQuestion.type == "nps_rating" ) {
            self.addViewControllerAsChildViewController(viewController: NPSRatingViewController)
        }
        self.questionText.fadeIn()
        self.surveyQuestionContainer.fadeIn()
    }
    
    
    //need to remember where pulled from
    private func addViewControllerAsChildViewController(viewController: UIViewController) {
        // Add Child View Controller
        
        surveyQuestionContainer.viewController()?.addChildViewController(viewController)
        
        // Add Child View as Subview
        
        surveyQuestionContainer.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = surveyQuestionContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    func removeBlur() {
        self.blurEffectView?.removeFromSuperview()
    }
    
    func makeAnswerObjectWithCorrectTypeAndStore() {
        
        
    }
    
    func surveyAnswerCreation(notification:Notification) -> Void {
        
        let currentQuestion: Question = deployedSurveyQuestions![ currentSurveyQuestionIndex ]
        let text: String = currentQuestion.question!
        let id: String = currentQuestion.objectId!
        var selection: AnyObject = {} as AnyObject
        
        if ( currentQuestion.type == "star_rating" ) {
            selection = surveyFloatRatingSelected as AnyObject
        }
        else if ( currentQuestion.type == "provider" ) {
            selection = selectedProvider!
        }
        else if ( currentQuestion.type == "multi" ) {
            selection = multichoiceSelection as AnyObject
        }
        else if ( currentQuestion.type == "text" ) {
            
            if( shortAnswerResponse != nil ) {
                selection = shortAnswerResponse as AnyObject
            }
            else {
                selection = "" as AnyObject
            }
        }
        else if ( currentQuestion.type == "email" ) {
            
            if( emailResponse != nil ) {
                selection = emailResponse as AnyObject
            }
            else {
                selection = "" as AnyObject
            }
        }
        else if ( currentQuestion.type == "yes_no" ) {
            selection = yesNoResponse as AnyObject
        }
        else if ( currentQuestion.type == "text_area" ) {
            if( commentResponse != nil ) {
                selection = commentResponse as AnyObject
            }
            else {
                selection = "" as AnyObject
            }
        }
        else if ( currentQuestion.type == "nps_rating" ) {
            selection = npsRatingNumber as AnyObject
        }
        
        //make answer object and add to answers array then fade in the next button
        let answer: Answer = Answer( questionId: id, text: text, type: currentQuestion.type!, selection: selection )
        surveyAnswers.append( answer )
        
        consoleLineSeparate()
        print( surveyAnswers.count )
        print( surveyAnswers )
        nc.post(name:Notification.Name(rawValue:"nextButtonFadeIn"),
                object: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
