//
//  StarRatingViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit
import AVFoundation
import Parse
import FloatRatingView

class StarRatingViewController: UIViewController, FloatRatingViewDelegate {
    
    
    //@IBOutlet weak var ratingAnswerView: UIView!
    @IBOutlet var floatRatingView: FloatRatingView!
    
    //let starFull = UIImage(named: "Pulse.StarScreen.FilledStar.png")
    //let starEmpty = UIImage(named: "Pulse.StarScreen.EmptyStar.png")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.floatRatingView.delegate = self
        print ( "IM THE STAR RATING" )
        setupRating()
        // Do any additional setup after loading the view.
    }

    func setupRating() {
        let gestFloat = UITapGestureRecognizer(target: self, action: #selector( StarRatingViewController.floatRatingSelected(_: )))
        
        gestFloat.numberOfTapsRequired = 1
        
        //floatRatingView.addGestureRecognizer(gestFloat)
        
        
//        print ( starEmpty )
//        print ( starFull )
        //print ( self.floatRatingView )
        
//        self.floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
//        self.floatRatingView.maxRating = 5
//        self.floatRatingView.minRating = 0
//        
//        self.floatRatingView.editable = true
//        self.floatRatingView.rating = 0.0
//        self.floatRatingView.emptyImage = UIImage(named: "Pulse.StarScreen.FilledStar.png")
//        self.floatRatingView.fullImage = UIImage(named: "Pulse.StarScreen.EmptyStar.png")
        
    }
    
    func floatRatingSelected(_ recognizier:UITapGestureRecognizer)
    {
        nc.post(name:Notification.Name(rawValue:"nextButtonFadeIn"),
                object: nil)
//        nextButtonToggle = false
//        if(nextButtonToggle == true)
//        {
//            
//            nextButton.fadeIn()
//        }
//        else
//        {
//            nextButtonToggle = true
//            if(fireOnlyOnce)
//            {
//                fireOnlyOnce = false
//                selectedRating = floatRating.rating
//                makeAnswerObjectWithCorrectTypeAndStore()
//            }
//            
//            
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ratingTypeChanged(_ sender: UISegmentedControl) {
        //self.floatRating.halfRatings = sender.selectedSegmentIndex==1
        //self.floatRating.floatRatings = sender.selectedSegmentIndex==2
    }
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
        print( rating )
        //self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        print( rating )
        //self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
