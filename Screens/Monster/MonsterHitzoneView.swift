//
//  MonsterHitzoneView.swift
//  MHWDB
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

private extension MonsterHitzone {
    static var images: [String] {
        return ["icon_great_sword", "icon_hammer", "icon_heavy_bowgun", "Fire", "Water", "Ice", "Thunder", "Dragon", "Stun"]
    }

    var hitzones: [Int] {
        return [cut, dragon, fire, ice, impact, ko, shot, thunder, water]
    }
}

struct MonsterHitzoneView: View {
    @State var hitzones: [MonsterHitzone]

    var body: some View {
        HStack {
            Spacer()
            VStack {
                HStack {
                    // Spacer is a little larger than hitzone name to fix alignment mismatch
                    Spacer().frame(width: 88, alignment: .trailing)
                    ForEach(MonsterHitzone.images, id: \.self) { imageName in
                        AttributedText(imageName.attributedImage, alignment: .right)
                            .frame(maxWidth: .infinity, maxHeight: 14, alignment: .trailing)
                    }
                }
                ForEach(hitzones, id: \.name) { hitzone in
                    HStack {
                        Text(hitzone.name).font(.caption)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80, alignment: .trailing)
                        ForEach(hitzone.hitzones, id: \.self) {
                            Text("\($0)").font(.caption)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}
