//
//  ViewController.swift
//  Project2NoStoryboard
//
//  Created by Macedo on 31/01/26.
//

import UIKit

class ViewController: UIViewController {
    var buttons = [UIButton]()
    
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var correctAnswer = Int.random(in: 0...2)
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        view.backgroundColor = .systemBackground
        setupButtons()
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        for (i, button) in buttons.enumerated() {
            button.setImage(UIImage(named: countries[i]), for: .normal)
        }
        
        title = countries[correctAnswer].uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trophy"),
            style: .plain,
            target: self,
            action: #selector(showScore)
        )
    }
    
    @objc func showScore() {
        let alertController = UIAlertController(title: "Score", message: "Your score is \(score).", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true)
    }
    
    func setupButtons() {
        for i in 0..<3 {
            let button = UIButton(type: .custom)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(button)
            buttons.append(button)
            
            let isFirstButton = i == 0
            
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 100),
                button.widthAnchor.constraint(equalToConstant: 200),
                button.topAnchor.constraint(
                    equalTo: isFirstButton ? view.topAnchor : buttons[i-1].bottomAnchor,
                    constant: isFirstButton ? 100 : 30
                )
            ])
            
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var alertTitle: String
        
        if sender.tag == correctAnswer {
            alertTitle = "Correct"
            score += 1
        } else {
            alertTitle = "Wrong"
            score -= 1
        }
        
        let alertController = UIAlertController(title: alertTitle, message: "Your score is \(score).", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(alertController, animated: true)
    }
}
