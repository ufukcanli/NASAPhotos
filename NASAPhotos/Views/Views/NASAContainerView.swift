//
//  NASAContainerView.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 29.01.2021.
//

import UIKit

class NASAContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
    }
}
