//
//  ItemListView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var search = ItemSearchObservable()

    var body: some View {
        VStack {
            SearchBar(text: $search.searchText)
            List(search.items, id: \.id) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    destination: ItemDetailView(id: $0.id)
                )
            }
        }
        .keyboardObserving()
        .navigationBarTitle("Items")
    }
}

final class ItemSearchObservable: ObservableObject {
    var searchText: String = "" { didSet { performSearch() }}
    @Published var items = Database.shared.items()
    var searchRequest: SearchRequest?

    func performSearch() {
        searchRequest?.cancel()
        searchRequest = SearchRequest(searchText, itemsOnly: true).then {
            self.searchRequest = nil
            self.items = $0.items
        }
    }
}
