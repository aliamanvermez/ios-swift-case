//
//  ViewController.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit

class MDBShowListViewController: UIViewController, MDBShowListViewDelegate {
    
    let showListView = MDBTvShowListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    func setUpView() {
        showListView.delegate = self
        view.addSubview(showListView)
        showListView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    //MARK: MDBTvShowListViewDelegate
    func mdbShowListView(_ showListView: MDBTvShowListView, didSelectShow show: MDBPopularShow) {
        //Open another view controller for that show
        let viewModel = MDBTvShowListDetailViewViewModel(show: show)
        let detailVC = MDBShowDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
 



}

