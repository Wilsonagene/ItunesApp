//
//  SongRowView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct SongRowView: View {
    
    let song: SongModel
    
    var body: some View {
        HStack {
            
            ImageLoadingView(urlString: song.artworkUrl60, size: 60)
            
            VStack(alignment: .leading) {
                Text(song.trackName)
                Text(song.artistName + "-" + song.collectionName)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                
            } .lineLimit(1)
            
            Spacer(minLength: 20)
            
            SongBuyButton(urlString: song.previewURL, price: song.trackPrice, currency: song.currency)
        }
    }
}

#Preview {
    SongRowView(song: SongModel.example())
}


