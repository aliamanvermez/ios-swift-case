//
//  MDBEndpoint.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import Foundation

enum MDBEndpoint {
    case popularTvShows(page: Int)
    case tvShowDetails(showID: Int)
    
    static let apiKey = "7a677ab38828aa11bb94764c35a09bf8"
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: String {
        switch self {
        case .popularTvShows:
            return "tv/popular"
        case .tvShowDetails(let showID):
            return "tv/\(showID)"
        }
    }
    
    var parameters: [String: String] {
           switch self {
           case .popularTvShows(let page):
               return ["api_key": MDBEndpoint.apiKey, "page": "\(page)"]
           case .tvShowDetails:
               return ["api_key": MDBEndpoint.apiKey]
           }
       }
    
    var url: URL {
        var components = URLComponents(string: baseURL + endpoint)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url!
    }
    
}
