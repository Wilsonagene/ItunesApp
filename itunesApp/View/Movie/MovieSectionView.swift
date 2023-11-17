//
//  MovieSectionView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct MovieSectionView: View {
    
    let movies: [MovieModel]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top,spacing: 0) {
                ForEach(movies) { movies in
                    VStack(alignment: .leading, spacing: 10) {
                        ImageLoadingView(urlString: movies.artworkUrl100, size: 80)
                        Text(movies.trackName)
                        Text(movies.primaryGenreName)
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
    MovieSectionView(movies: [MovieModel.example()])
}
