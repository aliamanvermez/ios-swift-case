//
//  MBDTvShowListViewViewModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 11.04.2023.
//

import Foundation
import UIKit

final class MDBTvShowListViewViewModel: NSObject{
    private var tvShows : [MDBPopularShow] = []
    
    private var cellViewModel : [MDBTvShowCollectionViewCellViewModel] = []
}


extension MDBTvShowListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MDBTvShowCollectionViewCell.identifier, for: indexPath) as? MDBTvShowCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        return cell
    }
    
    
}
