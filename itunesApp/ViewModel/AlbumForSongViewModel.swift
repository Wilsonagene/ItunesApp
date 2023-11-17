//
//  AlbumForSongViewModel.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 17/11/2023.
//

import Foundation


class AlbumForSongViewModel: ObservableObject {
    
    @Published var album: AlbumModel? = nil
    @Published var state: FetchState = .empty
    
    let service = APIService()
    
    func fetchsongs(song: SongModel) {
        
        let albumId = song.collectionID
        
        state = .isLoding
        
        service.fetchAlbums(for: albumId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let failure):
                    print("error fetching album with id: \(failure)")
                    self?.state = .error(failure.localizedDescription)
                    
                case .success(let success):
                    print("succesfully fetched album for song \(song.trackName)")
                    self?.album = success.results.first
              
                }
            }
        }
    }
    
}

