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
    private var isFiltered = false
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureViewController()
        performRequest(byPage: currentPage)
    }
    
    @objc func filterButtonDidTap() {
        let cameraViewController = NASACameraViewController()
        cameraViewController.delegate = self
        present(cameraViewController, animated: true, completion: nil)
    }
    
    private func performRequest(byPage page: Int) {
        isLoading = true
        self.showLoadingView()
        NASADataManager.shared.getCuriosityPhotos(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                self.photos.append(contentsOf: results.photos)
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Ooops!", message: error.rawValue, buttonTitle: "Ok")
            }
            self.isLoading = false
            DispatchQueue.main.async { self.hideLoadingView() }
        }
    }
    
    private func performRequest(byCamera camera: String) {
        isLoading = true
        self.showLoadingView()
        NASADataManager.shared.getCuriosityPhotos(byCamera: camera) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                self.photos.append(contentsOf: results.photos)
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Ooops!", message: error.rawValue, buttonTitle: "Ok")
            }
            self.isLoading = false
            self.isFiltered = true
            DispatchQueue.main.async { self.hideLoadingView() }
        }
    }
    
    private func configureViewController() {
        let filterImage = UIImage(systemName: "line.horizontal.3.decrease.circle")
        let filterButton = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: #selector(filterButtonDidTap))
        navigationItem.rightBarButtonItem = filterButton
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = photos[indexPath.item]
        let detailViewController = NASADetailViewController(item: item)
        detailViewController.modalPresentationStyle = .overCurrentContext
        detailViewController.modalTransitionStyle = .crossDissolve
        present(detailViewController, animated: true, completion: nil)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard !isLoading, !isFiltered else { return }
            currentPage += 1
            performRequest(byPage: currentPage)
        }
    }
}

extension CuriosityViewController: NASACameraViewControllerDelegate {
    func didFinishPickingCamera(camera: String) {
        guard !isLoading else { return }
        photos.removeAll()
        if camera != "all" {
            performRequest(byCamera: camera)
        } else {
            isFiltered = false
            performRequest(byPage: currentPage)
        }
    }
}
