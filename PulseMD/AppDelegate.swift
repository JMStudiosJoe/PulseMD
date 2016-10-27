//
//  AppDelegate.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/8/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit
import Parse
import IQKeyboardManagerSwift
import ReachabilitySwift

let APP_KEY = "ed8289d2-2aea-4764-ab05-6779733fa19d"
let TENNANT_ID = "62c7137b-8c89-48e3-8317-cd3549d3f4e8"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MokiManageDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Parse.enableLocalDatastore()
        IQKeyboardManager.sharedManager().enable = true
        // Initialize Parse.
        surveyProviderImages = []
        let err: NSErrorPointer = nil
        MokiManage.sharedManager().delegate = self
        //MokiManage.sharedManager().initialize(withApiKey: APP_KEY, launchingOptions: launchOptions, enableASM: true, enableAEM: true, asmSettingsFileName: "SettingsSchema.json", error: nil)
        
        
        //MokiManage.sharedManager().initialize(withApiKey: APP_KEY, launchingOptions: launchOptions, error: err)
        
        Parse.setApplicationId("KPiWhoD68L6zYIRHEBnfebYlopbvzc64dd2wzENa",
                               clientKey: "1pjkH1AsWjCvf2st0SQB5MjLb5sMuYmNxMnKigRd")


        configureParse()
        Deployment.fetchDeployment()
        
        
        return true
    }

    func configureParse() {
        Survey.registerSubclass()
        Deployment.registerSubclass()
        Question.registerSubclass()
        Provider.registerSubclass()
        Location.registerSubclass()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        MokiManage.sharedManager().didReceiveRemoteNotification(userInfo)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print(error)
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        
        MokiManage.sharedManager().setApnsToken(deviceToken)
        MokiManage.sharedManager().silentlyRegisterDevice(TENNANT_ID)
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

