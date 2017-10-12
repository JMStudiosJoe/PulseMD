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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var surveyQuestionContainer: UIView!
    @IBOutlet weak var nextButton: UIButton!   //just next is a reserve word or something
    @IBOutlet weak var questionText: UITextView!
    
    var fireOnce: Bool!
    
    @IBOutlet weak var progressBar: UIProgressView!
    var blurEffect : UIBlurEffect?
    var blurEffectView : UIVisualEffectView?
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundImage.image = UIImage(named: "background.without the white.png")
        let backgroundBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let backgroundBlurView = UIVisualEffectView(effect: backgroundBlurEffect)
        backgroundBlurView.frame = CGRect(x: 0, y: 0, width: 3000, height: 3000)
        backgroundImage.addSubview(backgroundBlurView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fireOnce = true
        
        //self.navigationController?.isNavigationBarHidden = true
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        nc.addObserver(forName:Notification.Name(rawValue:"nextButtonFadeIn"),
                       object:nil, queue:nil,
                       using:nextButtonFadeIn)
        nc.addObserver(forName:Notification.Name(rawValue:"nextButtonFadeOut"),
                       object:nil, queue:nil,
                       using:nextButtonFadeOut)
        nc.addObserver(forName:Notification.Name(rawValue:"surveyAnswerCreation"),
                       object:nil, queue:nil,
                       using:surveyAnswerCreation)
        nc.addObserver(forName:Notification.Name(rawValue:"addBlur"),
                       object:nil, queue:nil,
                       using:addBlur)
        nc.addObserver(forName:Notification.Name(rawValue:"removeBlur"),
                       object:nil, queue:nil,
                       using:removeBlur)
        
        self.navigationController?.isNavigationBarHidden = true
        self.prefersStatusBarHidden

        startSurvey()
        //surveyAnswerCreation
        // Do any additional setup after loading the view.
    }
    func setProgressBar()
    {
        let f1 = Float( currentSurveyQuestionIndex )
        let f2 = Float( deployedSurveyQuestions!.count )
        
        let progress = f1/f2
        progressBar.setProgress(progress, animated: true)
    }
    //MARK: Next button event handlers for when user selects an answer to fade in the next button and fade it out
    func nextButtonFadeIn(notification:Notification) -> Void {
        fireOnce = true
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
        
        if( fireOnce == true ) {
            fireOnce = false
            self.surveyQuestionContainer.slideOut()
            self.surveyQuestionContainer.fadeOut()
            
            self.questionText.fadeOut()
            
            nc.post(name:Notification.Name(rawValue:"nextButtonFadeOut"),
                    object: nil)
            if( deployedSurveyQuestions?[currentSurveyQuestionIndex].type == "text" ||
                deployedSurveyQuestions?[currentSurveyQuestionIndex].type == "text_area" ||
                deployedSurveyQuestions?[currentSurveyQuestionIndex].type == "email") {
                
                
                nc.post(name:Notification.Name(rawValue:"surveyAnswerCreation"),
                        object: nil)
            }
            
            incrementSurveyIndex()
            
            self.questionText.text = deployedSurveyQuestions?[currentSurveyQuestionIndex].question
        }

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
        
        setProgressBar()
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
        
        print(currentQuestion.type)
        
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
        else if ( currentQuestion.type == "text_email" ) {
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
        
        self.questionText.text = currentQuestion.question
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
    
    func addBlur(notification:Notification) -> Void {
        print("adding blur view")
        self.view.addSubview(blurEffectView!)
    }
    func removeBlur(notification:Notification) -> Void {
        print("removing blur view")
        self.blurEffectView!.removeFromSuperview()
    }
    
    func removeBlur() {
        
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
        else if ( currentQuestion.type == "text_email" ) {
            
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
