//
//  MDBShowDetailViewController.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import UIKit
import SnapKit
class MDBShowDetailViewController: UIViewController {
    private let viewModel : MDBTvShowListDetailViewViewModel
    private let detailView = MDBTvShowDetailView()
    init(viewModel: MDBTvShowListDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(detailView)
        setUpView()
        fetchData()
    }
    func setUpView(){
        detailView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    
     private func fetchData() {
         viewModel.fetchShowDetail { [weak self] in
             self?.updateUI()
         }
     }
     
     private func updateUI() {
         detailView.configure(with: viewModel)
     }
 
    

}
