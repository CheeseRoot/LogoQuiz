//
//  LogoDataStore.swift
//  PhonePe
//
//  Created by Sudhanshu Singh on 15/02/20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit

class LogoDataStore {

    private var logoDataSource: LogoDataSource
    
    
    init(logoDataSource: LogoDataSource) {
        
        self.logoDataSource = logoDataSource
    }
    
    
    func getAllLogoData() -> [Logo] {
        
        return self.logoDataSource.allLogos
    }
    
    
    func getLogoData(forStage stage: Int) -> Logo? {
        
        if stage < self.logoDataSource.allLogos.count {
            
            return self.logoDataSource.allLogos[stage]
        }
        
        return nil
    }
}
