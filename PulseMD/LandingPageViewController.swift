//
//  LandingPageViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/11/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func startSurvey(_ sender: AnyObject) {
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
