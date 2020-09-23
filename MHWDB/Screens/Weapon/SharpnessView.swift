//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import SwiftUI

struct SharpnessesView: View {
    @State var sharpnesses: [Sharpness]

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(sharpnesses) {
                SharpnessView(sharpness: $0)
            }
        }
        .padding(3)
        .border(Color("background_header"))
        .background(Color("background_header"))
    }
}

struct SharpnessView: View {
    @State var sharpness: Sharpness

    static let width: CGFloat = 120
    static let height: CGFloat = 8

    var body: some View {
        HStack(spacing: 0) {
            SharpnessRectangle(value: sharpness.red, color: SharpnessColor.red)
            SharpnessRectangle(value: sharpness.orange, color: SharpnessColor.orange)
            SharpnessRectangle(value: sharpness.yellow, color: SharpnessColor.yellow)
            SharpnessRectangle(value: sharpness.green, color: SharpnessColor.green)
            SharpnessRectangle(value: sharpness.blue, color: SharpnessColor.blue)
            SharpnessRectangle(value: sharpness.white, color: SharpnessColor.white)
            SharpnessRectangle(value: sharpness.purple, color: SharpnessColor.purple)
            Spacer(minLength: 0)
        }
        .frame(width: Self.width, height: Self.height)
    }
}

struct SharpnessRectangle: View {
    var value: Int
    var color: UIColor
    var width: CGFloat { CGFloat(value) * (SharpnessView.width / CGFloat(Sharpness.maxValue)) }

    var body: some View {
        Rectangle()
            .frame(width: width, height: SharpnessView.height)
            .foregroundColor(Color(color))
    }
}
