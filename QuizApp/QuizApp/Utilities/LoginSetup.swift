//
//  LoginSetup.swift
//  QuizApp
//
//  Created by Nivedhitha Parthasarathy on 31/07/20.
//  Copyright © 2020 Nivedhitha Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        if(status == true){
            
            let mainViewController = UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
            
            //rootVC = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
            rootVC = nvc
            
            rootVC?.automaticallyAdjustsScrollViewInsets = true
            //        slideMenuController.delegate = mainViewController as! SlideMenuControllerDelegate
            
        }else{
            let nvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            rootVC = UINavigationController(rootViewController: nvc)
            
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}

