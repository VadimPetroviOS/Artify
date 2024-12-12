import SwiftUI
import FirebaseAuth

struct ModalView: View {
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var showModal: Bool

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
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
            dismissButton: .default(Text("OK")) {
                showModal = false
            }
        )
    }
}
