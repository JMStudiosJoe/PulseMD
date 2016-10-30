//
//  ProvidersViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/9/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class ProvidersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate, JMSurveyQuestionsPresentationDelegate {

    @IBOutlet weak var providersList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        popoverPresentationController?.delegate = self
        // Do any additional setup after loading the view.
    }

    //MARK: Providers list type CollectionView code
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (surveyProviders?.count)!
    }
    
    //MARK:Display Provider CollectionView cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! ProviderCollectionViewCell
        let provider: Provider = surveyProviders![ indexPath.row ]
        cell.providerImage.image = surveyProviderImages![ indexPath.row ]
        
        let fname: String = provider.firstName!
        let lname: String = provider.lastName!
        let creds: String = provider.credentials!
        let  spec: String = provider.specialty!
        
        if(fname == "." || fname.isEmpty || fname == "nil") {
            cell.providerName.text = ""
        }
        else {
            cell.providerName.text = "\(fname)"
        }
        if(lname == "." || lname.isEmpty || lname == "nil") {
            cell.lastNameCredentials.text = ""
            
        }
        else {
            if(creds == "." || creds.isEmpty || creds == "nil") {
                cell.lastNameCredentials.text = "\(lname)"
            }
            else {
                cell.lastNameCredentials.text = "\(lname), \(creds)"
            }
            
        }
        if(spec == "." || spec.isEmpty || spec == "nil") {
            cell.specialty.text = ""
        }
        else {
            cell.specialty.text = "\(spec)"
        }
        
        cell.providerName.textColor = UIColor.black
        return cell
    }
    //MARK:DID SELECTED Provider CollectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        selectedProvider = surveyProviders![indexPath.row]
//        
//        self.view.addSubview(blurEffectView!)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProviderSelectedViewController") as! ProviderSelectedViewController
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 500, height: 320)
        vc.selectedProviderPassedImage = surveyProviderImages![(indexPath as NSIndexPath).row]
        vc.JMSdelegate = self
        let fname = String(describing: selectedProvider!["firstName"])
        let lname = String(describing: selectedProvider!["lastName"])
        if(fname == "." || fname.isEmpty)
        {
            vc.selectedProviderFirstName = " "
        }
        else
        {
            vc.selectedProviderFirstName = fname
        }
        if(lname == "." || lname.isEmpty)
        {
            vc.selectedProviderLastName = " "
        }
        else
        {
            vc.selectedProviderLastName = lname
        }
        
        
        if let presentationController = vc.popoverPresentationController {
            presentationController.delegate = self
            presentationController.permittedArrowDirections = .unknown
            presentationController.sourceView?.layer.cornerRadius = 0
            //presentationController.containerView?.layer.cornerRadius = 0
            presentationController.sourceView = self.view
            presentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY+100,width: 0,height: 0)
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! ProviderCollectionViewCell
        
        //cell.providerName.textColor = UIColor.black
        cell.layer.borderWidth = 0
        
    }
    
    func makeAnswerObjectWithCorrectTypeAndStore() {
        //JMSdelegate!.makeAnswerObjectWithCorrectTypeAndStore()
    }
    func removeBlur() {
        //JMSdelegate!.removeBlur()
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        print("prepare for presentation")
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print("did dismiss")
        //removeBlur()
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        print("should dismiss")
        return true
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .none
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
