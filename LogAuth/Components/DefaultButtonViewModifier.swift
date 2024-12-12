//
//  DefaultButtonViewModifier.swift
//  LogAuth
//
//  Created by Вадим on 12.05.2024.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

extension View {
    func withDefaultButtonFormatting() -> some View {
        modifier(DefaultButtonViewModifier())
    }
}
