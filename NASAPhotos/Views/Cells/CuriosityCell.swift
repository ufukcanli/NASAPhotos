//
//  CuriosityCell.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

class CuriosityCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CuriosityCell"
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        backgroundColor = .systemPurple
        
    }
}
