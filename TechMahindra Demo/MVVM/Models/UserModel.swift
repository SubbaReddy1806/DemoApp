//
//  UserModel.swift
//  TechMahindra Demo
//
//  Created by Subba Reddy on 8/4/20.
//  Copyright © 2020 Subba Reddy. All rights reserved.
//

import Foundation

struct UserInfoModel:Codable {
    var title:String?
    var rows:[UserModel]?
}
struct UserModel: Codable{
    var title:String?
    var description:String?
    var imageHref:String?
}
