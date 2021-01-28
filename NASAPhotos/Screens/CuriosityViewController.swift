//
//  CuriosityViewController.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

class CuriosityViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var photos = [NASAPhoto]()
    private var isLoading = false
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performRequest()
        
        configureViewController()
    }
    
    private func performRequest() {
        isLoading = true
        NASADataManager.shared.getCuriosityPhotos { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let results):
                self.photos = results.photos
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func configureViewController() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: NASAHelper.createThreeColumnFlowLayout(in: view))
        collectionView.register(CuriosityCell.self, forCellWithReuseIdentifier: CuriosityCell.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

}

// MARK: - UICollectionViewDataSource

extension CuriosityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CuriosityCell.reuseIdentifier, for: indexPath) as! CuriosityCell
        return cell
    }
}
