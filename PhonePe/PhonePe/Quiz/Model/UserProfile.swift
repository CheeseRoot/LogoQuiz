//
//  UserProfile.swift
//  PhonePe
//
//  Created by Sudhanshu Singh on 15/02/20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit


final class UserManager {
    
    private var user: User = User.sharedInstance
    
    
    func getUserName() -> String {
        
        return self.user.name
    }
    
    
    func getUserMobileNumber() -> String {
        
        return self.user.mobileNumber
    }

    
    func getUserScore() -> Double {
        
        return self.user.score
    }

    
    func getUserLevel() -> Int {
        
        return self.user.level
    }

    
    
    func setUserName(value: String) {
        
        self.user.name = value
    }
    
    
    func setUserMobileNumber(value: String) {
        
        self.user.mobileNumber = value
    }
    
    
    func setUserScore(value: Double) {
        
        self.user.score = value
    }
    
    
    func setUserLevel(value: Int){
        
        self.user.level = value
    }
    
}



final class User {

    private init() {}
    
    fileprivate static let sharedInstance: User = User()
    
    public fileprivate(set) var name: String = ""
    
    public fileprivate(set) var mobileNumber: String = ""
    
    
    public fileprivate(set) var score: Double = 0.0
    
    public fileprivate(set) var level: Int = 0
}
