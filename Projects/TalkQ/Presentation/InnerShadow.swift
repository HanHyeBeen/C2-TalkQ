//
//  InnerShadow.swift
//  TalkQ
//
//  Created by Enoch on 8/13/25.
//

import SwiftUI

struct InnerShadow: View {
    var buttonColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(buttonColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.1), lineWidth: 3)
                    .blur(radius: 2)
                    .offset(x: -4, y: -4)
                    .mask(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [.black, .black.opacity(0.3)], startPoint: .bottomTrailing, endPoint: .topLeading))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.7), lineWidth: 7)
                    .blur(radius: 2)
                    .offset(x: 1, y: 1)
                    .mask(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [.white, .white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            )
    }
}

#Preview {
    InnerShadow(buttonColor: Color.mainColor)
}
