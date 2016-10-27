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
    
    var blurEffectView : UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startSurvey()
        nc.addObserver(forName:Notification.Name(rawValue:"nextButtonFadeIn"),
                       object:nil, queue:nil,
                       
                       using:nextButtonFadeIn)
        nc.addObserver(forName:Notification.Name(rawValue:"nextButtonFadeOut"),
                       object:nil, queue:nil,
                       
                       using:nextButtonFadeOut)

        // Do any additional setup after loading the view.
    }
    
    //MARK: Next button event handlers for when user selects an answer to fade in the next button and fade it out
    func nextButtonFadeIn(notification:Notification) -> Void {
        print ( "Fadein the next button" )
        //nextButton.fadeIn()
        
    }
    
    func nextButtonFadeOut(notification:Notification) -> Void {
        print ( "Fadeout the next button" )
        //nextButton.fadeOut()
        
    }
    //MARK: end next button
    
    func startSurvey() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        currentSurveyQuestionIndex = 0
        
        // Instantiate View Controller
        let StarRatingViewController = storyboard.instantiateViewController(withIdentifier: "StarRatingViewController") as! StarRatingViewController
        addViewControllerAsChildViewController(viewController: StarRatingViewController)
        determinQuestionType()
        
    }
    
    @IBAction func nextQuestion(_ sender: AnyObject) {
        incrementSurveyIndex()
        nc.post(name:Notification.Name(rawValue:"nextButtonFadeOut"),
                object: nil)

    }
    
    @IBAction func backQuestion(_ sender: AnyObject) {
        decrementSurveyIndex()
    }
    
    func decrementSurveyIndex() {
        if ( currentSurveyQuestionIndex < (deployedSurveyQuestions?.count)! && currentSurveyQuestionIndex > 0 ) {
            
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
        
        print ( currentSurveyQuestionIndex )
        if ( !surveyQuestionContainer.subviews.isEmpty ) {
            surveyQuestionContainer.subviews[0].removeFromSuperview()
        }
        
        let currentQuestion: Question = deployedSurveyQuestions![ currentSurveyQuestionIndex ]
        consoleLineSeparate()
        print( currentQuestion.type )
        consoleLineSeparate()
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
