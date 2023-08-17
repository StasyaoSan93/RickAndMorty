//
//  SwiftUIView.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import SwiftUI

struct Card: View {
    
    @StateObject var image = ImageDownloader()
    let name: String
    let imageURL: String
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                if let image = image.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .cornerRadius(10)
                } else {
                    ProgressView().colorInvert()
                        .frame(width: 140, height: 140)
                }
            }
            .offset(y: -8)
            
            Text(name)
        }
        .foregroundColor(Color.theme.text)
        .font(.system(size: 17))
        .frame(width: 156, height: 202)
        .background(Color.theme.card)
        .cornerRadius(16)
        .task {
            await image.getImage(url: imageURL)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Card(name: "Rick And Morty", imageURL: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
    }
}
