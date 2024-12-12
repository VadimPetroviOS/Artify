import SwiftUI

struct RegistrationView: View {
    var body: some View {
        contentView
        .navigationTitle("Sign In")
        .padding()
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack {
            signIn
            GoogleSignInView()
            Spacer()
            goLogIn
        }
    }
    
    @ViewBuilder
    private var signIn: some View {
        NavigationLink {
            SignInView()
        } label: {
            Text("Sign In With Email")
                .withDefaultButtonFormatting()
            
        }
    }
    
    @ViewBuilder
    private var goLogIn: some View {
        NavigationLink {
            LogInView()
                .navigationBarBackButtonHidden()
        }label: {
            HStack(spacing: 3) {
                Text("Already have an account?")
                Text("Log In")
                    .fontWeight(.bold)
            }
            .font(.system(size: 14))
        }
    }
}

#Preview {
    NavigationStack {
        RegistrationView()
    }
}
