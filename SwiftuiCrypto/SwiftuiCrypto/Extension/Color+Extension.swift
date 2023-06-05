//
//  Color+Extension.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 19/05/2023.
//

import SwiftUI

extension Color {
    static let theme: ColorTheme = ColorTheme()
    static let launch: LaunchTheme = LaunchTheme()
}

struct ColorTheme {
    let accent: Color = Color("AccentColor")
    let background: Color = Color("BackgroundColor")
    let green: Color = Color("GreenColor")
    let red: Color = Color("RedColor")
    let secondaryText: Color = Color("SecondaryTextColor")
}

struct LaunchTheme {
    let accent: Color = Color("LaunchAccentColor")
    let background: Color = Color("LaunchBackgroundColor")
}
