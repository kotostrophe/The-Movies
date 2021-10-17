// Date+DateFormatter.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

extension Date {
    func toString(with format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
