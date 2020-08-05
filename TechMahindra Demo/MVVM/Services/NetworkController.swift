//
//  NetworkController.swift
//  TechMahindra Demo
//
//  Created by Subba Reddy on 8/4/20.
//  Copyright © 2020 Subba Reddy. All rights reserved.
//

import UIKit

class NetworkController: NSObject {
    static let sharedInstance = NetworkController()
    func getDataFromServer(completionHandler: @escaping (Result<UserInfoModel,Error>)-> Void) {
        guard let urlString = URL(string:BaseURL.userInfoURl) else{return}
        APIManager.sharedInstance.getAPIData(url: urlString) { (result) in
            
            switch result{
            case .success(let userData):
                completionHandler(.success(userData))
                break
            case .failure(let error):
                completionHandler(.failure(error))
                break
            }
        }
    }
    
    
}
