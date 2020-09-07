//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import SwiftUI

struct SharpnessesView: View {
    @State var sharpnesses: [Sharpness]

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(sharpnesses.indices) { i in
                SharpnessView(sharpness: self.sharpnesses[i])
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
            SharpnessRectangle(value: sharpness.red, color: DepracatedColor.Sharpness.red)
            SharpnessRectangle(value: sharpness.orange, color: DepracatedColor.Sharpness.orange)
            SharpnessRectangle(value: sharpness.yellow, color: DepracatedColor.Sharpness.yellow)
            SharpnessRectangle(value: sharpness.green, color: DepracatedColor.Sharpness.green)
            SharpnessRectangle(value: sharpness.blue, color: DepracatedColor.Sharpness.blue)
            SharpnessRectangle(value: sharpness.white, color: DepracatedColor.Sharpness.white)
            SharpnessRectangle(value: sharpness.purple, color: DepracatedColor.Sharpness.purple)
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
