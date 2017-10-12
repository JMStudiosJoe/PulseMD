//
//  Deployment.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Parse

class Deployment: PFObject {
    @NSManaged var identifier: String?
    @NSManaged var name: String?
    @NSManaged var thankYouMessage: String?
    @NSManaged var updated: CFBoolean?
    @NSManaged var autoReset: CFBoolean?
    
}
extension Deployment {
    static func fetchDeployment() {
        let query = Deployment.query()!
        //query.whereKey("deviceName", equalTo: UIDevice.current.name)
        query.whereKey("deviceName", equalTo: "iPad")
        query.getFirstObjectInBackground {(object, error) in
            if let error = error {
                print ( error )
            }
            else if let object = object {
                print(";;;")
                print(object["healthcare"])
                //let orgObject: HealthcareOrganization = object["healthcare"] as! HealthcareOrganization
                
                let surveyObject: Survey = object["survey"] as! Survey
                let locationObject: Location = object["location"] as! Location
                print( ";;; Got to Deployment" )
                Survey.fetchSurvey( objectId: surveyObject.objectId! )
                Location.fetchLocation( objectId: locationObject.objectId! )
                
            }
        }
    }
}
extension Deployment: PFSubclassing {
    
    static func parseClassName() -> String {
        return "Deployment"
    }
    
}


