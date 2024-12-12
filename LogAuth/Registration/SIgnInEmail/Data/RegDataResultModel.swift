import Foundation
import FirebaseAuth

struct RegDataResultModel {
    let uid: String
    let email: String?
}

extension RegDataResultModel {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
