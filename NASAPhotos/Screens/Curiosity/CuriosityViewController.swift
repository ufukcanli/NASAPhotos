//
//  CuriosityViewController.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

class CuriosityViewController: UIViewController {
    
    private let curiosityViewModel = CuriosityViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCuriosityViewModelObservers()
        
        curiosityViewModel.performRequest { error in
            if let error = error {
                print(error.rawValue)
                return
            }
            
            print(self.curiosityViewModel.photos)
        }
    }
    
    private func setupCuriosityViewModelObservers() {
        curiosityViewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            isLoading ? print("Loading...") : print("Done.")
        }
    }

}
