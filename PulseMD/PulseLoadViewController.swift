//
//  ViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/8/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit
import SwiftSpinner

class PulseLoadViewController: UIViewController {

    //@IBOutlet weak var questionContainer: UIView!
    //@IBOutlet weak var baseQuestionUIView: UIView!
    
    @IBOutlet weak var deviceName: UILabel!
    var starsOrProviders: Bool = false
    override func viewWillAppear(_ animated: Bool) {
        //startLoadingScreen( message: "Preparing Your Application" )

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.prefersStatusBarHidden
        nc.addObserver(forName:Notification.Name(rawValue:"applicationReady"),
                       object:nil, queue:nil,
        
                       using:applicationNowReady)
        deviceName.text = "\( UIDevice.current.name )"
        
    }
    
    func applicationNowReady(notification:Notification) -> Void {
        //endLoadingScreen()
        print ("APPLICATION IS READY")
        performSegue(withIdentifier: "landingPage", sender: self)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

