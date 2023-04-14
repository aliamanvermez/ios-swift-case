//
//  MDBShowDetailViewController.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 12.04.2023.
//

import UIKit
import SnapKit
import CoreData
class MDBShowDetailViewController: UIViewController {
    //MARK: UI Elements
    private let viewModel : MDBTvShowListDetailViewViewModel
    private let detailView = MDBTvShowDetailView()
    //:MARK: UI Proporties
    
    //MARK: Initialization
    init(viewModel: MDBTvShowListDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(detailView)
        setUpView()
        fetchData()
        fetchFavorites()
    }
    //MARK: Functions
    func setUpView(){
        navigationItem.largeTitleDisplayMode = .never
        detailView.backgroundColor = .black
        view.backgroundColor = .black
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
    // This function fetches all the favorite TV shows from Core Data using a NSFetchRequest.
   private func fetchFavorites(){
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       let context = appDelegate.persistentContainer.viewContext
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TVShow")
       fetchRequest.returnsObjectsAsFaults = false
       do {
           let result = try context.fetch(fetchRequest)
           for data in result as! [NSManagedObject] {
            print(data.value(forKey: "title") as! String)
           }
       } catch {
           print("Failed")
       }
   }

}
