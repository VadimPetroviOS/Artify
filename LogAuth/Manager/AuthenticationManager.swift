//
//  AuthenticationManager.swift
//  LogAuth
//
//  Created by Вадим on 10.05.2024.
//

import Foundation
import FirebaseAuth

protocol AuthenticationModelProtocol {
    func signIn(email: String, password: String) async throws -> RegDataResultModel
}

final class AuthenticationManager: AuthenticationModelProtocol {
    @discardableResult
    func signIn(email: String, password: String) async throws -> RegDataResultModel {
        let authDataResult = try await Auth.auth().signIn(
            withEmail: email,
            password: password
        )
        return RegDataResultModel(user: authDataResult.user)
    }
}

protocol AuthenticationWithGoogleModelProtocol {
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> RegDataResultModel
}

extension AuthenticationManager: AuthenticationWithGoogleModelProtocol {
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> RegDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(cradential: credential)
    }
    
    private func signIn(cradential: AuthCredential) async throws -> RegDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: cradential)
        return RegDataResultModel(user: authDataResult.user)
    }
}
