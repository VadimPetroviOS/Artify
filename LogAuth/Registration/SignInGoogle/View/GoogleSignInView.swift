import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInView<ViewModel: GoogleSignInViewModelProtocol>: View {
    
    @StateObject
    private var viewModel: ViewModel
    
    init() where ViewModel == GoogleSignInViewModel {
        _viewModel = StateObject(
            wrappedValue: GoogleSignInViewModel()
        )
    }
    
    var body: some View {
        GoogleSignInButton(
            viewModel: GoogleSignInButtonViewModel(
                scheme: .dark,
                style: .wide,
                state: .normal
            )) {
                viewModel.signInGoogle()
            }
            .fullScreenCover(isPresented: $viewModel.showFinalView) {
                PhotoEditorView()
            }
    }
}

#Preview {
    GoogleSignInView()
}
