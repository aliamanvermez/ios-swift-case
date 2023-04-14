//
//  MDBRequest.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import Foundation

class MDBRequest {
    // Defines the types of endpoints that this class can handle
    enum EndpointType {
        case popularTvShows(page: Int)
        case tvShowDetails(showID: Int)
    }
    
    // The API key for The Movie Database
    static let apiKey = "7a677ab38828aa11bb94764c35a09bf8"
    
    // The type of endpoint for this request
    let endpointType: EndpointType
    
    // The base URL for The Movie Database API
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    // The endpoint string for this request
    var endpoint: String {
        switch endpointType {
        case .popularTvShows:
            return "tv/popular"
        case .tvShowDetails(let showID):
            return "tv/\(showID)"
        }
    }
    
    // The parameters to be included in the request URL
    var parameters: [String: String] {
        switch endpointType {
        case .popularTvShows(let page):
            return ["api_key": MDBRequest.apiKey, "page": "\(page)"]
        case .tvShowDetails:
            return ["api_key": MDBRequest.apiKey]
        }
    }
    
    // The complete URL for this request
    var url: URL? {
        var components = URLComponents(string: baseURL + endpoint)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url!
    }
    
    // Initializes a new MDBRequest object with the given endpoint type
    init(endpointType: EndpointType) {
        self.endpointType = endpointType
    }
}

// Predefined requests for popular TV shows and TV show details
extension MDBRequest{
    static let listShowsRequest = MDBRequest(endpointType: .popularTvShows(page: 1))
    static func detailRequest(for showID: Int) -> MDBRequest {
        return MDBRequest(endpointType: .tvShowDetails(showID: showID))
    }
}
