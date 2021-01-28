//
//  CuriosityViewModel.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import Foundation

class CuriosityViewModel {
    
    var photos = [NASAPhoto]()
    
    var isLoading = NASABindable<Bool>()
    
    func performRequest(completion: @escaping (NASAError?) -> Void) {
        isLoading.value = true
        NASADataManager.shared.getCuriosityPhotos { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            switch result {
            case .success(let results):
                self.photos = results.photos
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
