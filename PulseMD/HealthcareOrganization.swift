//
//  HealthcareOrganization.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/30/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Parse

class HealthcareOrganization: PFObject, PFSubclassing {
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var primaryContact: String?
    
    static func parseClassName() -> String {
        return "HealthcareOrganization"
    }
    
}
extension HealthcareOrganization {
//    static func fetchLocation(objectId: String) {
//        let query = HealthcareOrganization.query()!
//        query.whereKey("objectId", equalTo: objectId)
//        query.findObjectsInBackground {( objects: [PFObject]?, error: Error? ) -> Void in
//            
//            if error == nil
//            {
//                if let objects = objects {
//                    print( "Got to HealthcareOrganization" )
//                    let location = objects[0] as! Location
//                    deployedLocation = location
//                    print( deployedLocation )
//                    Provider.fetchProviders( location: location )
//                }
//            }
//            else
//            {
//                // Log details of the failure
//                print("Error: \(error!)")
//            }
//        }
//    }
}
