//
//  NASADataManager.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import UIKit

final class NASADataManager {
    
    static let shared = NASADataManager()
    static let apiKey = NASAConstants.API_KEY
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    enum Endpoints {
        static let baseURL = "https://api.nasa.gov/mars-photos/api/v1"
        static let apiKeyParam = "api_key=\(NASADataManager.apiKey)"
        
        case getCuriosityPhotos(Int)
        
        var urlString: String {
            switch self {
            case .getCuriosityPhotos(let page):
                return "\(Endpoints.baseURL)/rovers/curiosity/photos?sol=1000&page=\(page)&\(Endpoints.apiKeyParam)"
            }
        }
        
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    func getCuriosityPhotos(withCurrentPage page: Int, completion: @escaping (Result<NASAResult, NASAError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: Endpoints.getCuriosityPhotos(page).url) { data, response, error in

            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
                        
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()                
                let result = try decoder.decode(NASAResult.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.unableToComplete))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  error == nil,
                  let data = data,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        task.resume()
    }
    
}
