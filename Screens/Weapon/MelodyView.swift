//
//  MelodyView.swift
//  MHWDB
//
//  Created by Joe on 9/8/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct MelodyView: View {
    @State var melody: Melody

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    ForEach(melody.icons) { note in
                        IconImage(note, iconSize: .defaultSmallIconSize)
                    }
                    Spacer().frame(width: 8)
                    Text(melody.name)
                }
                Text(melody.effect1).font(.subheadline).foregroundColor(.secondary)
                Text(melody.effect2).font(.subheadline).foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                MelodyDurationTextView(duration: melody.baseDuration, ext: melody.baseExtension, color: .secondary)
                MelodyDurationTextView(duration: melody.m1Duration, ext: melody.m1Extension, color: .negative)
                MelodyDurationTextView(duration: melody.m2Duration, ext: melody.m2Extension, color: .positive)
            }
        }
    }
}

struct MelodyDurationTextView: View {
    var duration: Int
    var ext: Int
    var color: Color

    init?(duration: Int?, ext: Int?, color: Color) {
        guard let duration = duration, let ext = ext else { return nil }
        self.duration = duration
        self.ext = ext
        self.color = color
    }

    var body: some View {
        Text("\(duration) (+\(ext))")
            .font(.subheadline).foregroundColor(color)
    }
}
