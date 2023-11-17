//
//  MoiveRowView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct MovieRowView: View {
    
    let movie: MovieModel
    var body: some View {
        HStack {
            ImageLoadingView(urlString: movie.artworkUrl100, size: 100)
            
            VStack(alignment: .leading) {
                Text(movie.trackName)
                Text(movie.primaryGenreName)
                    .foregroundStyle(Color.gray)
                Text(movie.releaseDate)
//                    .foregroundStyle(Color.gray)
                
            } .font(.caption)
            
            Spacer(minLength: 20)
            
            BuyButton(urlString: movie.previewURL ?? "", price: movie.trackPrice, currency: movie.currency)
        }
    }
}

#Preview {
    MovieRowView(movie: MovieModel.example())
}
