//
//  ViewController.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit

class MDBShowListViewController: UIViewController, MDBShowListViewDelegate {
    
    
    //:MARK: UI Elements
    let showListView = MDBTvShowListView()

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
        configureNavigationController()
    }
    //MARK: Functions
    func setUpView() {
        view.backgroundColor = .black
        view.addSubview(showListView)
        showListView.delegate = self
        showListView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    func configureNavigationController(){
        title = "The MovieDB Shows"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    //MARK: MDBTvShowListViewDelegate
    func mdbShowListView(_ showListView: MDBTvShowListView, didSelectShow show: MDBPopularShow) {
        //Open another view controller for that show
        let viewModel = MDBTvShowListDetailViewViewModel(show: show)
        let detailVC = MDBShowDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
 



}

