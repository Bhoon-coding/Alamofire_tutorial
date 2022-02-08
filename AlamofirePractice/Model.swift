//
//  TodoModel.swift
//  AlamofirePractice
//
//  Created by BH on 2021/10/29.
//

import Foundation

//struct Todos: Codable {
//    let todo: [Todo]?
//}

//struct Todo: Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let completed: Bool
//}

struct Records: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Record]
    
}

struct Record: Codable {
    
    let id: Int
    let name: String?
    let survey: Survey?
    let title: String?
    let type: String?
    let unit: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, survey, title, type, unit
    }
    

}

struct Survey: Codable {
    let thtb: Bool
    let normalRangeStart: Int
    let normalRangeEnd: Int

}
