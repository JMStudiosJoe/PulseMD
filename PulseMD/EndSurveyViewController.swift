//
//  EndSurveyViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/12/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class EndSurveyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("THANKS!!!")
        delay(3.6) { 
            self.performSegue(withIdentifier: "backToMain", sender: self)
        }
        // Do any additional setup after loading the view.
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
