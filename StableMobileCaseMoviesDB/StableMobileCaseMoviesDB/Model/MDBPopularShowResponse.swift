//
//  MDBPopularShowModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation

/// This is a struct representing the response returned by the Movie Database API for a request for popular TV shows.

struct MDBPopularShowResponse: Codable {
    
    let page: Int? // The page number of the current response
    let results: [MDBPopularShow]  // An array of MDBPopularShow objects representing the popular TV shows returned in this response
    let totalPages, totalResults: Int? // The total number of pages and total number of results available in the API
    
    // The CodingKeys enum is used here to map the keys in the JSON response to the properties in this struct.
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
