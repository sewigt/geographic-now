//
//  Utility.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import Foundation

class Utility {
    static func getEncodedText(text: String) -> String? {
        return text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
