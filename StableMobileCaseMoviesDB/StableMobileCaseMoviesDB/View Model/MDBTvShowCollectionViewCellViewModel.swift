//
//  MBDTvShowCollectionViewCellViewModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 11.04.2023.
//

import Foundation

final class MDBTvShowCollectionViewCellViewModel {
    public let showName : String?
    public let showImageURL : String?
    public let showVoteAverage : Double?
    
    init(showName: String?, showImageURL: String?, showVoteAverage: Double?) {
        self.showName = showName
        self.showImageURL = showImageURL
        self.showVoteAverage = showVoteAverage
    }
}
