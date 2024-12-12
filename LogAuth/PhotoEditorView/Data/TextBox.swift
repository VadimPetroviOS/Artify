import Foundation
import SwiftUI


struct TextBox: Identifiable {
    var id = UUID().uuidString
    var text: String = ""
    var isBold: Bool = false
    var offSet: CGSize = .zero
    var lastOffSet: CGSize = .zero
    var textColor: Color = .white
    var isAdded: Bool = false
}
