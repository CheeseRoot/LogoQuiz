//
//  Logo.swift
//  PhonePe
//
//  Created by Sudhanshu Singh on 15/02/20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit


final class LogoDataSource: LogoDecodable {
    
    var allLogos: [Logo] = []
    
    
    init?(with json: Any) {
        
        guard let jsonList = json as? [[String: AnyObject]] else {
            
            return nil
        }
        
        for item in jsonList {
            
            if let logoObject = Logo(with: item) {
                
                self.allLogos.append(logoObject)
            }
        }
    }
}


final class Logo: LogoDecodable {
    
    var imgUrl: String?
    
    var name: String?
    
    
    init?(with json: Any) {
        
        guard let jsonDict = json as? [String: AnyObject] else {
            
            return nil
        }
        
        self.imgUrl = jsonDict["imgUrl"] as? String
        
        self.name = jsonDict["name"] as? String
    }
}
