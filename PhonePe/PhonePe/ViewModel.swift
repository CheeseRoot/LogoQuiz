//
//  ViewModel.swift
//  PhonePe
//
//  Created by Sudhanshu Singh on 15/02/20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit

class ViewModel {

    
    init(downloadManager: LogoDownloadProtocol) {
        
        self.downloadManager = downloadManager
        
        self.setUserDetails()
    }
    
    private var downloadManager: LogoDownloadProtocol?
    
    private var dataStore: LogoDataStore?
    
    private var userManager: UserManager = UserManager()
    
    
    var refreshUI: (()->Void)?
    
    
    private func setUserDetails() {
        
        self.userManager.setUserName(value: "Sudhanshu Singh")
        
        self.userManager.setUserMobileNumber(value: "9717092209")
    }
    
    
    func fetchLogoAndSaveToDataStore() {
        
        self.downloadManager?.fetchLogos(withCompletion: {[weak self] (response: LogoDataSource?, error: Error?) in
            
            if let _response = response, error == nil {
                
                self?.setupDataStore(with: _response)
                
                self?.refreshUI?()
            }
        })
    }
    
    
    func setupDataStore(with object: LogoDataSource) {
        
        self.dataStore = LogoDataStore(logoDataSource: object)
    }
    
    
    
    ///
    
    func moveUserToNextLevelAndRefreshUI(forCount count: Double) {
        
        let currentLevelStage = self.userManager.getUserLevel()
        
        let currentLevelScore = self.userManager.getUserScore()
        
        self.userManager.setUserLevel(value: currentLevelStage + 1)
        
        self.userManager.setUserScore(value: currentLevelScore + count)
        
        self.refreshUI?()
    }
    
    
    func getCurrentScore() -> Double {
        
        return self.userManager.getUserScore()
    }
    
    
    func getCurrentLevel() -> Int {
        
        return self.userManager.getUserLevel()
    }
    
    
    private func getLogoDataForCurrentLevel() -> Logo? {
        
        let currentLevelStage = self.userManager.getUserLevel()
        
        return self.dataStore?.getLogoData(forStage: currentLevelStage)
    }
    
    
    func getLogoImageForCurrentLevel(completion: @escaping (_ image: UIImage?)->Void) {
        
        let currentLevelData = self.getLogoDataForCurrentLevel()

        if let _url = currentLevelData?.imgUrl, let imageUrl = URL(string: _url) {
            
            LogoImageDownloadManager.fetchLogoImageData(fromUrl: imageUrl) { (image: UIImage?) in
                
                completion(image)
            }
        }
        
        completion(nil)
    }
    
    
    ///
    
    func getRandomCharctersForCurrentLevel() -> [Character] {
        
        if let currentLevelData = self.getLogoDataForCurrentLevel(), let name = currentLevelData.name {

            return LetterGenerator.generateRandomLetters(containing: name)
            
        }
        
        return []
    }
    
    
    ///
    
    func validateInputForCurrentLevel(input: String) -> Bool {
        
        if let currentLevelData = self.getLogoDataForCurrentLevel(), let name = currentLevelData.name {
            
            return name.uppercased() == input.uppercased()
        }
        
        return false
    }
}
