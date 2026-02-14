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
        let safeArea = view.safeAreaLayoutGuide
        
        for i in 0..<3 {
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            view.addSubview(button)
            buttons.append(button)
            
            let isFirstButton = i == 0
            let isLastButton = i == 2
            
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
                button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.5),
            ])
            
            
            
            if isFirstButton {
                button.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: buttons[i-1].bottomAnchor, constant: 30).isActive = true
                button.heightAnchor.constraint(equalTo: buttons[i-1].heightAnchor).isActive = true
            }
            
            if isLastButton {
                button.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -20).isActive = true
            }
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
