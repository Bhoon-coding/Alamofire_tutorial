//
//  TodoModel.swift
//  AlamofirePractice
//
//  Created by BH on 2021/10/29.
//

import Foundation

struct Todo: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var completed: Bool?
}
