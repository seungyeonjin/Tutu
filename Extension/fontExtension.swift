import SwiftUI

extension Font {
    static func myCustomFont(size: Int) -> Font {
        Font.system(size: CGFloat(size), design: .serif)
    }
}
