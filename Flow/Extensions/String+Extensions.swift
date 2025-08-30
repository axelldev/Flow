//
//  String+Extensions.swift
//  Flow
//
//  Created by axell solis on 28/08/25.
//

import Foundation

extension String {
    func trimmed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
