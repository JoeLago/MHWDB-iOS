//
//  ItemListView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var search = AllSearchObservable(itemsOnly: true)
    private var allItems = Database.shared.items()

    var body: some View {
        List(search.results?.items ?? allItems) {
            ItemDetailCell(
                icon: $0.icon,
                titleText: $0.name,
                destination: ItemDetailView(id: $0.id)
            )
        }
        .navigationBarSearch(
            $search.searchText,
            placeholder: "Search",
            cancelClicked: { search.cancel() }
        )
        .navigationBarTitle("Items")
        .keyboardObserving()
    }
}
