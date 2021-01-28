//
//  NASADataManager.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import Foundation

final class NASADataManager {
    
    static let shared = NASADataManager()
    static let apiKey = "\(NASAConstants.API_KEY)"
    
    private init() {}
    
    enum Endpoints {
        static let baseURL = "https://api.nasa.gov/mars-photos/api/v1"
        static let apiKeyParam = "?api_key\(NASADataManager.apiKey)"
        
        case getCuriosityPhotos
        
        var urlString: String {
            switch self {
            case .getCuriosityPhotos:
                return "\(Endpoints.baseURL)/rovers/curiosity/photos\(Endpoints.apiKeyParam)"
            }
        }
        
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    func getCuriosityPhotos(completion: @escaping (Result<NASAResult, NASAError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: Endpoints.getCuriosityPhotos.url) { data, response, error in

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
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(NASAResult.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
