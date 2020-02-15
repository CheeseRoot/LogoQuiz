//
//  LogoDownloadManager.swift
//  PhonePe
//
//  Created by Sudhanshu Singh on 15/02/20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit



protocol LogoDecodable {
    
    init?(with json: Any)
}


protocol LogoDownloadProtocol {
    
    func fetchLogos<Model>(withCompletion completion: (_ response: Model?, _ error: Error?)->Void) where Model: LogoDecodable
}


final class LogoDownloadManager: LogoDownloadProtocol {
    
    func fetchLogos<Model>(withCompletion completion: (Model?, Error?) -> Void) where Model : LogoDecodable {
        
        if let path = Bundle.main.path(forResource: "logo", ofType: "txt") {
            
            let pathUrl = URL(fileURLWithPath: path)
            
            do {
                let data = try Data(contentsOf: pathUrl)
                
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                let object = Model.init(with: jsonResult)
                
                completion(object, nil)
                
            } catch (let error) {
                
                completion(nil, error)
            }
        }
        
        completion(nil, nil)
    }
}
