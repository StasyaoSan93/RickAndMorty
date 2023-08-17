//
//  RickAndMortiApp.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import SwiftUI

@main
struct RickAndMortiApp: App {
    
    @StateObject var rmAPI = RickAndMortyAPI()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.text)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.text)]
    }
    
    var body: some Scene {
        WindowGroup {
            Main()
                .environmentObject(rmAPI)
        }
    }
}
