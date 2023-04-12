//
//  ViewController.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit

class MDBShowListViewController: UIViewController {
    let showListView = MDBTvShowListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(showListView)
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        createSnapkit()
    }
    
    func createSnapkit() {

        showListView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
 



}

