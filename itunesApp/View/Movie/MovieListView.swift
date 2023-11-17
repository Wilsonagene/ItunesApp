//
//  MovieView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var viewModel: MovieViewModel
    
    var body: some View {
        
            List {
              ForEach  (viewModel.movies) { movie in
                  MovieRowView(movie: movie)
                }
                
                switch viewModel.state {
                    case .empty:
                    Color.clear
                        .onAppear {
                            viewModel.loadMore()
                        }
                case .isLoding:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                    
                case .loadedAll:
                    EmptyView()
                case .error(let message):
                    Text(message)
                        .foregroundStyle(.red)
                }
            }
            .listStyle(.plain)
    }
}

#Preview {
    MovieListView(viewModel: MovieViewModel())
}
