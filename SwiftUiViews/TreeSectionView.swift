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

        return AnyView(Section(header:
            title.map {
                CustomeHeader(title: $0, isCollapsed: isCollapsed)
                .onTapGesture { self.isCollapsed.toggle() }
            }
        ) {
            if !isCollapsed {
                ForEach(tree.nodeArray) { node in
                    HStack(spacing: 4) {
                        BranchesView(node: node).edgesIgnoringSafeArea(.all)
                        self.dataContent(node.object).padding(.vertical, 8)
                        Spacer()
                    }.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
        })
    }
}

// This could look better I think
struct BranchesView: View {
    let lineWidth: CGFloat = 1
    let spacing: CGFloat = 4
    var width: CGFloat
    var branches = [CGFloat]()
    var hasParent: Bool

    init<NodeType>(node: Node<NodeType>) {
        let nodeBranches = node.getBranches()
        self.width = spacing * CGFloat(nodeBranches.count) + spacing
        self.hasParent = node.parent != nil
        self.branches = nodeBranches.enumerated().compactMap {
            $0.element == true ? CGFloat($0.offset) * spacing + spacing : nil
        }
    }

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let height = geometry.size.height

                for branchOffset in self.branches {
                    path.move(to: CGPoint(x: branchOffset, y: 0))
                    path.addLine(to: CGPoint(x: branchOffset, y: height))
                }

                guard self.hasParent else { return }
                let xOffset = self.width - self.spacing
                path.move(to: CGPoint(x: xOffset, y: 0))
                path.addLine(to: CGPoint(x: xOffset, y: height/2))
                path.addLine(to: CGPoint(x: xOffset + self.spacing, y: height/2))
            }
            .stroke(Color.primary, lineWidth: self.lineWidth)
        }
        .frame(width: self.width, height: nil, alignment: .leading)
    }
}
