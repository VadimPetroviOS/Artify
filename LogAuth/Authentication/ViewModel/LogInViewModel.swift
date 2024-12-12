import Foundation

final class LogInViewModel: LogInViewModelProtocol {
    
    @Published
    var email = ""
    @Published
    var password = ""
    @Published
    var showFinalView = false
    
    private let authenticationManager: AuthenticationModelProtocol
    
    init(
        authenticationManager: AuthenticationManager = AuthenticationManager()
    ) {
        self.authenticationManager = authenticationManager
    }
    
    var isValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        Task {
            do {
                _ = try await authenticationManager.signIn(
                    email: email,
                    password: password
                )
                showFinalView = true
            } catch {
                print(error.localizedDescription)
                // Обработать ошибку
            }
        }
       
    }
}
