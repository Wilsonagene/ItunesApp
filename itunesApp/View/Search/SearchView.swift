//
//  SearchView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchTerm: String = ""
    @State private var selectedEntityType = EntityType.all
    
    @StateObject private var albumViewModel = AlbumViewModel()
    @StateObject private var songViewModel = SongViewModel()
    @StateObject private var movieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
               
                Picker("Select the media", selection: $selectedEntityType) {
                    ForEach(EntityType.allCases) { type in
                        Text(type.name())
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Divider()
                if searchTerm.count == 0 {
                    SearchPlaceHolderView(searchTerm: $searchTerm)
                        .frame(maxHeight: .infinity)
                } else {
                    switch selectedEntityType {
                    case .all:
                        SearchAllListView(albumViewModel: albumViewModel, songViewModel: songViewModel, movieViewModel: movieViewModel)
                    case .album:
                        AlbumListView(viewModel: albumViewModel)
                    case .song:
                        SongListView(viewModel: songViewModel)
                    case .movie:
                        MovieListView(viewModel: movieViewModel)
        
                    }
                }
                
                
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: selectedEntityType) { newValue in
            updateViewModel(for: searchTerm, selectedEntityType: newValue)
        }
        
        .onChange(of: searchTerm) { newValue in
            updateViewModel(for: searchTerm, selectedEntityType: selectedEntityType)
          
        }
    }
    
    func updateViewModel(for searchTerm: String, selectedEntityType: EntityType) {
        switch selectedEntityType {
        case .all:
            albumViewModel.searchTerm = searchTerm
            songViewModel.searchTerm = searchTerm
            movieViewModel.searchTerm = searchTerm
        case .album:
            albumViewModel.searchTerm = searchTerm
            songViewModel.searchTerm = " "
            movieViewModel.searchTerm = " "
        case .song:
            songViewModel.searchTerm = searchTerm
            albumViewModel.searchTerm = " "
            movieViewModel.searchTerm = " "
        case .movie:
            movieViewModel.searchTerm = searchTerm
            songViewModel.searchTerm = " "
           albumViewModel.searchTerm = " "
        }
    }
}

#Preview {
    SearchView()
}
