//
//  Color.swift
//  RickAndMorti
//
//  Created by StasyaoSan on 17.08.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let text = Color("textColor")
    let background = Color("backgroundColor")
    let card = Color("cardColor")
    let greenText = Color("textGreenColor")
    let detailImage = Color("detailOriginImageBackground")
    let grayText = Color("textGrayColor")
}
