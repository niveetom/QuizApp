//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Nivedhitha Parthasarathy on 31/07/20.
//  Copyright © 2020 Nivedhitha Parthasarathy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTypeView: UIStackView!
    @IBOutlet weak var loginView: UIStackView!
    @IBOutlet weak var txtUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.isHidden = true
        loginTypeView.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.addLineToView(view: txtUserName, position:.LINE_POSITION_BOTTOM, color: #colorLiteral(red: 0.968627451, green: 0.6588235294, blue: 0.1882352941, alpha: 1), width: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func login_asStudent(_ sender: Any) {
        loginView.isHidden = false
        loginTypeView.isHidden = true
        txtUserName.placeholder = "Student UserName"
    }
    
    @IBAction func login_asSchoolStaff(_ sender: Any) {
        UserDefaults.standard.set("SchoolStaff", forKey: "user")
        UserDefaults.standard.set(true, forKey: "status")
        Switcher.updateRootVC()
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBAction func click_login(_ sender: Any) {
        let lUserName = txtUserName.text!
        guard !(lUserName.isEmpty) else{
            let alert = UIAlertController(title: "Warning", message: "Enter Student UserName", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return
        }
        UserDefaults.standard.set(lUserName, forKey: "user")
        UserDefaults.standard.set(true, forKey: "status")
        Switcher.updateRootVC()
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    enum LINE_POSITION {
        case LINE_POSITION_TOP
        case LINE_POSITION_BOTTOM
    }
    
    func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
