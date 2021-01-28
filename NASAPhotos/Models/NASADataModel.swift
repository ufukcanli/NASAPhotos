//
//  NASADataModel.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import Foundation

struct NASAResult: Decodable {
    let photos: [NASAPhoto]
}

struct NASAPhoto: Decodable {
    let id: Int
    let imgSrc: String
    let camera: NASACamera
    let earthDate: String
    let rover: NASARover
    
    enum CodingKeys: String, CodingKey {
        case id, rover, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
    }
}

struct NASARover: Decodable {
    let id: Int
    let name: String
    let status: String
    let landingDate: String
    let launchDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, status
        case landingDate = "landing_date"
        case launchDate = "launch_date"
    }
}

struct NASACamera: Decodable {
    let id: Int
    let name: String
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
    }
}
