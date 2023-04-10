//
//  MBDTvShowCollectionViewCell.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit
import SnapKit
final class MDBTvShowCollectionViewCell: UICollectionViewCell {
    static let identifier = "MBDTvShowCollectionViewCell"
    
    public let showImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let showNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let showVoteAverageLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(showImageView,showNameLabel,showVoteAverageLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewConstraints(){
        showImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalToSuperview()
            make.top.equalToSuperview()
        }
        showNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalToSuperview()
            make.left.equalTo(showImageView.snp.right)
        }
        
        showVoteAverageLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalTo(showNameLabel.snp.bottom)
            make.left.equalTo(showImageView.snp.right)
        }
    }
    

}
