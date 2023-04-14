//
//  UIView+Extensions.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation
import UIKit.UIView

//MARK: Extension

//It adds a method called "addSubviews" that takes in a variable number of UIView objects as arguments.
extension UIView{
    func addSubviews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}
