//
//  ImageDowloader.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import Foundation
import SwiftUI

class ImageDownloader: ObservableObject {
    @Published var image: UIImage? = nil
    
    @Published var getImageResponse: HTTPURLResponse? = nil
    
    func getImage(url: String) async {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, responce) = try await URLSession.shared.data(for: request)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
                self.getImageResponse = responce as? HTTPURLResponse
            })
        } catch let error {
            print("error asynk get user image \(error.localizedDescription)")
        }
    }
    
}

