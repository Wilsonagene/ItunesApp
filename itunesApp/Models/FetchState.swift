//
//  FetchState.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import Foundation


enum FetchState: Comparable {
    case empty
    case isLoding
    case loadedAll
    case error(String)
}
