import SwiftUI

struct SignInView<ViewModel: SignInViewModelProtocol>: View {
    
    @StateObject 
    private var viewModel: ViewModel
    
    init() where ViewModel == SignInViewModel {
        _viewModel = StateObject(
            wrappedValue: SignInViewModel()
        )
    }
    
    var body: some View {
        contentView
        .padding()
        .navigationTitle("Sign In With Email")
        .alertModifier(
            isPresented: $viewModel.emailExists,
            title: Text("Sign In"),
            message: Text(viewModel.alertMessage)
        )
        .fullScreenCover(isPresented: $viewModel.showFinalView) {
            PhotoEditorView()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack {
            emailField
            passwordField
            authButton
        }
    }
    
    @ViewBuilder
    private var emailField: some View {
        TextField("Email...", text: $viewModel.email)
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    @ViewBuilder
    private var passwordField: some View {
        SecureField("Password...", text: $viewModel.password)
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    @ViewBuilder
    private var authButton: some View {
        Button {
            viewModel.createUser()
        } label: {
            Text("Sign In")
                .withDefaultButtonFormatting()
        }
    }
}

#Preview {
    SignInView()
}
