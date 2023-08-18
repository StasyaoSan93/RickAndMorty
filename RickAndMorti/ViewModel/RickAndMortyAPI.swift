//
//  RickAndMortyAPI.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import Foundation
import SwiftUI

final class RickAndMortyAPI: ObservableObject {
    
    let manager = DownloadManager()
    
    @Published var characters: Characters? = nil
    @Published var getCharactersResponce: HTTPURLResponse? = nil
    
    @Published var locationInfo: LocationInfo? = nil
    @Published var getlocationInfoResponce: HTTPURLResponse? = nil
    
    @Published var episodes: [Episode]? = nil
    @Published var getEpisodesResponce: HTTPURLResponse? = nil
    
    func getCharacters() async {
        let url = "https://rickandmortyapi.com/api/character"
        do {
            let (data, responce) = try await manager.getData(url: url)
            let characters = try? JSONDecoder().decode(Characters.self, from: data)
            await MainActor.run(body: {
                self.characters = characters
                self.getCharactersResponce = responce as? HTTPURLResponse
            })
        } catch let error {
            print("error get characters \(error.localizedDescription)")
        }
    }
    
    func getLocationInfo(url: String) async {
        do {
            let (data, responce) = try await manager.getData(url: url)
            let location = try? JSONDecoder().decode(LocationInfo.self, from: data)
            await MainActor.run(body: {
                self.locationInfo = location
                self.getlocationInfoResponce = responce as? HTTPURLResponse
            })
        } catch let error {
            print("error get location info \(error.localizedDescription)")
        }
    }
    
    func getEpisodes(result: Result) async {
        var episodes: String = ""
        for ep in 0..<result.episode.count {
            episodes += result.episode[ep].replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: ep == 0 ? "" : ",")
        }
        let url = "https://rickandmortyapi.com/api/episode/\(episodes)"

        do {
            let (data, responce) = try await manager.getData(url: url)
            let episodes = try? JSONDecoder().decode([Episode].self, from: data)
            await MainActor.run(body: {
                self.episodes = episodes
                self.getEpisodesResponce = responce as? HTTPURLResponse
            })
        } catch let error {
            print("error get episodes \(error.localizedDescription)")
        }
    }
}
