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
    private var currentPage = 1
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        performRequest(withCurrentPage: currentPage)
    }
    
    private func performRequest(withCurrentPage currentPage: Int) {
        isLoading = true
        self.showLoadingView()
        NASADataManager.shared.getCuriosityPhotos(withCurrentPage: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                self.photos.append(contentsOf: results.photos)
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                print(error.rawValue)
            }
            self.isLoading = false
            DispatchQueue.main.async {
                self.hideLoadingView()
            }
        }
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

extension CuriosityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NASAPhotoCell.reuseIdentifier, for: indexPath) as! NASAPhotoCell
        cell.updateCell(withPhoto: photos[indexPath.item])
        return cell
    }
}

extension CuriosityViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard !isLoading else { return }
            currentPage += 1
            performRequest(withCurrentPage: currentPage)
        }
    }
}
