//
//  XMarkButton.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 26/05/2023.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
