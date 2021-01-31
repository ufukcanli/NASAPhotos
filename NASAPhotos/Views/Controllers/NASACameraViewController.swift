//
//  NASACameraViewController.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 30.01.2021.
//

import UIKit

protocol NASACameraViewControllerDelegate: AnyObject {
    func didFinishPickingCamera(camera: String)
}

class NASACameraViewController: UIViewController {

    private let cameraStackView = UIStackView()
    
    private let curiosityCameras = ["ALL", "FHAZ", "RHAZ", "MAST", "CHEMCAM", "MAHLI", "MARDI", "NAVCAM"]
    private let opportunityCameras = ["FHAZ", "RHAZ", "NAVCAM", "PANCAM", "MINITES"]
    private let spiritCameras = ["FHAZ", "RHAZ", "NAVCAM", "PANCAM", "MINITES"]
        
    weak var delegate: NASACameraViewControllerDelegate?

    private var timer: Timer?
    
    private var filter: String!
    
    init(filter: String) {
        super.init(nibName: nil, bundle: nil)
        self.filter = filter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }
    
    @objc private func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cameraButtonDidTap(_ sender: UIButton) {
        guard let cameraName = sender.currentTitle else { return }
        filter = cameraName.lowercased()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            self.dismiss(animated: true) {
                self.delegate?.didFinishPickingCamera(camera: self.filter)
            }
        }
    }
    
    private func configureCameraStackView() {
        cameraStackView.translatesAutoresizingMaskIntoConstraints = false
        cameraStackView.axis = .vertical
        cameraStackView.distribution = .fillEqually
        cameraStackView.spacing = 10
        
        curiosityCameras.forEach { cameraName in
            let cameraButton = self.createCameraButton(title: cameraName)
            if filter == cameraName.uppercased() {
                cameraButton.backgroundColor = .systemBlue
                cameraButton.setTitleColor(.white, for: .normal)
                cameraStackView.addArrangedSubview(cameraButton)
            } else {
                cameraButton.backgroundColor = .systemBackground
                cameraButton.setTitleColor(.systemBlue, for: .normal)
                cameraStackView.addArrangedSubview(cameraButton)
            }
        }
        
        view.addSubview(cameraStackView)
    }
    
    private func createCameraButton(title: String) -> UIButton {
        let cameraButton = UIButton(type: .system)
        view.addSubview(cameraButton)
        cameraButton.setTitle(title, for: .normal)
        cameraButton.setTitleColor(.systemBlue, for: .normal)
        cameraButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        cameraButton.layer.cornerRadius = 10
        cameraButton.layer.borderWidth = 2
        cameraButton.layer.borderColor = UIColor.systemBlue.cgColor
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cameraButton.addTarget(self, action: #selector(cameraButtonDidTap), for: .touchUpInside)
        return cameraButton
    }
        
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        configureCameraStackView()
                        
        NSLayoutConstraint.activate([
            cameraStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
