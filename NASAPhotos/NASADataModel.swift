//
//  NASADataModel.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

import Foundation

struct NASAResult {
    let photos: [NASAPhoto]
}

struct NASAPhoto {
    let id: Int
    let imageSrc: String
    let camera: NASACamera
    let earthDate: Date
}

struct NASARover {
    let id: Int
    let name: String
    let status: String
    let landingDate: Date
    let launchDate: Date
}

struct NASACamera {
    let id: Int
    let name: String
    let fullName: String
}
