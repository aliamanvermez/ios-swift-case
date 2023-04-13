//
//  MDBTvShowDetailView.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import UIKit
import SnapKit

protocol MDBShowDetailViewDelegate: AnyObject {
    func mdbShowDetailView(_ showListView: MDBTvShowDetailView, didSelectShow show: MDBTvShowDetail)
}

class MDBTvShowDetailView: UIView {
    
    public let showImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let showTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .blue
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let showGenreLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .brown
        
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let showSeasonCountLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .green
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let showTotalEpisodesLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .orange
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let showAddFavoriteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Add Favorite", for: .normal)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(showImageView,showTitleLabel,showGenreLabel,showSeasonCountLabel,showTotalEpisodesLabel,showAddFavoriteButton)
        createSnapkitConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel : MDBTvShowListDetailViewViewModel ) {
        DispatchQueue.main.async {
            
            if let showTitle = viewModel.showDetail?.name {
                self.showTitleLabel.text = showTitle
            }else {
                self.showTitleLabel.text = "Show not found"
            }
            
            if let showGenre = viewModel.genres?.first?.name {
                self.showGenreLabel.text = showGenre
            }else{
                self.showGenreLabel.text = "Genre not found"
            }
            
            if let showSeasonCount = viewModel.showDetail?.numberOfSeasons {
                self.showSeasonCountLabel.text = String(describing: showSeasonCount)
            } else{
                self.showSeasonCountLabel.text = "Season not found"
            }
            
            if let showTotalEpisodes = viewModel.showDetail?.numberOfEpisodes {
                self.showTotalEpisodesLabel.text = String(describing: showTotalEpisodes)
            }else{
                self.showTotalEpisodesLabel.text = "Episode not found"
            }
            
            viewModel.fetchShowImage { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self?.showImageView.image = image
                    }
                case .failure(let error):
                    print(String(describing: error))
                    break
                }
            }
        }
 
    }
    
    func createSnapkitConstraints(){
        showImageView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(230)
            make.top.equalToSuperview().offset(20)
        }
        showTitleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-150)
            make.left.equalTo(showImageView.snp.right)
            make.height.equalTo(50)
            make.top.equalTo(showImageView.snp.top).offset(30)
        }
        
        showGenreLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-150)
            make.left.equalTo(showImageView.snp.right)
            make.height.equalTo(50)
            make.top.equalTo(showTitleLabel.snp.bottom).offset(10)
        }
        
        showSeasonCountLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-150)
            make.left.equalTo(showImageView.snp.right)
            make.height.equalTo(50)
            make.top.equalTo(showGenreLabel.snp.bottom).offset(10)
        }
        
        showTotalEpisodesLabel.snp.makeConstraints { make in
            make.top.equalTo(showImageView.snp.bottom).offset(20)
            make.left.equalTo(showImageView.snp.left)
            make.width.equalToSuperview().offset(-150)
            make.height.equalTo(30)
        }
        
    }
    
    
    
}
