//
//  CardView.swift
//  CommonUI
//
//  Created by Shorouk Mohamed on 13/01/2025.
//

import SwiftUI
import SwiftUI

public struct CardView: ViewModifier {
    var opacity: CGFloat?
    var cornerRadius: CGFloat?
    var shadowRadius: CGFloat?
    var borderColor: Color?
    var borderWidth: CGFloat?
    
    public init(
        opacity: CGFloat? = 0.2,
        cornerRadius: CGFloat? = 5,
        shadowRadius: CGFloat? = 0.6,
        borderColor: Color? = nil,
        borderWidth: CGFloat? = nil
    ) {
        self.opacity = opacity
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }

    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius ?? 5, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(opacity ?? 0.2), radius: shadowRadius ?? 0.6)
                    .overlay(
                        Group {
                            if let borderColor = borderColor, let borderWidth = borderWidth {
                                RoundedRectangle(cornerRadius: cornerRadius ?? 5, style: .continuous)
                                    .stroke(borderColor, lineWidth: borderWidth)
                            }
                        }
                    )
            )
    }
}

public extension View {
    func cardView(
        opacity: CGFloat? = 0.2,
        cornerRadius: CGFloat? = 5,
        shadowRadius: CGFloat? = 0.6,
        borderColor: Color? = nil,
        borderWidth: CGFloat? = nil
    ) -> some View {
        modifier(
            CardView(
                opacity: opacity,
                cornerRadius: cornerRadius,
                shadowRadius: shadowRadius,
                borderColor: borderColor,
                borderWidth: borderWidth
            )
        )
    }
}
