//
//  CircleButtonView.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 19/05/2023.
//

import SwiftUI

struct CircleButtonView: View {
    
    var iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.theme.background)
            )
            .shadow(color: .theme.accent.opacity(0.3),
                    radius: 10)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "heart.fill")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
        
    }
}
