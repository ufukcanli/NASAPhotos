//
//  NASABodyLabel.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 29.01.2021.
//

import UIKit

class NASABodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configureLabel() {
        textColor = .secondaryLabel
        font = .preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
