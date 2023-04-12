//
//  MBDTvShowListView.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit
import SnapKit

protocol MDBShowListViewDelegate: AnyObject {
    func mdbShowListView(_ filmListView: MDBTvShowListView, didSelectCharacter film: MDBPopularShow)
}


final class MDBTvShowListView: UIView {
    
    public weak var delegate : MDBShowListViewDelegate?
    private let viewModel =  MDBTvShowListViewViewModel()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .red
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.fetchShows()
        viewModel.delegate = self
        addSubviews(collectionView)
        setUpCollectionView()
        createSnapkitConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSnapkitConstraints() {
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
            make.top.equalToSuperview()
        }
    }
    
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        collectionView.register(MDBTvShowCollectionViewCell.self, forCellWithReuseIdentifier: MDBTvShowCollectionViewCell.identifier)
    }
    
}

extension MDBTvShowListView : MDBTvShowListViewViewModelDelegate {
    func didFetchShows() {
        self.collectionView.reloadData()
    }
    
    func didSelectShow(_ character: MDBPopularShow) {
        delegate?.mdbShowListView(self, didSelectCharacter: character)
    }
    
    
}
