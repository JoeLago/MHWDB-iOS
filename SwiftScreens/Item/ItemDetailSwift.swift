//
//  ItemDetailSwift.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ItemDetailSwift: View {
    var item: Item

    init(id: Int) {
        item = Database.shared.item(id: id)
    }

    var body: some View {
        List() {
            PlaceholderView()
        }
        .navigationBarTitle(item.name)
    }
}
