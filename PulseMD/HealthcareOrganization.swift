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
    
    
    static func fetchHealthcareOrg(objectId: String) {
        let query = HealthcareOrganization.query()!
        query.whereKey("objectId", equalTo: objectId)
        query.findObjectsInBackground {( objects: [PFObject]?, error: Error? ) -> Void in
            
            if error == nil
            {
                if let objects = objects {
                    print( "Got to HealthcareOrganization" )
                    print( objects )
                    let org = objects[0] as! HealthcareOrganization
                    deployedOrganization = org
                    print( deployedLocation )
                    
                }
            }
            else
            {
                // Log details of the failure
                print("Error: \(error!)")
            }
        }
    }

    
}

