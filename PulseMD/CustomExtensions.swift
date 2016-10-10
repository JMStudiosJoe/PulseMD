//
//  CustomExtensions.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import Foundation
import SwiftSpinner

extension UIView
{
    
    func fadeIn() {
        // Move our fade out code from earlier
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
            
            }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
    
    func slideOut()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations:
            {
                self.frame.origin.x -= self.frame.width*2
                
            }, completion: {finished in
                
                self.alpha = 0.85
                
                self.frame.origin.x = -self.frame.origin.x
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations:
                    {
                        self.frame.origin.x = 10
                        self.alpha = 0.85
                    }, completion: nil)
                
        })
    }
    func startLoadingScreen()
    {
        SwiftSpinner.show("Loading Please Wait")
    }
    func endLoadingScreen()
    {
        SwiftSpinner.hide()
    }
    func prefersStatusBarHidden() -> Bool {
        return true;
    }
}
extension Date {
    public static func ISOStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //let timeZoneAbri : String = NSTimeZone.localTimeZone().abbreviation ?? ""
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: date) + "Z"
    }
    
    public static func dateFromISOString(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)!
    }
    
}
