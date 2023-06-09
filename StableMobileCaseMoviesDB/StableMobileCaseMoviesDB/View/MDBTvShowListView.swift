//
//  MBDTvShowListView.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit
import SnapKit

/// This is the implementation of a custom view called MDBTvShowListView

/// It adopts the MDBShowListViewDelegate protocol to allow for communication with its delegate object
protocol MDBShowListViewDelegate: AnyObject {
    func mdbShowListView(_ showListView: MDBTvShowListView, didSelectShow show: MDBPopularShow)
}


final class MDBTvShowListView: UIView {
    
    //MARK: UI Proporties
    public weak var delegate : MDBShowListViewDelegate?
   
    ///A private viewModel object of type MDBTvShowListViewViewModel
    private let viewModel =  MDBTvShowListViewViewModel()
    
    //MARK: UI Elements
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .red
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.backgroundColor = .black
        collectionView.alpha = 0
        layout.scrollDirection = .vertical
        return collectionView
    }()
    
    var header : UILabel = {
        let label = UILabel()
        label.text = "Tv Shows"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    

    //MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinner.startAnimating()
        viewModel.delegate = self
        addSubviews(collectionView,spinner)
        createSnapkitConstraints()
        viewModel.fetchShows()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    private func createSnapkitConstraints() {
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        spinner.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        collectionView.register(MDBTvShowCollectionViewCell.self, forCellWithReuseIdentifier: MDBTvShowCollectionViewCell.identifier)
    }
    
}
//MARK: Extension

// The extension adopts the MDBTvShowListViewViewModelDelegate protocol to handle the viewModel's updates
// When shows have been loaded, the spinner stops animating and the collectionView is displayed with a fade-in animation.

extension MDBTvShowListView : MDBTvShowListViewViewModelDelegate {
    func didLoadShows() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            self.collectionView.reloadData() //Initial fetch
            UIView.animate(withDuration: 0.4){
                self.collectionView.alpha = 1
            }
        }
    }
    func didSelectShow(_ character: MDBPopularShow) {
        delegate?.mdbShowListView(self, didSelectShow: character)
    }
    
    
}
