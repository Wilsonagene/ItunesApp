//
//  SearchPlaceHolderView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import SwiftUI

struct SearchPlaceHolderView: View {
    
    @Binding var searchTerm: String
    let sugesstion = ["Meji Meji", "Yellow", "Grambo"]

    var body: some View {
        
        VStack(spacing: 30) {
            Text("Trending")
                .font(.largeTitle)
            ForEach (sugesstion, id: \.self) { text in
                Button("\(text)") {
                    searchTerm = text
                }
            }
        }
        
    }
    
    
}

#Preview {
    SearchPlaceHolderView(searchTerm: .constant("Wilson"))
}
