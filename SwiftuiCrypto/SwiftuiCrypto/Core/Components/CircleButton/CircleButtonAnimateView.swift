//
//  CircleButtonAnimateView.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 19/05/2023.
//

import SwiftUI

struct CircleButtonAnimateView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 1.5) : .none, value: animate)
            .onAppear {
                animate.toggle()
            }
    }
}

struct CircleButtonAnimateView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimateView(animate: .constant(false))
    }
}
