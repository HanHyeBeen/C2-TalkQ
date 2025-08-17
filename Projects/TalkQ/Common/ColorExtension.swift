//
//  ColorExtension.swift
//  TalkQ
//
//  Created by Enoch on 8/13/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (without alpha)
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1) // Default to white in case of an error
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
    
    func toHex() -> String? {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return nil
        }
        
        let rgb: Int = (Int)(r * 255) << 16 |
        (Int)(g * 255) << 8 |
        (Int)(b * 255) << 0
        
        return String(format: "%06X", rgb)
    }
    
    /// 16진수 색상코드 가져와서 커스텀 컬러 지정
    static let mainColor = Color(hex: "#B6F0FC")
    static let subColor1 = Color(hex: "#2F455C")
    static let subColor2 = Color(hex: "#D9D8E6")
    static let pointColor = Color(hex: "#FFE66D")
    
    static let primaryTextColor = Color(hex: "#333333")
    static let secondaryTextColor = Color(hex: "#666666")
    static let lightgrayColor = Color(hex: "#BCBBBB")
    static let backgroundColor = Color(hex: "#FAFAFA")
}
