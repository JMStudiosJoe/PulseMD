//
//  Survey.swift
//  
//
//  Created by Joseph Richardson on 10/9/16.
//
//

import Foundation
import Parse

class Survey: PFObject {
    @NSManaged var identifier: String?
    @NSManaged var name: String?
    @NSManaged var thankYouMessage: String?
    @NSManaged var updated: CFBoolean?
    @NSManaged var autoReset: CFBoolean?
    @NSManaged var nextButtonToggle: CFBoolean?
    @NSManaged var logo: PFFile?
    @NSManaged var questions: PFRelation<PFObject>?// needs to be <Question>?
    @NSManaged var surveyQuestion: [Question]?// needs to be <Question>?
    @NSManaged var questionTypes: [String]?// needs to be <Question>?
    
}
extension Survey {
    static func fetchSurvey( objectId: String ) {
        
        let query = Survey.query()!
        query.whereKey( "objectId", equalTo: objectId )
        query.getFirstObjectInBackground {( object, error ) in
            
            if let error = error {
                print ( error )
            }
            else if let object = object {
                
                let relation: PFRelation<PFObject> = object["questions"] as! PFRelation<PFObject>
                Question.fetchSurveyQuestions( rel: relation )
            }
        }
    }
}
extension Survey: PFSubclassing {
    
    static func parseClassName() -> String {
        return "Survey"
    }
}


