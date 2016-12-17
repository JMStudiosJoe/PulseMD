//
//  EndSurveyViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/12/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit
import Parse

class EndSurveyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("THANKS!!!")
        delay(3.6) { 
            self.performSegue(withIdentifier: "backToMain", sender: self)
        }
        // Do any additional setup after loading the view.
    }
    func uploadResponse() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func makeResponseAndSave() {
        let locationName = deployedLocation?.name!
        let locationIdentifier = deployedLocation?.identifier!
        let locationId = deployedLocation?.objectId
        
        
        let cacheLocationObject : [String: AnyObject] = ["name": locationName as AnyObject,
                                                         "identifier": locationIdentifier as AnyObject,
                                                         "id" : locationId as AnyObject,
                                                         "createdAt": deployedLocation!.createdAt as AnyObject]
        
        let cachedSurveyObject : [String:AnyObject] = ["name": deployedSurvey?.name as AnyObject,
                                                       "id": deployedSurvey?.objectId as AnyObject,
                                                       "identifier": deployedSurvey?.identifier as AnyObject,
                                                       "createdAt": deployedSurvey?.createdAt as AnyObject]
//        
//        let cachedOrgObject : [String : AnyObject] = ["name": orgName,
//                                                      "primaryContact":orgPrimaryContact,
//                                                      "id":orgId,
//                                                      "createdAt": healthcareOrg.createdAt as AnyObject]
        
        
        let response = PFObject(className:"Response")
    }
    /*
     let cacheLocationObject : [String: AnyObject] = ["name": locationName,
     "identifier": locationIdentifier,
     "id" : locationId,
     "createdAt": surveyLocation.createdAt as AnyObject]
     
     let cachedSurveyObject : [String:AnyObject] = ["name": surveyName,
     "id": surveyId,
     "identifier": surveyIdentifier,
     "createdAt": selectedSurvey.createdAt as AnyObject]
     let cachedOrgObject : [String : AnyObject] = ["name": orgName,
     "primaryContact":orgPrimaryContact,
     "id":orgId,
     "createdAt": healthcareOrg.createdAt as AnyObject]
     response["cachedLocationObject"] = cacheLocationObject
     response["cachedSurveyObject"] = cachedSurveyObject
     response["answerObjects"] = userAnswerObjects
     response["cachedOrgObject"] = cachedOrgObject
     
     let date = Date.ISOStringFromDate(Date())
     
     let dateObject = Date.dateFromISOString(date)
     response["uploadedAt"] = dateObject
     /////////////////////////
     /////////////////////////
     
     let joeyIsTestingData = false
     if(joeyIsTestingData)
     {
     response["testData"] = true
     }
     else
     {
     response["testData"] = false
     }
     /////////////////////
     /////////////////////
     
     print(response)
     print("\(surveyQuestions.count)   ==   \(userAnswerObjects.count)")
     if(reachability?.isReachable)!
     {
     
     response.saveInBackground{(
     success: Bool, error: Error?) -> Void in
     if (success)
     {
     self.performSegue(withIdentifier: "backToMain", sender: self)
     }
     else
     {
     print(error)
     response.pinInBackground()
     self.performSegue(withIdentifier: "backToMain", sender: self)
     // There was a problem, check error.description
     }
     }
     }
     else
     {
     print("\n\nsave in local store")
     response.pinInBackground()
     self.performSegue(withIdentifier: "backToMain", sender: self)
     }
     }
     catch is Error{
     
     }

 */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
