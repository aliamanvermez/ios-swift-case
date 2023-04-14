//
//  MBDTvShowDetail.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation

struct MDBTvShowDetail: Codable {
   /*
    This code defines a struct called MDBTvShowDetail which conforms to the Codable protocol.
    The struct represents details about a TV show from the Movie Database API.
    The struct contains properties such as the genres of the show, its name, the number of episodes and seasons, a poster path, and an overview.
    The struct also defines a nested struct called Genre, which represents a genre of the TV show.
    The struct has an extension that adds a computed property called posterURL, which returns a URL for the poster image of the TV show.
    */
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


