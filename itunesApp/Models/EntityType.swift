//
//  EntityType.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import Foundation


enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    case movie
    
    var id: String {
        self.rawValue
    }
    
    func name() -> String {
        switch self {
        case .all:
            return "All"
        case .album:
            return "Albums"
        case .song:
            return "Songs"
        case .movie:
            return "movie"
        }
    }
    
}
