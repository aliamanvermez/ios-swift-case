//
//  MDBRequest.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import Foundation

class MDBRequest {
    enum EndpointType {
        case popularTvShows(page: Int)
        case tvShowDetails(showID: Int)
    }
    
    static let apiKey = "7a677ab38828aa11bb94764c35a09bf8"
    
    let endpointType: EndpointType
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: String {
        switch endpointType {
        case .popularTvShows:
            return "tv/popular"
        case .tvShowDetails(let showID):
            return "tv/\(showID)"
        }
    }
    
    var parameters: [String: String] {
        switch endpointType {
        case .popularTvShows(let page):
            return ["api_key": MDBRequest.apiKey, "page": "\(page)"]
        case .tvShowDetails:
            return ["api_key": MDBRequest.apiKey]
        }
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL + endpoint)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url!
    }
    
    init(endpointType: EndpointType) {
        self.endpointType = endpointType
    }
}

extension MDBRequest{
    static let listShowsRequest = MDBRequest(endpointType: .popularTvShows(page: 1))
    static func detailRequest(for showID: Int) -> MDBRequest {
          return MDBRequest(endpointType: .tvShowDetails(showID: showID))
      }
}
