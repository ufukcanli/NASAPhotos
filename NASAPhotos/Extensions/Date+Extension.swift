//
//  Date+Extension.swift
//  NASAPhotos
//
//  Created by Ufuk Canlı on 29.01.2021.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
