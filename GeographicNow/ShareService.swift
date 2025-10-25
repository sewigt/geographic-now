//
//  ShareService.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import Foundation

class ShareService {
    static func getShareUrl(text: String) -> URL? {
        if let encodedText = Utility.getEncodedText(text: text) {
            return URL(string: "https://x.com/intent/post?text=\(encodedText)")
        }
        return nil
    }
}
