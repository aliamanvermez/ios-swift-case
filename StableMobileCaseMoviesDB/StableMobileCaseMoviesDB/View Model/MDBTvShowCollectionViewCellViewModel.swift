//
//  MBDTvShowCollectionViewCellViewModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 11.04.2023.
//

import Foundation

final class MDBTvShowCollectionViewCellViewModel {
    public let showName : String?
    public let showImageURL : URL?
    public let showVoteAverage : Double?
    public let showID : Int?
    
    init(showName: String?, showImageURL: URL?, showVoteAverage: Double?, showID: Int?) {
        self.showName = showName
        self.showImageURL = showImageURL
        self.showVoteAverage = showVoteAverage
        self.showID = showID
    }
    
    public func fetchImage(completion : @escaping (Result <Data, Error>) -> Void) {
        guard let url = showImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
