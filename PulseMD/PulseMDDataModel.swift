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
var deployedLocation: Location!
var deployedOrganization: HealthcareOrganization!
var surveyProviders: [Provider]?
var surveyProviderImages: [UIImage]?


func delay(_ delay:Double, closure:@escaping ()->())// http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
{
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

//For dev
func consoleLineSeparate() {
    print ( "\n---------------------------------------\n" )
}
let reachability = Reachability()
func checkInternetConnection() -> Bool
{
    do {
        
        print( reachability )
        consoleLineSeparate()
        print( reachability.isReachable )
        consoleLineSeparate()
        print( reachability.isReachable())
        if reachability.isReachable() {
            return true
        }
        else {
            return false
        }
    }
}

//During user taking a survey these will get manipulated
var fireOnlyOnce: Bool!
var currentSurveyQuestionIndex: Int!
var selectedProvider: Provider?             //Provider question type
var surveyFloatRatingSelected: Float!       //Float rating question type
var npsRatingNumber : NSInteger!            //NPS rating answer type
var multiChoiceAvalableAnswers: [String]!   //Multichoice
var multichoiceSelection: String!
var yesNoResponse: String!
var commentResponse : String!
var emailResponse : String!
var shortAnswerResponse : String!

var surveyAnswers: [Answer]!
