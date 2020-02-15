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

    private let viewModel: ViewModel = ViewModel(downloadManager: LogoDownloadManager())
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupVM()
        
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
            
            self.inputTextField.text = ""
            
            viewModel.moveUserToNextLevelAndRefreshUI()
        }
        else {
            
            // Handle Error
        }
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

