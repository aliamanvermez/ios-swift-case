//
//  MBDTvShowListViewViewModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 11.04.2023.
//

import Foundation
import UIKit

protocol MDBTvShowListViewViewModelDelegate: AnyObject {
    func didFetchShows()
    func didSelectShow(_ show : MDBPopularShow)
    
}

final class MDBTvShowListViewViewModel: NSObject{
    
    private var tvShows : [MDBPopularShow] = [] {
        didSet {
            for tvShow in tvShows {
                let viewModel = MDBTvShowCollectionViewCellViewModel(showName: tvShow.name, showImageURL: tvShow.posterURL, showVoteAverage: tvShow.voteAverage, showID: tvShow.id)
                cellViewModel.append(viewModel)
            }
        }
    }
    
    public weak var delegate : MDBTvShowListViewViewModelDelegate?
    private var cellViewModel : [MDBTvShowCollectionViewCellViewModel] = []
    
    func fetchShows(){
        let request = MDBRequest()
        request.requestPopularTvShows { models, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let models = models {
                self.tvShows = models.results!
                DispatchQueue.main.async {
                    self.delegate?.didFetchShows()

                }
            }
        }
    }
}

extension MDBTvShowListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MDBTvShowCollectionViewCell.identifier, for: indexPath) as? MDBTvShowCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        let viewModel = cellViewModel[indexPath.row]
        cell.configureCell(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16)
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showID = cellViewModel[indexPath.row].showID
        let request = MDBRequest()
        request.requestTvShowDetails(for: showID) { tvShowDetail, error in
            if let tvShowDetail = tvShowDetail {
                print(tvShowDetail.name)
            }else{
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    
}
