//
//  ImageService.swift
//  TechMahindra Demo
//
//  Created by Subba Reddy on 8/4/20.
//  Copyright © 2020 Subba Reddy. All rights reserved.
//

import Foundation
import UIKit

class ImageService {
    
    static let imageCache = NSCache<NSString,UIImage>()
    static func downLoadImage(url:URL,completionHandler:@escaping (_ img:UIImage?)->()){
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, Urlresponse, error) in
            var downloadImage:UIImage?
            if let data = data{
                downloadImage = UIImage(data: data)
            }
            
            if downloadImage != nil{
                imageCache.setObject(downloadImage!, forKey: url.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                completionHandler(downloadImage)
            }
        }
        dataTask.resume()
    }
    
    static func getImage(withURl url:URL,completionHandler:@escaping (_ img:UIImage?) -> ()){
        if let image = imageCache.object(forKey: url.absoluteString as NSString){
            completionHandler(image)
        }else{
            downLoadImage(url: url, completionHandler: completionHandler)
        }
    }
}
