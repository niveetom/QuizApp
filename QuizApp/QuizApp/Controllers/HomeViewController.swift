//
//  HomeViewController.swift
//  QuizApp
//
//  Created by Nivedhitha Parthasarathy on 31/07/20.
//  Copyright © 2020 Nivedhitha Parthasarathy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var quizTV: UITableView!
    @IBOutlet weak var createQuizBarItem: UIBarButtonItem!
    
    let user = UserDefaults.standard.object(forKey: "user") as! String
    var arrQuiz = ["Quiz 1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard user == "SchoolStaff" else{
            self.navigationItem.rightBarButtonItem = nil
            return
        }
        self.navigationItem.rightBarButtonItem = createQuizBarItem
    }
    
    @IBAction func create_Quiz(_ sender: Any) {
        arrQuiz.insert("Quiz \(arrQuiz.count+1)", at: arrQuiz.count)
        quizTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQuiz.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell") as! QuizCell
        cell.lblQuizName.text = arrQuiz[indexPath.row]
        cell.btnStartQuiz.tag = indexPath.row
        cell.btnStartQuiz.addTarget(self, action: #selector(click_StartQuiz(_ :)), for: .touchUpInside)
        guard user == "SchoolStaff" else{
            cell.btnStartQuiz.isHidden = false
            return cell
        }
        cell.btnStartQuiz.isHidden = true
        return cell
    }
    
    @objc func click_StartQuiz(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizVC") as? QuizViewController {
            vc.navTitle = arrQuiz[sender.tag]
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBAction func click_LogOut(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to LogOut?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
            UserDefaults.standard.set(false, forKey: "status")
            Switcher.updateRootVC()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
