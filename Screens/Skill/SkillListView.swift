//
//  SkillList.swift
//  MHWDB
//
//  Created by Joe on 7/25/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct SkillListView: View {
    private var skillTrees = Database.shared.skilltrees()

    var body: some View {
        List(skillTrees, id: \.id) {
            ItemDetailCell(
                icon: $0.icon,
                titleText: $0.name,
                subtitleText: $0.description,
                destination: SkillDetailView(id: $0.id)
            )
        }
        .navigationBarTitle("Skills")
    }
}
