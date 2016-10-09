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
        print ( "do a bunch of self stuff?" )
    
        //self.registerSubclass()
    }
    init( question: String, position: NSNumber, type: String ) {
        super.init()
        self.question = question
        self.position = position
        self.type = type
        
    }
    
    override init() {
        super.init()
    }
    
}

extension Question {
    static func fetchSurveyQuestions( rel: PFRelation<PFObject> ) {
        let query = rel.query()
        query.order(byAscending: "position")
        query.findObjectsInBackground{(objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                for question in objects! {
                    
                    let newQuestion = Question(question: question["question"] as! String, position: question["position"] as! NSNumber, type: question["type"] as! String)
                    
                    consoleLineSeparate()
                    print ( newQuestion )
                    
                }
                //surveyQuestions = objects
            }
            else {
                // Log details of the failure
                print("Error in getting survey questions: \(error!)")
            }
        }
    }
}




