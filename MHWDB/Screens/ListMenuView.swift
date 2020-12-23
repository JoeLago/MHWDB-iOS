//
//  ListMenuSwift.swift
//  MHWDB
//
//  Created by Joe on 10/17/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI
import UIKit
import SwiftlySearch

struct ListMenuView: View {
    @ObservedObject var search = AllSearchObservable()

    var body: some View {
        NavigationView {
            List {
                SearchSectionView(search: search)
                MenuSection(search: search)
            }
            .navigationBarSearch(
                $search.searchText,
                placeholder: "Search",
                cancelClicked: { search.cancel() }
            )
            .navigationBarTitle("MHWDB")
        }
        .onAppear {
            ReviewManager.presentReviewControllerIfElligible()
        }
    }
}
