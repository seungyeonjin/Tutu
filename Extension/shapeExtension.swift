import SwiftUI

extension Shape {
    // fills and strokes a shape
    public func fill<S:ShapeStyle>(_ fillContent: S, strokeColor: Color, lineWidth: Double = 1) -> some View {
        ZStack {
            self.fill(fillContent)
            self.stroke(strokeColor, lineWidth: lineWidth)
        }
    }
}
