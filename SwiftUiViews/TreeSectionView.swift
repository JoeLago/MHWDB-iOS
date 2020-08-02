//
//  TreeSection.swift
//  MHWDB
//
//  Created by Joe on 8/1/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct TreeSectionView<Data, Content>: View where Data: Identifiable, Content: View {

    let title: String?
    let tree: Tree<Data>
    let dataContent: (Data) -> Content
    @State var isCollapsed = false

    public init(title: String? = nil, tree: Tree<Data>, dataContent: @escaping (Data) -> Content) {
        self.title = title
        self.tree = tree
        self.dataContent = dataContent
    }

    var body: some View {
        guard tree.array.count > 0 else { return AnyView(EmptyView()) }

        // Probably don't want header for this
        return AnyView(Section(header:
            title.map {
                CustomeHeader(title: $0, isCollapsed: isCollapsed)
                .onTapGesture { self.isCollapsed.toggle() }
            }
        ) {
            if !isCollapsed {
                ForEach(tree.nodeArray) { node in
                    HStack(spacing: 4) {
                        BranchesView(branches: node.getBranches()).edgesIgnoringSafeArea(.all)
                        self.dataContent(node.object).padding(.vertical, 8)
                        Spacer()
                    }.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
        })
    }
}

struct BranchesView: View {
    var width: CGFloat
    var branches = [Int]()

    init(branches: [Bool]) {
        self.width = CGFloat(branches.count * 10) + 10
        self.branches = branches.enumerated().compactMap { $0.element == true ? $0.offset * 10 + 10 : nil }
    }

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for branch in self.branches {
                    path.move(to: CGPoint(x: branch, y: 0))
                    path.addLine(to: CGPoint(x: CGFloat(branch), y: CGFloat(geometry.size.height)))
                }
            }
            .stroke(Color.primary, lineWidth: 2)
        }
        .frame(width: self.width, height: nil, alignment: .leading)
    }
}
