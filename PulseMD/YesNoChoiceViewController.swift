//
//  YesNoChoiceViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/11/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class YesNoChoiceViewController: UIViewController {

    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    let yesSel = UIImage(named: "Yes_Selected")
    let noSel = UIImage(named: "No_Selected")
    let yes = UIImage(named: "Yes")
    let no = UIImage(named: "No")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fireOnlyOnce = true
        setupYesNoButtons()
        // Do any additional setup after loading the view.
    }

    @IBAction func yesSelected(_ sender: AnyObject)
    {
        yesNoResponse = "yes"
        
        yesButton.setImage(yesSel, for: UIControlState())
        yesButton.tintColor = self.view.tintColor
        noButton.setImage(no, for: UIControlState())
        
        if(fireOnlyOnce == true)
        {
            fireOnlyOnce = false
            nc.post(name:Notification.Name(rawValue:"surveyAnswerCreation"),
                    object: nil)
        }
        
    }
    @IBAction func noSelected(_ sender: AnyObject)
    {
        yesNoResponse = "no"
        yesButton.setImage(yes, for: UIControlState())
        noButton.setImage(noSel, for: UIControlState())
        noButton.tintColor = self.view.tintColor
        
        if(fireOnlyOnce == true)
        {
            fireOnlyOnce = false
            nc.post(name:Notification.Name(rawValue:"surveyAnswerCreation"),
                    object: nil)
        }
        
    }
    func setupYesNoButtons()
    {
        
        yesButton.setImage(yes, for: UIControlState())
        yesButton.setImage(yesSel, for: [.highlighted, .selected])
        yesButton.tintColor = UIColor.white
        noButton.setImage(no, for: UIControlState())
        noButton.setImage(noSel, for: [.highlighted, .selected])
        noButton.tintColor = UIColor.white
        
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
