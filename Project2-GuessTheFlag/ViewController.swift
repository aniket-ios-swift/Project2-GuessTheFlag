//
//  ViewController.swift
//  Project2-GuessTheFlag
//
//  Created by Aniket Rao on 06/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalQuestions = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        askQuestion(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScoreTapped))
    }
    
    func restartGame(action: UIAlertAction!){
        score = 0
        totalQuestions = 0
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + "  Current Score: \(score)" + "  Questions Left: \(5 - totalQuestions)"
        
        if (totalQuestions == 5){
            let ac = UIAlertController(title: "Thanks for playing", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: restartGame))
            present(ac, animated: true)
        }
    }
    
  
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer{
            title = "Correct!"
            score += 1
            showAlert(title: title, correct_answer: true)

        }else{
            title = "Wrong!"
            score -= 1
            showAlert(title: title, correct_answer: false)
        }
        totalQuestions += 1
    }
    
    func showAlert(title: String, correct_answer: Bool){
        let ac: UIAlertController
        if (correct_answer){
            ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        }else{
            ac = UIAlertController(title: title, message: "The correct answer is \(countries[correctAnswer].capitalized). Your score is \(score)", preferredStyle: .alert)
        }
        ac.addAction(UIAlertAction(title:"Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func showScoreTapped(){
        let vc = UIActivityViewController(activityItems: ["Your score is \(score)"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

