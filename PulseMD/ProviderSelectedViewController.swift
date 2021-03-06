//
//  ProviderSelectedViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/22/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class ProviderSelectedViewController: UIViewController, JMSurveyQuestionsPresentationDelegate {

    var JMSdelegate : JMSurveyQuestionsPresentationDelegate?
    var selectedProviderPassedImage : UIImage?
    var selectedProviderFirstName : String!
    var selectedProviderLastName : String!
    var selectedProviderDescription : String?
    
    @IBOutlet weak var providerImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var providerDescription: UITextView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        providerImage.image = selectedProviderPassedImage
        
        let creds = selectedProvider!["credentials"] as! String
        let spec = selectedProvider!["specialty"] as! String
        
        if(creds == "." || creds == "")
        {
            print(selectedProviderLastName)
            lastName!.text = selectedProviderLastName!
        }
        else
        {
            lastName!.text = "\(selectedProviderLastName!), \(creds)"
        }
        if(spec == "." || spec == "")
        {
            providerDescription.text = ""
        }
        else
        {
            providerDescription.text = spec
        }
        print( selectedProviderFirstName )
        firstName!.text = selectedProviderFirstName!

        yesButton.setBackgroundImage(UIImage(named: "small.yes.png"), for: UIControlState())
        noButton.setBackgroundImage(UIImage(named: "small.no.png"), for: UIControlState())
        
    }
    

    @IBAction func yesButtonSelected(_ sender: AnyObject)
    {
        yesButton.setBackgroundImage(UIImage(named: "small.yes.png"), for: UIControlState())
        noButton.setBackgroundImage(UIImage(named: "small.no.png"), for: UIControlState())
        makeAnswerObjectWithCorrectTypeAndStore()
        nc.post(name:Notification.Name(rawValue:"surveyAnswerCreation"),
                object: nil)
        
        nc.post(name:Notification.Name(rawValue:"removeBlur"),
                object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func noButtonSelected(_ sender: AnyObject)
    {
        noButton.setBackgroundImage(UIImage(named: "small.no.png"), for: UIControlState())
        yesButton.setBackgroundImage(UIImage(named: "small.yes.png"), for: UIControlState())
        
        nc.post(name:Notification.Name(rawValue:"removeBlur"),
                object: nil)
        
        self.dismiss(animated: true, completion: nil)
    }
    func makeAnswerObjectWithCorrectTypeAndStore() {
        JMSdelegate!.makeAnswerObjectWithCorrectTypeAndStore()
    }
    func removeBlur() {
        
        nc.post(name:Notification.Name(rawValue:"removeBlur"),
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
