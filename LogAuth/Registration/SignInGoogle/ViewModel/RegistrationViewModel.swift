import Foundation
import GoogleSignIn
import GoogleSignInSwift

final class GoogleSignInViewModel: GoogleSignInViewModelProtocol {
    
    @Published
    var showFinalView = false
    
    private let authenticationManager: AuthenticationWithGoogleModelProtocol
    
    init(
        authenticationManager: AuthenticationWithGoogleModelProtocol = AuthenticationManager()
    ) {
        self.authenticationManager = authenticationManager
    }
    
    private func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await authenticationManager.signInWithGoogle(tokens: tokens)
    }
    
    func signInGoogle() {
        Task {
            do {
                try await signInGoogle()
                showFinalView = true
            } catch {
                print(error)
            }
        }
    }
}
