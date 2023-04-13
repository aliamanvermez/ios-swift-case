//
//  MDBShowDetailViewViewModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import Foundation

final class MDBTvShowListDetailViewViewModel {
    private let show: MDBPopularShow
    public var showDetail: MDBTvShowDetail?
    
    init(show: MDBPopularShow) {
        self.show = show
    }
    
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

