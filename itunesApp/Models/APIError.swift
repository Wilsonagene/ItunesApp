//
//  APIError.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import Foundation


enum APIError: Error, CustomStringConvertible {
    
    case BadUrl
    case urlSession(URLError?)
    case badRespons(Int)
    case decoding(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
        case .BadUrl:
            return "BadURl"
        case .urlSession(let error):
            return "urlsession error: \(error.debugDescription)"
        case .badRespons(let statusCde):
            return "Bad response with StatusCode \(statusCde)"
        case .decoding(let decodingError):
            return "decoding Error: \(String(describing: decodingError)) "
        case .unknown:
            return "unknown error"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .BadUrl, .unknown:
            return "somthing went wrong"
        case .urlSession(let uRLError):
            return uRLError?.localizedDescription ?? "somthing went wrong"
        case .badRespons(_):
            return "somthing went wrong"
        case .decoding(let decodingError):
            return decodingError?.localizedDescription ?? "Error🥲"
        
        }
    }
    
}
