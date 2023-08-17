//
//  Loading.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import SwiftUI

struct Loading: View {
    var body: some View {
        Image("loadingImage")
            .resizable()
            .frame(maxWidth: .infinity)
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            Loading()
        }
    }
}
