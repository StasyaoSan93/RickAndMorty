//
//  Detail.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import SwiftUI

struct Detail: View {
    
    @EnvironmentObject private var rmAPI: RickAndMortyAPI
    @Environment(\.presentationMode) var prentationMode
    @StateObject private var image = ImageDownloader()
    let character: Result
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            ScrollView() {
                headSection
                    .padding(.bottom, 12)
                
                infoSection
                    .padding(.bottom, 12)
                
                originSection
                    .padding(.bottom, 12)
                
                episodesSection
            }
            .padding(.horizontal, 8)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    prentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(Color.theme.text)
                }
            }
        })
        .task {
            await image.getImage(url: character.image)
            await rmAPI.getLocationInfo(url: character.origin.url)
            await rmAPI.getEpisodes(result: character)
        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Detail(character: Result(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: CharaterLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"), location: CharaterLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"), image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", episode: ["https://rickandmortyapi.com/api/episode/2", "https://rickandmortyapi.com/api/episode/3"], url: "https://rickandmortyapi.com/api/character/2", created: "2017-11-04T18:50:21.651Z"))
                .environmentObject(RickAndMortyAPI())
        }
    }
}

extension Detail {
    
    private var headSection: some View {
        VStack(spacing: 10) {
            ZStack {
                if let image = image.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 148, height: 148)
                        .cornerRadius(10)
                } else {
                    ProgressView().colorInvert()
                        .frame(width: 140, height: 140)
                }
            }
            Text(character.name)
                .foregroundColor(Color.theme.text)
                .font(.system(size: 22))
            Text(character.status)
                .foregroundColor(Color.theme.greenText)
                .font(.system(size: 16))
        }
    }
    
    private var infoSection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Info")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.text)
                
                Spacer()
            }
            
            VStack(spacing: 12) {
                HStack {
                    Text("Species:")
                    
                    Spacer()
                    
                    Text(character.species)
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Type:")
                    
                    Spacer()
                    
                    Text(character.type == "" ? "None" : character.type)
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Gender:")
                    
                    Spacer()
                    
                    Text(character.gender)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .font(.system(size: 16))
            .foregroundColor(Color.theme.text)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.theme.card)
            )
        }
    }
    
    private var originSection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Origin")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.text)
                
                Spacer()
            }
            
            HStack(spacing: 10) {
                if let origin = rmAPI.locationInfo {
                    Image("originImage")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .frame(width: 64, height: 64)
                        .background(Color.theme.detailImage)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(character.origin.name)
                        Text(origin.type)
                            .foregroundColor(Color.theme.greenText)
                    }
                    
                    Spacer()
                } else {
                    ProgressView().colorInvert()
                        .frame(width: 70, height: 70)
                }
            }
            .padding(8)
            .font(.system(size: 16))
            .foregroundColor(Color.theme.text)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.theme.card)
            )
        }
    }
    
    private var episodesSection: some View {
        VStack {
            HStack {
                Text("Episodes")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.text)
                
                Spacer()
            }
            
            if let episodes = rmAPI.episodes {
                ForEach(episodes) { episode in
                    VStack(alignment: .leading, spacing: 16) {
                        Text(episode.name)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.text)
                        
                        HStack {
                            Text(episode.episode.replacingOccurrences(of: "S", with: "Season:").replacingOccurrences(of: "E", with: ", Episode:"))
                                .font(.system(size: 13))
                                .foregroundColor(Color.theme.greenText)
                            
                            Spacer()
                            
                            Text(episode.airDate)
                                .font(.system(size: 12))
                                .foregroundColor(Color.theme.grayText)
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.theme.card)
                )
            } else {
                ProgressView().colorInvert()
            }
        }
    }
    
}
