//
//  NASAError.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 28.01.2021.
//

enum NASAError: String, Error {
    case unableToComplete = "Unable complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
