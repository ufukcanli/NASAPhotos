//
//  NASATabBarController.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

class NASATabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
    }
    
    private func configureTabBarController() {
        viewControllers = [
            createNavigationController(viewController: CuriosityViewController(), title: "Curiosity", imageName: "c.square"),
            createNavigationController(viewController: OpportunityViewController(), title: "Opportunity", imageName: "o.square"),
            createNavigationController(viewController: SpiritViewController(), title: "Spirit", imageName: "s.square")
        ]
    }
    
    private func createNavigationController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .systemBackground
        navigationController.tabBarItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.image = UIImage(systemName: imageName)
        navigationController.tabBarItem.selectedImage = UIImage(systemName: imageName + ".fill")
        return navigationController
    }
}
