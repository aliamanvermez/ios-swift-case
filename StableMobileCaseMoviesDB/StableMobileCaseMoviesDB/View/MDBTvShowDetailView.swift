//
//  MDBTvShowDetailView.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import UIKit
import SnapKit
import CoreData
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
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let showGenreLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let showSeasonCountLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let showTotalEpisodesLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let showDescriptionHeader : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let showDescriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 10
        return label
    }()
    
    private let showAddFavoriteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setTitle("Add Favorite", for: .normal)
        button.addTarget(self, action: #selector(showAddFavoriteButtonClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func showAddFavoriteButtonClicked(){
        print("tıklandı")
        showAddFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let tvShow = NSEntityDescription.insertNewObject(forEntityName: "TVShow", into: context)
        tvShow.setValue(showTitleLabel.text!, forKey: "title")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TVShow")
        fetchRequest.predicate = NSPredicate(format: "title = %@", showTitleLabel.text!)

        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults, results.count > 0 {
                // Daha önce aynı veri kaydedilmiş, işlem yapılmayacak
                print("Bu veri zaten kaydedilmiş.")
                showAddFavoriteButton.isEnabled = false
            } else {
                // Yeni veri kaydediliyor
                try context.save()
            }
        } catch {
            print("Veri kaydedilemedi. Hata: \(error)")
        }
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(showImageView,showTitleLabel,showGenreLabel,showSeasonCountLabel,showTotalEpisodesLabel,showDescriptionHeader,showDescriptionLabel,showAddFavoriteButton)
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
                self.showGenreLabel.text = "Genre\n\(showGenre)"
            }else{
                self.showGenreLabel.text = "Genre not found"
            }
            
            if let showSeasonCount = viewModel.showDetail?.numberOfSeasons {
                self.showSeasonCountLabel.text = "Seasons\n\(showSeasonCount)"
            } else{
                self.showSeasonCountLabel.text = "Season not found"
            }
            
            if let showTotalEpisodes = viewModel.showDetail?.numberOfEpisodes {
                self.showTotalEpisodesLabel.text = "Episodes\n\(showTotalEpisodes)"
            }else{
                self.showTotalEpisodesLabel.text = "Episode not found"
            }
            
            self.showDescriptionHeader.text = "Description"
            
            if let showDescription = viewModel.showDetail?.overview {
                self.showDescriptionLabel.text = showDescription
            }else {
                self.showDescriptionLabel.text = "Description not found."
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
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
        }
        showTitleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-150)
            make.left.equalTo(showImageView.snp.right)
            make.height.equalTo(50)
            make.top.equalTo(showImageView.snp.top)
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
            make.width.equalToSuperview().offset(-150)
            make.left.equalTo(showImageView.snp.right)
            make.height.equalTo(50)
            make.top.equalTo(showSeasonCountLabel.snp.bottom).offset(10)
        }
        
        showDescriptionHeader.snp.makeConstraints { make in
            make.top.equalTo(showImageView.snp.bottom).offset(20)
            make.left.equalTo(showImageView.snp.left)
            make.width.equalToSuperview().offset(-150)
            make.height.equalTo(30)
        }
        
        showDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(100)
            make.top.equalTo(showDescriptionHeader.snp.bottom)
            
        }
        
        showAddFavoriteButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(showDescriptionLabel.snp.bottom)
            make.left.equalToSuperview().offset(30)
        }
        
    }
    
    
    
}
