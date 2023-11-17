//
//  SongDetailView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 17/11/2023.
//

import SwiftUI

struct SongDetailView: View {
    
    let song: SongModel
    @StateObject var songsListViewModel: SongsForAlbumListViewModel
    @StateObject var albumViewModel = AlbumForSongViewModel()
    
    init(song: SongModel) {
        self.song = song
        self._songsListViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: song.collectionID))
    }
    
    var body: some View {
        VStack {
            
            if let album = albumViewModel.album {
                AlbumHeaderDetailView(album: album)
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            SongsForAlbumListView(songsListViewModel: songsListViewModel, selectedSong: song)
        }
        .onAppear {
            songsListViewModel.fetch()
            albumViewModel.fetchsongs(song: song)
        }
    }
}

#Preview {
    SongDetailView(song: SongModel.example())
}
