//
//  ViewController.swift
//  PhonePe
//
//  Created by Sudhanshu Singh on 15/02/20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var keyLetters: [UIButton]?
    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var inputTextField: UITextField!
    @IBOutlet private var currentScoreLabel: UILabel!
    @IBOutlet private var currentLevelLabel: UILabel!
    @IBOutlet private var countDownLabel: UILabel!
    

    private let viewModel: ViewModel = ViewModel(downloadManager: LogoDownloadManager())
    
    private var timer: Timer?
    private var count: Double = 30


    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupVM()
        
        self.startTimer()
        
        self.viewModel.fetchLogoAndSaveToDataStore()
    }

    
    private func setupVM() {
        
        self.viewModel.refreshUI = {
            
            self.loadCurrentLevel()
        }
    }
    
    
    private func loadCurrentLevel() {
        
        self.setUserInfo()
        
        self.setLogoImage()
        
        self.setLogoCharacters()
    }
    
    
    private func setUserInfo() {
        
        self.currentScoreLabel.text = "Score: \(viewModel.getCurrentScore())"
        
        self.currentLevelLabel.text = "Level: \(viewModel.getCurrentLevel())"
    }
    
    
    private func setLogoImage() {
        
        viewModel.getLogoImageForCurrentLevel { (image) in
            
            if image != nil {
                
                DispatchQueue.main.async {
                    
                    self.logoImageView.image = image
                }
            }
            else {
                
                // Handling for no image
            }
        }
    }
    
    
    private func setLogoCharacters() {
        
        let randomCharsForCurrentLevel: [Character] = viewModel.getRandomCharctersForCurrentLevel()
        
        if let _keyLetters = self.keyLetters {
            
            for (index, button) in _keyLetters.enumerated() {
                
                let displayString = String(randomCharsForCurrentLevel[index])
                
                button.setTitle(displayString, for: .normal)
            }
        }
    }
    
    
    private func validate(input: String) {
        
        if viewModel.validateInputForCurrentLevel(input: input) {
            
            viewModel.moveUserToNextLevelAndRefreshUI(forCount: self.count)
            
            self.resetForNewLevel()
        }
        else {
            
            // Handle Error
        }
    }
    
    
    private func resetForNewLevel() {
        
        self.inputTextField.text = ""
        
        self.count = 30
        
        self.invalidateTimer()
        
        self.startTimer()
    }
}



extension ViewController { // @IBAction
    
    @IBAction func inputButtonTapped(_ sender: UIButton) {

        if let inputKey = sender.titleLabel?.text, let currentText = self.inputTextField.text {
            
            let newString = currentText + inputKey
            
            self.inputTextField.text = newString
            
            self.validate(input: newString)

        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        
    }
}



extension ViewController: UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return false
    }
}



extension ViewController { // Timer
    
    func startTimer() {
        
         self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    
    func invalidateTimer() {
        
        self.timer?.invalidate()
        
        self.timer = nil
    }
    
    
    @objc func update() {
        
        if(count > 0) {
            
            count = count - 1
            
            countDownLabel.text = "\(String(count)) seconds"
        }
        else {
            //Handle countdown finish error
        }
    }
}

