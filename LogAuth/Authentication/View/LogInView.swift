import SwiftUI

struct LogInView<ViewModel: LogInViewModelProtocol>: View {
    
    @StateObject
    private var viewModel: ViewModel
    
    @State private var showModal = false
    
    @Environment(\.dismiss) var dismiss
    
    init() where ViewModel == LogInViewModel {
        _viewModel = StateObject(
            wrappedValue: LogInViewModel()
        )
    }
    
    var body: some View {
        contentView
        .padding()
        .navigationTitle("Log In")
        .fullScreenCover(isPresented: $viewModel.showFinalView) {
            PhotoEditorView()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack {
            emailField
            passwordField
            logButton
            passwordResetButton
            modalView
            Spacer()
            cancelButton
        }
    }
    
    @ViewBuilder
    private var emailField: some View {
        TextField("Email...", text: $viewModel.email)
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
            .disabled(showModal)
    }
    
    @ViewBuilder
    private var passwordField: some View {
        SecureField("Password...", text: $viewModel.password)
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
            .disabled(showModal)
    }
    
    @ViewBuilder
    private var logButton: some View {
        Button {
            viewModel.signIn()
        } label: {
            Text("Log In")
                .withDefaultButtonFormatting()
        }
        .disabled(!viewModel.isValid || showModal)
        .opacity(viewModel.isValid ? 1.0 : 0.5)
    }
    
    @ViewBuilder
    private var passwordResetButton: some View {
        Button {
            showModal = true
        } label: {
            HStack {
                Text("Forgot your password?")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                Spacer()
            }
        }
        .disabled(showModal)
    }
    
    @ViewBuilder
    private var modalView: some View {
        if showModal {
            ModalView(showModal: $showModal)
                .frame(width: 300, height: 200)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
    
    @ViewBuilder
    private var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 3) {
                Text("Don't have an account?")
                Text("Sign In")
                    .fontWeight(.bold)
            }
            .font(.system(size: 14))
        }
        .disabled(showModal)
    }
}

#Preview {
    LogInView()
}
