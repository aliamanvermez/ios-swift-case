//
//  MDBPopulerShowModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation

/// This is a struct that conforms to the Codable protocol.
/// It represents a popular TV show returned by the Movie Database API.

struct MDBPopularShow: Codable {
    
    let genreIDS: [Int]? //genre
    let id: Int? //id
    let name: String? //name
    let posterPath: String? //image
    let voteAverage: Double? //average rating
    
    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id, name
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    var detailURL: URL? {
        guard let id = id else {
            return nil
        }
        return URL(string: "https://api.themoviedb.org/3/tv/\(id)?api_key=API_KEY")
    }
}

extension MDBPopularShow {
    //converting to path to url
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}


