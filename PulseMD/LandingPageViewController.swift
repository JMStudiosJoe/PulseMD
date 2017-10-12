//
//  LandingPageViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/11/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    @IBOutlet weak var locationDisplay: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var surveyImage: UIImageView!
    @IBOutlet weak var surveyTitle: UILabel!
    @IBOutlet weak var surveyMainInfo: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImage.image = UIImage(named: "background.without the white.png")
        print( deployedSurvey )
        surveyTitle.text = deployedSurvey?.name!
        locationDisplay.text = deployedLocation?.name!
        self.navigationController?.navigationBar.isHidden = true
        self.prefersStatusBarHidden
        do {
            surveyImage.image = ( try UIImage( data: (deployedSurvey!.logo?.getData())! ) )
        }
        catch _ {
            print("Error getting survey image")
        }
        surveyMainInfo.layer.cornerRadius = 10
        surveyMainInfo.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    @IBAction func startSurvey(_ sender: AnyObject) {
        print("STARTING SURVEY")
        performSegue(withIdentifier: "startSurvey", sender: self)
    }
    @IBAction func backToMain(_ segue: UIStoryboardSegue, sender: AnyObject!)
    {
        self.navigationController?.isNavigationBarHidden = true
        
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
