//
//  Provider.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Parse

class Provider: PFObject, PFSubclassing {
    @NSManaged var credentials: String?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var profilePicture: PFFile?
    @NSManaged var specialty: String?
    @NSManaged var position: NSNumber?
    
    static func parseClassName() -> String {
        return "Provider"
    }
    init( objId: String, credentials: String?, position: NSNumber?, firstName: String, lastName: String, specialty: String?, profilePic: PFFile? ) {
        super.init()
        //self.objectId = objId
        
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.specialty = specialty
        self.profilePicture = profilePic
        self.credentials = credentials
    }
    
    override init() {
        super.init()
    }
    
}
extension Provider {
    static func fetchProviders(location: Location) {
        
        let query = Provider.query()!
        query.whereKey("locations", equalTo: location)
        query.addAscendingOrder("position")
        query.findObjectsInBackground {( objects: [PFObject]?, error: Error? ) -> Void in
            
            if error == nil
            {
                
                if let objects = objects {
                    
                    var providers: [Provider] = []
                    
                    for provider in objects as! [Provider] {
                        
                        let objId: String = provider.objectId!
                        let firstName: String = provider["firstName"] as! String
                        let lastName: String = provider["lastName"] as! String
                        let position: NSNumber? = provider["position"] as? NSNumber
                        let specialty: String? = provider["specialty"] as? String
                        let credentials: String? = provider["credentials"] as? String
                        let profilePicture: PFFile? = provider["profilePicture"] as? PFFile
                        
                        let newProvider: Provider = Provider( objId: objId, credentials: credentials, position: position, firstName: firstName, lastName: lastName, specialty: specialty, profilePic: profilePicture )
                        
                        
                        providers.append(newProvider)
                        
                    }
                    
                    surveyProviders = providers
                    
                    nc.post(name:Notification.Name(rawValue:"applicationReady"),
                            object: nil)
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

