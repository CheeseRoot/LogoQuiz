//
//  ImageDownloadManager.swift
//  PhonePe
//
//  Created by Sudhanshu Singh on 15/02/20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit

class LogoImageDownloadManager {

    
    private init() {
    }
    
    class func fetchLogoImageData(fromUrl url: URL, completionHandler: @escaping (_ image: UIImage?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, resposne, error) in
            
            if let downloadData = data, let image = UIImage(data: downloadData) {
                
                completionHandler(image)
                
                return
            }
            
            completionHandler(nil)
        }
        
        dataTask.resume()
    }
}
