//
//  UserViewModel.swift
//  TechMahindra Demo
//
//  Created by Subba Reddy on 8/4/20.
//  Copyright © 2020 Subba Reddy. All rights reserved.
//

import Foundation

protocol UserViewModelDelegate {
    func updateTableViewData()
}

class UserViewModel {
    
    var userInfoArray:UserInfoModel?
    var delegate:UserViewModelDelegate?
    
    required init(delegate:UserViewModelDelegate){
        self.delegate = delegate
    }
    func getDataFromServer()  {
        NetworkController.sharedInstance.getDataFromServer { [weak self](result) in
            guard let strongself = self else{return}
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
                break
            case .success(let userData):
                strongself.userInfoArray = userData
                strongself.delegate?.updateTableViewData()
                break
            }
        }
    }
}
