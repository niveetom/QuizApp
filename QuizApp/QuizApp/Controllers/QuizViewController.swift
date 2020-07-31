//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Nivedhitha Parthasarathy on 31/07/20.
//  Copyright © 2020 Nivedhitha Parthasarathy. All rights reserved.
//

import UIKit
var queNum = 1
var score = 0



class QuizViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblQueNum: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var multipleChoiceTV: UITableView!
    
    var navTitle: String!
    var correctAnswer: String!
    var arrQuizQA = [Results]()
    var arrMultipleChoice = [String]()
    var selectedAnswer: String!
    var arrRecord = [String: String]()
    let start = DispatchTime.now()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = navTitle
        
        getQuesAns()
    }
    
    func getQuesAns(){
        if let url = URL(string: "https://next.json-generator.com/api/json/get/Nk4e9P2lY") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    
                    do {
                        let quiz = try JSONDecoder().decode(Quiz.self, from: data)
                        self.arrQuizQA = quiz.results!
                        if self.arrQuizQA.count > 0{
                            DispatchQueue.main.async {
                                self.lblQuestion.text = self.arrQuizQA[queNum].question
                                self.arrMultipleChoice = self.arrQuizQA[queNum].incorrect_answers!
                                self.correctAnswer = self.arrQuizQA[queNum].correct_answer
                            self.arrMultipleChoice.insert(self.arrQuizQA[queNum].correct_answer!, at: self.arrMultipleChoice.count)
                                self.arrMultipleChoice.shuffle()
                                self.lblQueNum.text = "Question \(queNum)/10"
                                self.multipleChoiceTV.reloadData()
                            }
                        }
                    }
                    catch {
                        print(error)
                    }
                }
                }.resume()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMultipleChoice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as! UITableViewCell
        cell.selectionStyle = .none
        cell.textLabel!.text = arrMultipleChoice[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        selectedAnswer = arrMultipleChoice[indexPath.row]
        arrRecord[lblQuestion.text!] = selectedAnswer
        if selectedAnswer == correctAnswer {
            cell!.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cell!.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            score = score+1
            print(score)
        }
        else if (arrQuizQA[queNum].incorrect_answers?.contains(selectedAnswer))!{
            cell!.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell!.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            let val = arrMultipleChoice.index(of: correctAnswer)
            let cell1 = tableView.cellForRow(at: IndexPath(row: val!, section: 0))
            cell1!.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cell1!.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
    }
    
    @IBAction func Click_Submit(_ sender: Any) {
        if let index = navigationController?.viewControllers.firstIndex(of: self) {
           
            if index < arrQuizQA.count - 1 {
                queNum = queNum + 1
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizVC") as? QuizViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            } else {
                let end = DispatchTime.now()
                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
                let timeInterval = Double(nanoTime) / 1_000_000_000
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController {
                    vc.score = score
                    
                    vc.timeTaken = timeInterval
//                    score = 0
//                    queNum = 1
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
        multipleChoiceTV.beginUpdates()
        multipleChoiceTV.reloadData()
        multipleChoiceTV.endUpdates()
    }
    
    @IBAction func record_Answer(_ sender: Any) {
        let user = UserDefaults.standard.object(forKey: "user") as! String
        guard user != "SchoolStaff" else{
            return
        }
        UserDefaults.standard.set(arrRecord, forKey: user)
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
