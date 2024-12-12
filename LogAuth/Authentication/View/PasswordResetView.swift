import SwiftUI
import Firebase

struct PasswordResetView: View {
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        alertMessage = error.localizedDescription
                        showAlert = true
                    } else {
                        alertMessage = "Password reset email sent successfully."
                        showAlert = true
                    }
                }
            }) {
                Text("Reset Password")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
        .padding()
        .alertModifier(
            isPresented: $showAlert,
            title: Text("Password Reset"),
            message: Text(alertMessage),
            dismissButton: .default(Text("OK"))
        )
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
    }
}
