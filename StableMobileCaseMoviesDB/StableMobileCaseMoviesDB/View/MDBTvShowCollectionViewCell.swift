//
//  MBDTvShowCollectionViewCell.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit
import SnapKit

final class MDBTvShowCollectionViewCell: UICollectionViewCell {
    
    //:MARK: UI Proporties
    static let identifier = "MBDTvShowCollectionViewCell"
    
    //MARK: UI Elements
    
    // Show image view
    public let showImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Show name label
    private let showNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    // Show vote average header label
    private let showVoteAverageHeader : UILabel = {
        let label = UILabel()
        label.text = "Show's Average Vote"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // Show vote average label
    private let showVoteAverageLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    //MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(showImageView,showNameLabel,showVoteAverageHeader,showVoteAverageLabel)
        addViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    // Configures the cell with the given view model
    public func configureCell(with viewModel : MDBTvShowCollectionViewCellViewModel) {
        
        // Set the show name label text
        if let showName = viewModel.showName {
            showNameLabel.text = showName
        } else {
            showNameLabel.text = "Empty Name"
        }
        
        // Set the show vote average label text
        if let showVoteAverage = viewModel.showVoteAverage {
            showVoteAverageLabel.text = String(describing: showVoteAverage)
        } else {
            showVoteAverageLabel.text = "Average not found"
        }
        
        // Fetch the show image and set it to the image view
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
    
    // Add view constraints using SnapKit
    
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
            make.top.equalTo(showVoteAverageHeader.snp.bottom).offset(-15)
            make.left.equalTo(showImageView.snp.right)
        }
    }
    

}
