//
//  MDBError.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation

// This is an enum that represents the possible errors that can occur during a request to the server.
enum MDBServiceError: Error {
    case noData
    case decodingError
    
    // This computed property returns a string message that can be used to display the error to the user.
    var localizedDescription: String {
        switch self {
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Error while decoding the server response."
        }
    }
}
