//
//  SearchBarView.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 25/05/2023.
//

import SwiftUI

struct SearchBarView: View {
    
//    @EnvironmentObject
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? .theme.secondaryText : .theme.accent
                )
            
            TextField(text: $searchText,
                      label: {
                Text("Search by name or symbol...")
            })
            .overlay(alignment: .trailing, content: {
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(.theme.accent)
                    .opacity(
                        searchText.isEmpty ? 0.0 : 1.0
                    )
                    .onTapGesture {
                        UIApplication.shared.endEdititng()
                        searchText = ""
                    }
            })
            .autocorrectionDisabled()
            .foregroundColor(.theme.accent)
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: .theme.accent.opacity(0.15),
                        radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("a"))
    }
}
