//
//  AlertViewModifier.swift
//  LogAuth
//
//  Created by Вадим on 12.05.2024.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?

    func body(content: Content) -> some View {
        content.alert(isPresented: $isPresented) {
            Alert(title: title, message: message, dismissButton: dismissButton)
        }
    }
}

extension View {
    func alertModifier(isPresented: Binding<Bool>, title: Text, message: Text, dismissButton: Alert.Button? = nil) -> some View {
        modifier(AlertModifier(isPresented: isPresented, title: title, message: message, dismissButton: dismissButton))
    }
}
