//
//  PulseMDDataModel.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation

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

//For dev
func consoleLineSeparate() {
    print ( "\n---------------------------------------\n" )
}

//During user taking a survey these will get manipulated
var currentSurveyQuestionIndex: Int!
