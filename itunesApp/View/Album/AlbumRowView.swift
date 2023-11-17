//
//  AlbumRowView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct AlbumRowView: View {
    
    let album: AlbumModel
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: album.artworkUrl100, size: 100)
            
            VStack(alignment: .leading) {
                
                Text(album.collectionName)
                Text(album.artistName)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                
            } .lineLimit(1)
            
            Spacer(minLength: 50)
            
            BuyButton(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
            
        }
    }
}

#Preview {
    AlbumRowView(album: AlbumModel.example())
}
