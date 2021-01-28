//
//  CuriosityViewController.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class CuriosityViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

}

// MARK: UICollectionViewDataSource

extension CuriosityViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}
