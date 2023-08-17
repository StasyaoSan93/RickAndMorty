//
//  LocationInfo.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import Foundation

struct LocationInfo: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
