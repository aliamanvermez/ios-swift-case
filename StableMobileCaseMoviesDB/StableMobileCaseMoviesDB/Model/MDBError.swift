//
//  MDBError.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation

enum MDBServiceError: Error {
    case noData
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Error while decoding the server response."
        }
    }
}
