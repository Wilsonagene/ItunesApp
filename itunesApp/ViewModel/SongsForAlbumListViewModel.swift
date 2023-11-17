//
//  SongsForAlbumListViewModel.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 16/11/2023.
//

import Foundation

class SongsForAlbumListViewModel: ObservableObject {
    
    let albumID: Int
    @Published var songs = [SongModel]()
    @Published var state: FetchState = .empty
    
    private let songservice = APIService()
    
    init(albumID: Int) {
        self.albumID = albumID
        print("init for songs album \(albumID)")
    }
    
    func fetch() {
        fetchSongs(for: albumID)
    }
    
   private func fetchSongs(for albumID: Int) {
        songservice.fetchSongs(for: albumID) {  [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let song):
                    
                    var songs = song.results
                    
                    if song.resultCount > 0 {
                        _ = songs.removeFirst()
                    }
                   
                    
                    self?.songs = songs.sorted(by: {$0.trackNumber < $1.trackNumber})
                    self?.state = .empty
                    print("Fetched \(song.resultCount) Songs for albumID: \(albumID)")
//                    print(song.results)
                    
                case.failure(let error):
                    print("Could not Load Songs: \(error)")
                    self?.state = .error("Could not Load Songs: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> SongsForAlbumListViewModel {
        let vm = SongsForAlbumListViewModel(albumID: 1440752312)
        vm.songs = [SongModel.example(), SongModel.example2()]
        return vm
    }
    
}
