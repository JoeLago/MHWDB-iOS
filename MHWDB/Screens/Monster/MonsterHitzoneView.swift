//
//  MonsterHitzoneView.swift
//  MHWDB
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

extension MonsterHitzoneView {

    init(hitzones: [MonsterHitzone]) {
        let headings = [
            "equipment_greatsword",
            "equipment_hammer",
            "equipment_heavy_bowgun",
            "element_fire",
            "element_water",
            "element_ice",
            "element_thunder",
            "element_dragon",
            "status_stun"
        ]
        self.init(model: GridModel(
            headings: headings.map { .icon(Icon(name: $0)) },
            rows: hitzones.map { GridRow(name: $0.name, values: $0.allValues.map { "\($0)" }) }
        ))
    }

    init(breaks: [MonsterBreak]) {
        let headings: [GridModel.Header] = [
            .text("Flinch"),
            .text("Break"),
            .text("Sever"),
            .icon(Icon(name: "kinsect_white"))
        ]
        self.init(model: GridModel(
            headings: headings,
            rows: breaks.map { monsterBreak in
                GridRow(name: monsterBreak.partName,
                        values: monsterBreak.values.map { "\($0)" })
            }
        ))
    }
}

struct GridModel {
    enum Header {
        case text(String)
        case icon(Icon)

        var view: AnyView {
            switch self {
            case .text(let text): return AnyView(Text(text).font(.caption).foregroundColor(.secondary))
            case .icon(let icon): return AnyView(IconImage(icon, iconSize: 14))
            }
        }
    }

    let headings: [Header]
    let rows: [GridRow]
}

struct GridRow {
    let name: String
    let values: [String]
}

struct MonsterHitzoneView: View {
    @State var model: GridModel

    let spacing: CGFloat = 8
    let labelWidth: CGFloat = 80

    var body: some View {
        HStack {
            Spacer()
            VStack {
                HStack(spacing: spacing) {
                    Spacer().frame(width: labelWidth)
                    ForEach(Array(zip(model.headings.indices, model.headings)), id: \.0) { _, header in
                        header.view.frame(maxWidth: .infinity, maxHeight: 14, alignment: .trailing)
                    }
                }
                ForEach(Array(zip(model.rows.indices, model.rows)), id: \.0) { _, row in
                    HStack(spacing: self.spacing) {
                        Text(row.name).font(.caption)
                            .multilineTextAlignment(.trailing)
                            .frame(width: self.labelWidth, alignment: .trailing)
                        ForEach(row.values, id: \.self) {
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
