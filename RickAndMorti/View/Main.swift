//
//  Main.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import SwiftUI

struct Main: View {
    
    @EnvironmentObject private var rmAPI: RickAndMortyAPI
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                
                if rmAPI.getCharactersResponce?.statusCode.description == "200"  {
                    CharactersList()
                } else {
                    Loading()
                }
            }
        }
        .task {
            await rmAPI.getCharacters()
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
            .environmentObject(RickAndMortyAPI())
    }
}
