//
//  Location.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Parse

class Location: PFObject {
    @NSManaged var identifier: Int
    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var city: String?
    @NSManaged var state: String?
    @NSManaged var zipcode: NSNumber?
    @NSManaged var phone: String?
    @NSManaged var fax: String?
    @NSManaged var locationContact: String?
    
}
extension Location {
    static func fetchLocation(objectId: String) {
        let query = Location.query()!
        query.whereKey("objectId", equalTo: objectId)
        query.findObjectsInBackground {( objects: [PFObject]?, error: Error? ) -> Void in
            
            if error == nil
            {
                if let objects = objects {
                    print( "Got to Location" )
                    let location = objects[0] as! Location
                    deployedLocation = location
                    print( deployedLocation )
                    Provider.fetchProviders( location: location )
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
extension Location: PFSubclassing {
    
    static func parseClassName() -> String {
        return "Location"
    }
    
}


