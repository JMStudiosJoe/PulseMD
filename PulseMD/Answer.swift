//
//  Answer.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/30/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Parse

class Answer: NSObject {
    @NSManaged var id: String
    @NSManaged var text: String
    @NSManaged var type: String
    @NSManaged var selection: AnyObject?
    
    init( id: String, text: String, type: String, selection: AnyObject ) {
        super.init()
        self.id = id
        self.text = text
        self.type = type
        self.selection = selection
    }
    
    override init() {
        super.init()
    }
}
