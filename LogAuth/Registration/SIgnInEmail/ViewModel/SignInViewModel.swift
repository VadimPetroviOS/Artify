import Foundation

final class SignInViewModel: SignInViewModelProtocol {
    
    @Published 
    var email = ""
    @Published
    var password = ""
    @Published
    var emailExists = false
    @Published
    var showFinalView = false
    @Published
    private(set) var alertMessage = ""
    
    private let authenticationManager: RegistrationModelProtocol
    
    init(
        authenticationManager: RegistrationModelProtocol = RegistrationManager()
    ) {
        self.authenticationManager = authenticationManager
    }
    
    func createUser() {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        Task {
            do {
                _ = try await authenticationManager.createUser(
                    email: email,
                    password: password
                )
                showFinalView = true
            } catch {
                alertMessage = error.localizedDescription
                emailExists = true
                
            }
        }
    }
}
