//
//  SurveyAnswer.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/30/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Parse

class Response: PFObject, PFSubclassing {
    @NSManaged var cacheLocation: Location
    @NSManaged var cachedSurvey: Survey?
    @NSManaged var cachedOrganization: HealthcareOrganization?
    @NSManaged var surveyAnswers: [Answer]?
    
    @NSManaged var uploatedAt: Date?
    
    static func parseClassName() -> String {
        return "Response"
    }
    init( objId: String, cacheLocation: Location, cachedSurvey: Survey, cachedOrganization: HealthcareOrganization, responseAnswers: [Answer] ) {
        super.init()
        self.cacheLocation = cacheLocation
        self.cachedSurvey = cachedSurvey
        self.cachedOrganization = cachedOrganization
        self.surveyAnswers = responseAnswers
       
        
       
    }
    
    override init() {
        super.init()
    }
    
}
extension Response {
    static func saveResponse() {
        
        let query = Response.query()!
        
        
        
        
    }
}
