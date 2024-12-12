import Foundation

@MainActor
protocol GoogleSignInViewModelProtocol: ObservableObject {
    var showFinalView: Bool { get set }
    func signInGoogle()
}
