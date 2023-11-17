//
//  MovieViewModel.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var movies: [MovieModel] = [MovieModel]()
    @Published var state: FetchState = .empty
    
    private let movieservice = APIService()
    
    let defaultLimits = 50
    
    var subcriptions = Set<AnyCancellable>()
    
    init() {
        
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
            self?.fetchMovies(for: term)
        }.store(in: &subcriptions)
        
//        return
    }
    
    func clear() {
        state = .empty
        movies = []
    }
    func fetchMovies(for searchTerm: String) {
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.empty else {
            return
        }
        
        state = .isLoding
        
        movieservice.fetchMovies(searchTerm: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.movies = results.results
                    if results.resultCount == self?.defaultLimits {
                        self?.state = .empty
                    } else {
                        self?.state =  .loadedAll
                    }
                    
                    print("Fetched Movies: \(results.resultCount)")
                    
                case.failure(let error):
                    print("Could not LoadMoives: \(error)")
                    self?.state = .error("Could not Load: \(error.localizedDescription)")
                }
            }
        }
        
    }
    func loadMore() {
        fetchMovies(for: searchTerm)
    }
    
    static func example() -> MovieViewModel {
        let vm = MovieViewModel()
        vm.movies = [MovieModel .example()]
        return vm
    }
    
}
