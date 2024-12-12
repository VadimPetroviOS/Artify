import Foundation

@MainActor
protocol LogInViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var showFinalView: Bool { get set }
    var isValid: Bool { get }
    
    func signIn()
}
