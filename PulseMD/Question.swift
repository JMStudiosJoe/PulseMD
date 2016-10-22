//
//  Question.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Parse

class Question: PFObject, PFSubclassing {
    @NSManaged public var position: NSNumber?
    @NSManaged var question: String?
    @NSManaged var type: String?
    @NSManaged var multi: [String]?
    @NSManaged var choice: [Bool]?
    @NSManaged var alert_threshold: NSNumber?
    @NSManaged var rating: NSNumber? //star rating
    
    static func parseClassName() -> String {
        return "Question"
    }
    override class func initialize() {
        
    }
    init( objectId: String, question: String, position: NSNumber, type: String, multi: [String]?, choice: [Bool]? ) {
        super.init()
        self.objectId = objectId
        self.question = question
        self.position = position
        self.type = type
        self.multi = multi
        self.choice = choice
        
    }
    
    override init() {
        super.init()
    }
    
}

extension Question {
    
    static func fetchSurveyQuestions( rel: PFRelation<PFObject> ) {
        
        var surveyQuestions: [Question] = []
        let query = rel.query()
        
        query.order(byAscending: "position")
        
        query.findObjectsInBackground{(objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                
                for question in objects! {
                    
                    let objcId = question.objectId!
                    let questionText: String = question["question"] as! String
                    let position: NSNumber = question["position"] as! NSNumber
                    let multi: [String]? = question["multi"] as? [String]
                    let type: String = question["type"] as! String
                    
                    let choice: [Bool]? = question["choice"] as? [Bool]
                    
                    let newQuestion = Question( objectId: objcId,
                        question: questionText,
                        position: position,
                        type: type,
                        multi: multi,
                        choice: choice )

                    surveyQuestions.append(newQuestion)
                }
                deployedSurveyQuestions = surveyQuestions
            }
            else {
                // Log details of the failure
                print("Error in getting survey questions: \(error!)")
            }
        }
    }
}




