//
//  Model.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import Foundation

// MARK: - Characters
struct Characters: Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result
struct Result: Identifiable, Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: CharaterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct CharaterLocation: Codable {
    let name: String
    let url: String
}
