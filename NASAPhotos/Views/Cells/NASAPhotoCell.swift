//
//  NASAPhotoCell.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

class NASAPhotoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "NASAPhotoCell"
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "nasa"))
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(withPhoto photo: NASAPhoto) {
        NASADataManager.shared.downloadImage(from: photo.imgSrc) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.imageView.image = image }
        }
    }
    
    private func configureCell() {
        backgroundColor = .systemBackground
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
