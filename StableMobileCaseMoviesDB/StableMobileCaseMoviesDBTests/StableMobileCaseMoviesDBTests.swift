//
//  StableMobileCaseMoviesDBTests.swift
//  StableMobileCaseMoviesDBTests
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import XCTest
@testable import StableMobileCaseMoviesDB

final class StableMobileCaseMoviesDBTests: XCTestCase {

    func testFetchImage() {
            let viewModel = MDBTvShowCollectionViewCellViewModel(showName: "Test Show", showImageURL: URL(string: "https://www.example.com/image.png"), showVoteAverage: 8.0, showID: 1234)
            let expectation = self.expectation(description: "Image fetched successfully")
            
            viewModel.fetchImage { result in
                switch result {
                case .success(let imageData):
                    XCTAssertNotNil(imageData, "Image data should not be nil")
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Failed to fetch image: \(error.localizedDescription)")
                }
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }
    
    
    func testAddSubviews() {
        let view1 = UIView()
        let view2 = UIView()
        
        let parentView = UIView()
        parentView.addSubviews(view1, view2)
        
        XCTAssertTrue(parentView.subviews.contains(view1), "View1 should be added as subview")
        XCTAssertTrue(parentView.subviews.contains(view2), "View2 should be added as subview")
    }

}
