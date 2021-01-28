//
//  OpportunityViewController.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

class OpportunityViewController: UIViewController {
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }

    private func configureViewController() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: NASAHelper.createThreeColumnFlowLayout(in: view))
        collectionView.register(NASAPhotoCell.self, forCellWithReuseIdentifier: NASAPhotoCell.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}

extension OpportunityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NASAPhotoCell.reuseIdentifier, for: indexPath) as! NASAPhotoCell
        return cell
    }
}
