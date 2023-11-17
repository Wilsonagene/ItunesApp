//
//  SearchAllListView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import SwiftUI

struct SearchAllListView: View {
    
    @ObservedObject var albumViewModel: AlbumViewModel
    @ObservedObject var songViewModel: SongViewModel
    @ObservedObject var movieViewModel: MovieViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 5) {
                
                if songViewModel.songs.count > 0 {
                    SectionHeaderView(title: "Songs") {
                        SongListView(viewModel: songViewModel)
                    } .padding(.top)
                    
                    SongSectionView(songs: songViewModel.songs)
                    Divider()
                        .padding(.bottom)
                }
                
                
                if albumViewModel.albums.count > 0 {
                    SectionHeaderView(title: "Albums") {
                        AlbumListView(viewModel: albumViewModel)
                    }
                    
                    AlbumSectionView(album: albumViewModel.albums)
                       Divider()
                        .padding(.bottom)
                }
                
                
                if movieViewModel.movies.count > 0 {
                    SectionHeaderView(title: "Movies") {
                        MovieListView(viewModel: movieViewModel)
                    }
                    MovieSectionView(movies: movieViewModel.movies)
                    .padding(.leading)
                }
                
//                    
//                    Text("Search")
//                    
//                    Text("Albms: \(albumViewModel.albums.count)")
//                    Text("Songs: \(songViewModel.songs.count)")
//                    Text("Movies: \(movieViewModel.movies.count)")
                
                
               
            }
        }
       
        
    }
}



struct SectionHeaderView<Destination>: View where Destination : View {
    
    let title: String
    let destination:  () -> Destination
    
    init(title: String, @ViewBuilder destination: @escaping () -> Destination) {
        self.title = title
        self.destination = destination
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
            Spacer()
            
            NavigationLink(destination: destination) {
                HStack {
                    Text("See all")
                    Image(systemName: "chevron.right")
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchAllListView(albumViewModel: AlbumViewModel.example(), songViewModel: SongViewModel.example(), movieViewModel: MovieViewModel.example())
}
