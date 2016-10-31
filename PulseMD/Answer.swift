//
//  Answer.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/30/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import Parse

class Answer: PFObject, PFSubclassing {
    @NSManaged var questionId: String
    @NSManaged var text: String
    @NSManaged var type: String
    @NSManaged var selection: AnyObject?
    
    init( questionId: String, text: String, type: String, selection: AnyObject ) {
        super.init()
        
        self.questionId = questionId // need to tell florida ross about this change, tis also another parse class addition possibly
        self.text = text
        self.type = type
        self.selection = selection
    }
    static func parseClassName() -> String {
        return "Answer"
    }
    override class func initialize() {
        
    }
    
    override init() {
        super.init()
    }
}
