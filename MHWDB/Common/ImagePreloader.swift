//
//  ImagePreloader.swift
//  MHWDB
//
//  Created by Joe on 8/21/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import UIKit

extension Database {

    func preloadImagesInBackground() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.preloadImages()
        }
    }

    func preloadImages() {
        let start = Date().timeIntervalSince1970
        let imageNames = getImageNames(table: "item")
            + getImageNames(table: "monster", columnName: "id")
            + WeaponType.allValues.compactMap({ $0.imageName })
            + MonsterHitzone.images

        for imageName in imageNames {
            //_ = UIImage(named: imageName) // This takes 4x as long!
            _ = UIImage(named: imageName, in: nil, compatibleWith: nil)
        }

        Log("Preloaded \(imageNames.count) images in \(Date().timeIntervalSince1970 - start) seconds")
    }

    func getImageNames(table: String, columnName: String = "icon_name") -> [String] {
        let query = "SELECT \(columnName) FROM \(table) GROUP BY \(columnName)"
         return getStrings(query, column: columnName)
    }
}
