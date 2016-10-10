//
//  ViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/8/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit
import SwiftSpinner

class ViewController: UIViewController {

    @IBOutlet weak var questionContainer: UIView!
    @IBOutlet weak var baseQuestionUIView: UIView!
    
    var starsOrProviders: Bool = false
    override func viewWillAppear(_ animated: Bool) {
        //startLoadingScreen( message: "Preparing Your Application" )

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nc.addObserver(forName:Notification.Name(rawValue:"applicationReady"),
                       object:nil, queue:nil,
        
                       using:applicationNowReady)
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        starsOrProviders = !starsOrProviders
//        
//        // Instantiate View Controller
//        let StarRatingViewController = storyboard.instantiateViewController(withIdentifier: "StarRatingViewController") as! StarRatingViewController
//        addViewControllerAsChildViewController(viewController: StarRatingViewController)
//        

    }
    
    @IBAction func nextQuestion(_ sender: AnyObject) {
        //baseQuestionUIView.viewController()?.addChildViewController(StarRatingViewController.)
        nextQuestion()
    }
    func nextQuestion() {
        print ( "who is sender i wonder?" )
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        starsOrProviders = !starsOrProviders
        
        // Instantiate View Controller
        let StarRatingViewController = storyboard.instantiateViewController(withIdentifier: "StarRatingViewController") as! StarRatingViewController
        let ProvidersViewController = storyboard.instantiateViewController(withIdentifier: "ProvidersViewController") as! ProvidersViewController
        
        // Add View Controller as Child View Controller
        if starsOrProviders == true {
            self.addViewControllerAsChildViewController(viewController: StarRatingViewController)
        }
        else {
            self.addViewControllerAsChildViewController(viewController: ProvidersViewController)
        }
    }
    
    private func addViewControllerAsChildViewController(viewController: UIViewController) {
        // Add Child View Controller
        
        
        baseQuestionUIView.viewController()?.addChildViewController(viewController)
        
        // Add Child View as Subview
        
        baseQuestionUIView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = baseQuestionUIView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    
    
    func applicationNowReady(notification:Notification) -> Void {
        //endLoadingScreen()
        print ( "APPLOCATION IS FUCKING READY TO GO YO" )
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

