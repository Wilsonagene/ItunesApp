//
//  MovieView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import SwiftUI

struct MovieSearchListView: View {
    
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        
        NavigationView {
            
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceHolderView(searchTerm: $viewModel.searchTerm )
                } else {
                    MovieListView(viewModel: viewModel)
                }
            }
           
           
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Moives")
        }
    }
}

#Preview {
    MovieSearchListView()
}
