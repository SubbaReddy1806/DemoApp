//
//  APIManager.swift
//  TechMahindra Demo
//
//  Created by Subba Reddy on 8/4/20.
//  Copyright © 2020 Subba Reddy. All rights reserved.
//

import Foundation

class APIManager {
    static let sharedInstance = APIManager()
    private init(){}
    
    func getAPIData(url:URL,completionHandler:@escaping (Result<UserInfoModel,Error>)-> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Error
            if let error = error{
                completionHandler(.failure(error))
                return
            }
            //Sucessful
            do{
                if let data = data{
                    let responseStr = String(data: data, encoding: .iso2022JP)
                    guard let utf8Data = responseStr?.data(using: String.Encoding.utf8) else{return}
                    let result = try JSONDecoder().decode(UserInfoModel.self, from: utf8Data)
                    completionHandler(.success(result))
                }
            }catch let jsonerror{
                completionHandler(.failure(jsonerror))
            }
        }.resume()
    }
}
