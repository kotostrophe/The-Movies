// String+Trimmer.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

extension String {
    func trimLast(_ character: Character) -> String? {
        guard let subrange = split(separator: character).last
        else { return nil }
        return String(subrange)
    }
}
