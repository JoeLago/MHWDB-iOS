//
//  SkillList.swift
//  MHWDB
//
//  Created by Joe on 7/25/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct SkillListSwift: View {
    private var skillTrees = Database.shared.skillTrees()

    var body: some View {
        List(skillTrees, id: \.id) {
            ItemDetailCell(
                imageName: nil, //$0.icon,
                titleText: $0.name,
                subtitleText: $0.description,
                destination: PlaceholderView()
            )
        }
        .navigationBarTitle("Skills")
    }
}
