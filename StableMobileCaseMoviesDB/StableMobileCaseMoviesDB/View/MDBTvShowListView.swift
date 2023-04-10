//
//  MBDTvShowListView.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit
import SnapKit

class MDBTvShowListView: UIView {
    
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
        addSubviews(spinner,collectionView,header)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSnapkitConstraints() {
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.top.equalToSuperview()
        }
    }
    
    private func setUpCollectionView(){
        
    }
    
}
