//
//  NPSRatingViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/12/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class NPSRatingViewController: UIViewController {

    @IBOutlet var npsButtonRatings : [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNPSButtonRating()
        // Do any additional setup after loading the view.
    }

    
    func setupNPSButtonRating()
    {
        for i in stride(from: 0, to: 11, by: 1)
        {
            let gest = UITapGestureRecognizer(target: self, action: #selector(NPSRatingViewController.npsRatingSelected(_:)))
            gest.numberOfTapsRequired = 1
            npsButtonRatings[i].addGestureRecognizer(gest)
            npsButtonRatings[i].tintColor = UIColor.white
            npsButtonRatings[i].setImage(UIImage(named: "\(i).png"), for: UIControlState())
            npsButtonRatings[i].setImage(UIImage(named: "\(i).blue.png"), for: UIControlState.highlighted)
            npsButtonRatings[i].setImage(UIImage(named: "\(i).blue.png"), for: UIControlState.selected)
        }
    }
    func npsRatingSelected(_ recognizier:UITapGestureRecognizer)
    {
        
        npsRatingNumber = Int(recognizier.view!.restorationIdentifier!)
        npsButtonRatings[npsRatingNumber].tintColor = self.view.tintColor
        //makeAnswerObjectWithCorrectTypeAndStore()
        nc.post(name:Notification.Name(rawValue:"surveyAnswerCreation"),
                object: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
