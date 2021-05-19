// String+DateFormatter.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

extension String {
    func toDate(with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
