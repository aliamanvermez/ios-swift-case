//
//  MBDTvShowListViewViewModel.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 11.04.2023.
//

import Foundation
import UIKit

//// This protocol defines the delegate methods for the MDBTvShowListViewViewModel to notify its delegate of important events.
protocol MDBTvShowListViewViewModelDelegate: AnyObject {
    
    // Notifies the delegate that the shows have been loaded and are ready to be displayed.
    func didLoadShows()
    // Notifies the delegate that a show has been selected.
    func didSelectShow(_ show : MDBPopularShow)
    
}
 ///View model to handle show list logic
final class MDBTvShowListViewViewModel: NSObject{
    // An array of MDBPopularShow objects to store the loaded shows.
    // When the array of shows is set, create an array of MDBTvShowCollectionViewCellViewModel objects to represent each show
    private var tvShows : [MDBPopularShow] = [] {
        didSet {
            for tvShow in tvShows {
                let viewModel = MDBTvShowCollectionViewCellViewModel(
                    showName: tvShow.name,
                    showImageURL: tvShow.posterURL,
                    showVoteAverage: tvShow.voteAverage,
                    showID: tvShow.id)
                    cellViewModel.append(viewModel)
            }
        }
    }
    
    public weak var delegate : MDBTvShowListViewViewModelDelegate?
    // An array of MDBTvShowCollectionViewCellViewModel objects to represent each show.
    private var cellViewModel : [MDBTvShowCollectionViewCellViewModel] = []
    
    // This function is used to fetch the TV shows from the API.
    func fetchShows(){
        MDBService.shared.execute(.listShowsRequest, expecting: MDBPopularShowResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.tvShows = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadShows()
                }
            case .failure(let error):
                print(String(describing: error.localizedDescription))
            }
        
        }
    }
    

}

//MARK: CollectionView
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
        cell.backgroundColor = .systemGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16)
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let show = tvShows[indexPath.row]
        delegate?.didSelectShow(show)
    }
    
    
}
