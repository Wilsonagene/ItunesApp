//
//  AlbumSectionView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct AlbumSectionView: View {
    
    let album: [AlbumModel]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top) {
                ForEach(album) { album in
                    VStack(alignment: .leading) {
                        ImageLoadingView(urlString: album.artworkUrl100, size: 100)
                        Text(album.collectionName)
                        Text(album.artistName)
                            .foregroundStyle(Color.gray)
                    }
                    .lineLimit(2)
                    .frame(width: 100)
                    .font(.caption)
                    
                }
            } .padding(.horizontal)
        }
    }
}

#Preview {
    AlbumSectionView(album: [AlbumModel.example()])
}
