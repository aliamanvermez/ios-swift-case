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
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let showVoteAverageHeader : UILabel = {
        let label = UILabel()
        label.text = "Show's Average Vote"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let showVoteAverageLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(showImageView,showNameLabel,showVoteAverageHeader,showVoteAverageLabel)
        addViewConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with viewModel : MDBTvShowCollectionViewCellViewModel) {
        
        if let showName = viewModel.showName {
            showNameLabel.text = showName
        } else {
            showNameLabel.text = "Empty Name"
        }
        
        if let showVoteAverage = viewModel.showVoteAverage {
            showVoteAverageLabel.text = String(describing: showVoteAverage)
        } else {
            showVoteAverageLabel.text = "Average not found"
        }
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.showImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
            
    }
    
    func addViewConstraints(){
        showImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalToSuperview()
            make.top.equalToSuperview()
        }

        showNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalToSuperview().offset(30)
            make.left.equalTo(showImageView.snp.right)
        }
        
        showVoteAverageHeader.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalTo(showNameLabel.snp.bottom)
            make.left.equalTo(showImageView.snp.right)
        }
        
        showVoteAverageLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalTo(showVoteAverageHeader.snp.bottom)
            make.left.equalTo(showImageView.snp.right)
        }
    }
    

}
