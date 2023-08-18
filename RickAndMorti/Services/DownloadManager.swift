//
//  DownloadManager.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 18.08.2023.
//

import Foundation

actor DownloadManager {
    func getData(url: String) async throws -> (Data, URLResponse) {
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            return try await URLSession.shared.data(for: request)
        } catch let error as URLError {
            throw URLError(error.code)
        }
    }
}
