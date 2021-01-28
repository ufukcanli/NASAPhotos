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
    let imageSrc: String
    let camera: NASACamera
    let earthDate: Date
}

struct NASARover: Decodable {
    let id: Int
    let name: String
    let status: String
    let landingDate: Date
    let launchDate: Date
}

struct NASACamera: Decodable {
    let id: Int
    let name: String
    let fullName: String
}
