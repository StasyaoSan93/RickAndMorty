//
//  CharactersList.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import SwiftUI

struct CharactersList: View {
    
    @EnvironmentObject private var rmAPI: RickAndMortyAPI
    let columns: [GridItem] = [
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                if let characters = rmAPI.characters?.results {
                    ForEach(characters) { character in
                        NavigationLink {
                            Detail(character: character)
                        } label: {
                            Card(name: character.name, imageURL: character.image)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Characters")
        .navigationBarHidden(false)
    }
}

struct CharactersList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                CharactersList()
                    .environmentObject(RickAndMortyAPI())
            }
        }
    }
}
