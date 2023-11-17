//
//  AlbumViewModel.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 13/11/2023.
//

// https://itunes.apple.com/search?term=jack+johnson&entity=album&lmit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5


import Foundation
import Combine


class AlbumViewModel: ObservableObject {
    
 
    
    @Published var searchTerm: String = ""
    @Published var albums: [AlbumModel] = [AlbumModel]()
    
    @Published var state: FetchState = .empty 
    
    let limit: Int = 20
    
    var page: Int = 0
    
    let service = APIService()
    var subcriptions = Set<AnyCancellable>()
    
    init() {
        
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .empty
                self?.albums = []
            self?.fetchAlbum(for: term)
        }.store(in: &subcriptions)
        
//        return
    }
    
    
//@ViewBuilder
    
    
    
    func fetchAlbum(for searchTerm: String) {
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.empty else {
            return
        }
        
        state = .isLoding
        
        service.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    for album in results.results {
                        self?.albums.append(album)
                    }
                    self?.page += 1
                    self?.state = (results.results.count == self?.limit) ? .empty : .loadedAll
                    print("Fetched Albums: \(results.resultCount)")
                    
                case.failure(let error):
                    print("Could not Load Album: \(error)")
                    self?.state = .error("Could not Load Album: \(error.localizedDescription)")
                }
            }
        }
    }
    func loadMore() {
        fetchAlbum(for: searchTerm)
    }
    
    static func example() -> AlbumViewModel {
        let vm = AlbumViewModel()
        vm.albums = [AlbumModel.example()]
        return vm
    }
    
}




// -----------------------
//URLSession.shared.dataTask(with: url) { [weak self] data, result, error in
//    
//    if let error = error {
//        print("urlsession error \(error.localizedDescription)")
//        DispatchQueue.main.async {
//            
//        }
//    } else if  let data = data {
//        
//        do  {
//            let result = try JSONDecoder().decode(AlbumResult.self, from: data)
//            DispatchQueue.main.async {
//                for album in result.results {
//                    self?.albums.append(album)
//                }
//                self?.page += 1
//                self?.state = (result.results.count == self?.limit) ? .empty : .loadedAll
//            }
//        } catch {
//            print("Decoding Error \(error)")
//            DispatchQueue.main.async {
//                self?.state = .error("Could Not Get Data: \(error.localizedDescription)")
//            }
//        }
//        
//    }
//    
//    
//} .resume()
