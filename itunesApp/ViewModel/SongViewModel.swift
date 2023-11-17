//
//  SongViewModel.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import Foundation
import Combine


class SongViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var songs: [SongModel] = [SongModel]()
    @Published var state: FetchState = .empty
    
    private let songservice = APIService()
    
    let limit: Int = 20
    
    var page: Int = 0
    
    var subcriptions = Set<AnyCancellable>()
    
    init() {
        
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
            self?.fetchSongs(for: term)
        }.store(in: &subcriptions)
        
//        return
    }
    
    func clear() {
        state = .empty
        songs = []
    }
    
    func loadMore() {
        fetchSongs(for: searchTerm)
    }
    
    func fetchSongs(for searchTerm: String) {
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.empty else {
            return
        }
        
        state = .isLoding
        
        songservice.fetchSongs(searchTerm: searchTerm, page: page, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    for song in results.results {
                        self?.songs.append(song)
                    }
                    self?.page += 1
                    self?.state = (results.results.count == self?.limit) ? .empty : .loadedAll
                    print("Fetched Songs: \(results.resultCount)")
                    
                case.failure(let error):
                    print("Could not Load Songs: \(error)")
                    self?.state = .error("Could not Load Songs: \(error.localizedDescription)")
                }
                
            }
        }
        
    }
    
    static func example() -> SongViewModel {
        let vm = SongViewModel()
        vm.songs = [SongModel.example()]
        return vm
    }
}
