//
//  MDBPopularShowModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation

struct MDBPopularShowResponse: Codable {
 
        let page: Int?
        let results: [MDBPopularShow]
        let totalPages, totalResults: Int?
        
        enum CodingKeys: String, CodingKey {
            case page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
}
