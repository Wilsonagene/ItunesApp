//
//  AlbumSearchView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 13/11/2023.
//

import SwiftUI

struct AlbumSearchView: View {
    
    @StateObject var viewModel = AlbumViewModel()

    var body: some View {
        
        NavigationView {
            
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceHolderView(searchTerm: $viewModel.searchTerm )
                } else {
                    AlbumListView(viewModel: viewModel)
                }
            }
           
           
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}



#Preview {
    AlbumSearchView()
}
