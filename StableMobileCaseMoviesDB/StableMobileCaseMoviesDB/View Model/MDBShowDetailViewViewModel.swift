//
//  MDBShowDetailViewViewModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import Foundation

///View model for displaying details of a TV show.
final class MDBTvShowListDetailViewViewModel {
    public let show: MDBPopularShow
    public var showDetail: MDBTvShowDetail?
    
    init(show: MDBPopularShow) {
        self.show = show
    }
    
    // The 'fetchShowDetail' method fetches the detailed information of the TV show using a network request and stores it in 'showDetail'.
    func fetchShowDetail(completion: @escaping () -> Void) {
        MDBService.shared.execute(.detailRequest(for: show.id!), expecting: MDBTvShowDetail.self) { [weak self] result in
            switch result {
            case .success(let showDetail):
                self?.showDetail = showDetail
                completion()
            case .failure(let error):
                print(String(describing: error.localizedDescription))
            }
        }
    }
    // The 'fetchShowImage' method fetches the image of the TV show using a network request and returns it in the completion handler.
    public func fetchShowImage(completion : @escaping (Result <Data, Error>) -> Void) {
        let showImageURL = URL(string: show.posterURL?.absoluteString ?? "no image")
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
    
    var name: String? {
        return showDetail?.name
    }
    
    var posterURL: URL? {
        return showDetail?.posterURL
    }
    
    var numberOfEpisodes: Int? {
        return showDetail?.numberOfEpisodes
    }
    
    var numberOfSeasons: Int? {
        return showDetail?.numberOfSeasons
    }
    
    var genres: [Genre]? {
        return showDetail?.genres
    }
}

