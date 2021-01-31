//
//  OpportunityViewController.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

class OpportunityViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var photos = [NASAPhoto]()
    private var isLoading = false
    private var currentPage = 1
    private var isFiltered = false
    private var currentFilter = "ALL"

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        performRequest(byPage: currentPage)
    }
    
    @objc func filterButtonDidTap() {
        let cameraViewController = NASACameraViewController(filter: currentFilter, from: "o")
        cameraViewController.delegate = self
        present(cameraViewController, animated: true, completion: nil)
    }
    
    private func performRequest(byPage page: Int) {
        isLoading = true
        NASADataManager.shared.getOpportunityPhotos(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                self.photos.append(contentsOf: results.photos)
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Ooops!", message: error.rawValue, buttonTitle: "Ok")
            }
            self.isLoading = false
        }
    }
    
    private func performRequest(byCamera camera: String) {
        isLoading = true
        NASADataManager.shared.getOpportunityPhotos(byCamera: camera) { [weak self] result in
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
        }
    }

    private func configureViewController() {
        let filterImage = UIImage(systemName: "line.horizontal.3.decrease.circle")
        let filterButton = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: #selector(filterButtonDidTap))
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.title = "Opportunity - \(currentFilter)"
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: NASAHelper.createThreeColumnFlowLayout(in: view))
        collectionView.register(NASAPhotoCell.self, forCellWithReuseIdentifier: NASAPhotoCell.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}

extension OpportunityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NASAPhotoCell.reuseIdentifier, for: indexPath) as! NASAPhotoCell
        cell.updateCell(withPhoto: photos[indexPath.item])
        return cell
    }
}

extension OpportunityViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = photos[indexPath.item]
        let detailViewController = NASADetailViewController(item: item)
        detailViewController.modalPresentationStyle = .overCurrentContext
        detailViewController.modalTransitionStyle = .crossDissolve
        present(detailViewController, animated: true, completion: nil)
    }
}

extension OpportunityViewController: NASACameraViewControllerDelegate {
    func didFinishPickingCamera(camera: String) {
        guard !isLoading else { return }
        photos.removeAll()
        currentFilter = camera.uppercased()
        navigationItem.title = "Opportunity - \(camera.uppercased())"
        if camera != "all" {
            performRequest(byCamera: currentFilter)
        } else {
            isFiltered = false
            performRequest(byPage: currentPage)
        }
    }
}
