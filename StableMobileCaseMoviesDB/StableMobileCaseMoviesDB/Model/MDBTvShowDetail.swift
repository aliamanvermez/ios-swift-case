//
//  MBDTvShowDetail.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation

struct MDBTvShowDetail: Codable {
   
    let genres: [Genre]?
    let name: String?
    let numberOfEpisodes : Int?
    let numberOfSeasons: Int?
    let posterPath: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case genres
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case posterPath = "poster_path"
        case overview

    }
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}

extension MDBTvShowDetail {
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}


