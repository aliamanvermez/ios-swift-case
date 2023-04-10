//
//  ViewController.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = MDBRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchFilms()
    }
    
    func fetchFilms(){
        let request = MDBRequest()
        request.requestPopularTvShows { models, error in
            if let error = error {
                print("Error fetching films: \(error.localizedDescription)")
                
            }
            else if let models = models {
               
            }
        }
    }



}

