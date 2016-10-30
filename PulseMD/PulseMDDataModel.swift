//
//  PulseMDDataModel.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Reachability

//For ready state of application for customer
var applicationReady: Bool?
var event: UIEvent?
let nc = NotificationCenter.default

//First variables initialized for survey
var deployedSurveyID: NSNumber?
var deployedSurvey: Survey?
var deployedSurveyQuestions: [Question]?
var deployedLocation: Location?
var surveyProviders: [Provider]?
var surveyProviderImages: [UIImage]?
var selectedProvider: Provider?

func delay(_ delay:Double, closure:@escaping ()->())// http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
{
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

//For dev
func consoleLineSeparate() {
    print ( "\n---------------------------------------\n" )
}

func checkInternetConnection() -> Bool
{
    do {
        let reachability = Reachability()
        if(reachability.isReachable())
        {
            return true
        }
        else
        {
            return false
        }
    }
}

//During user taking a survey these will get manipulated
var currentSurveyQuestionIndex: Int!
var surveyFloatRatingSelected: Float!
