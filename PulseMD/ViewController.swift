//
//  ViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/8/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit
import SwiftSpinner

class ViewController: UIViewController {

    @IBOutlet weak var baseQuestionUIView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        //startLoadingScreen( message: "Preparing Your Application" )

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nc.addObserver(forName:Notification.Name(rawValue:"applicationReady"),
                       object:nil, queue:nil,
                       using:applicationNowReady)
            }

    func applicationNowReady(notification:Notification) -> Void {
        //endLoadingScreen()
        print ( "APPLOCATION IS FUCKING READY TO GO YO" )
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

