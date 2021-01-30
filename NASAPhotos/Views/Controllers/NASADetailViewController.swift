//
//  NASADetailViewController.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 29.01.2021.
//

import UIKit

class NASADetailViewController: UIViewController {
    
    private let containerView = NASAContainerView()
    private let vehicleNameLabel = NASATitleLabel(textAlignment: .center, fontSize: 26)
    private let vehicleStatusLabel = NASASecondaryTitleLabel(fontSize: 20)
    private let vehicleLaunchDateLabel = NASABodyLabel(textAlignment: .center)
    private let vehicleLandingDateLabel = NASABodyLabel(textAlignment: .center)
    private let shootingDateLabel = NASABodyLabel(textAlignment: .center)
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    
    private var item: NASAPhoto!
    
    init(item: NASAPhoto) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        createDismissTapGesture()
        updateUIElements()
    }
    
    @objc private func didTapDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    private func createDismissTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapDismiss))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    private func updateUIElements() {
        vehicleNameLabel.text = item.rover.name
        vehicleStatusLabel.text = "Status: " + item.rover.status
        shootingDateLabel.text = "Shooting: " + item.earthDate.convertToDisplayFormat()
        vehicleLaunchDateLabel.text = "Launch: " + item.rover.launchDate.convertToDisplayFormat()
        vehicleLandingDateLabel.text = "Landing: " + item.rover.landingDate.convertToDisplayFormat()
        
        NASADataManager.shared.downloadImage(from: item.imgSrc) { [weak self] image in
            guard let self = self else { return }
            self.imageView.image = image
        }
    }
    
    private func configureStackView() {
        [imageView, vehicleNameLabel, vehicleStatusLabel,
         vehicleLaunchDateLabel, vehicleLandingDateLabel, shootingDateLabel].forEach { subview in
            stackView.addArrangedSubview(subview)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        
        containerView.addSubview(stackView)
    }

    private func configureViewController() {        
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
        view.addSubview(containerView)
        
        configureStackView()
                
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 350),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

extension NASADetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view == self.view)
    }
}
