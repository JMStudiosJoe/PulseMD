//
//  PulseMDDataModel.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import SwiftSpinner

var deployedSurveyID: NSNumber?
var deployedSurvey: Survey?
var deployedSurveyQuestions: [Question]?
var deployedLocation: Location?
var surveyProviders: [Provider]?

var applicationReady: Bool?

var event: UIEvent?
let nc = NotificationCenter.default


func consoleLineSeparate() {
    print ( "\n---------------------------------------\n" )
}

func startLoadingScreen(message: String)
{
    SwiftSpinner.show(message)
}
func endLoadingScreen()
{
    SwiftSpinner.hide()
}
