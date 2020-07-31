//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Nivedhitha Parthasarathy on 31/07/20.
//  Copyright © 2020 Nivedhitha Parthasarathy. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblTimeTaken: UILabel!
    
    var score: Int!
    var timeTaken = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblScore.text = "\(score!)/10"
        lblTimeTaken.text = "\(secondsToHoursMinutesSeconds(seconds: Int(timeTaken)))"
        print(timeTaken.asString(style: .positional))
        print(secondsToHoursMinutesSeconds(seconds: Int(timeTaken)))
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (String) {
        return ("\(seconds / 3600):\((seconds % 3600) / 60):\((seconds % 3600) % 60)")
    }
    
    @IBAction func click_OK(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            
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
