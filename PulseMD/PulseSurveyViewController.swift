//
//  PulseSurveyViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/11/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class PulseSurveyViewController: UIViewController {

    //question container
    @IBOutlet weak var surveyQuestionContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startSurvey()
        // Do any additional setup after loading the view.
    }

    func startSurvey() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        currentSurveyQuestionIndex = 0
        
        // Instantiate View Controller
        let StarRatingViewController = storyboard.instantiateViewController(withIdentifier: "StarRatingViewController") as! StarRatingViewController
        addViewControllerAsChildViewController(viewController: StarRatingViewController)
        
    }
    
    @IBAction func nextQuestion(_ sender: AnyObject) {
        incrementSurveyIndex()
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
