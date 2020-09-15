//
//  ValueView.swift
//  MHWDB
//
//  Created by Joe on 8/1/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

private func string(for value: Int?, shouldShowZero: Bool = false) -> String? {
    if !shouldShowZero, value == 0 {
        return nil
    } else {
        return value.map { "\($0)" }
    }
}

struct ValueView: View {
    var name: String
    var value: String?
    var icon: Icon?

    init(name: String, value: Int?, icon: Icon? = nil, shouldShowZero: Bool = false) {
        self.name = name
        self.value = string(for: value, shouldShowZero: shouldShowZero)
        self.icon = icon
    }

    init(name: String, value: String?, icon: Icon? = nil) {
        self.name = name
        self.value = value
        self.icon = icon
    }

    var body: some View {
        guard let value = value else { return AnyView(EmptyView()) }

        return AnyView(HStack(spacing: 4) {
            Text(name).font(.subheadline)
            Spacer().frame(width: 6)
            Text(value).font(.subheadline).foregroundColor(.secondary)
            icon.map { IconImage($0, iconSize: 20) }
        })
    }
}

struct MultiValueView: View {
    let values: [(String, String)]

    init(values: [(String, Int?)], shouldShowZero: Bool = false) {
        self.values = values.compactMap {
            guard let value = string(for: $0.1, shouldShowZero: shouldShowZero)
                else { return nil }
            return ($0.0, value)
        }
    }

    init(values: [(String, String?)]) {
        self.values = values.compactMap { value in value.1.map({ (value.0, $0) }) }
    }

    var body: some View {
        guard values.count > 0 else { return AnyView(EmptyView()) }

        // TODO: Should be a grid, do we want iOS14 only? Or custom grid.
        return AnyView(HStack(spacing: 16) {
            ForEach(values, id: \.0) { value in
                ValueView(name: value.0, value: value.1)
            }
            Spacer()
        })
    }
}
