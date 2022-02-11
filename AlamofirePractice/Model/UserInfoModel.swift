//
//  userInfoModel.swift
//  AlamofirePractice
//
//  Created by BH on 2022/02/11.
//

import Foundation

struct UserInfo: Codable {
    
    let email: String
    let password: String
    let userName: String
    
    private enum CodingKeys: String, CodingKey {
        case email, password
        case userName = "username"
    }
}
