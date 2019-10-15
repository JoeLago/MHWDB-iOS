//
//  UserDefaults.swift
//  MHGDB
//
//  Created by Joe on 9/19/17.
//  Copyright © 2017 Gathering Hall Studios. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let firstLaunchDate = DefaultsKey<Date?>("firstLaunchDate")
    static let launchCount = DefaultsKey<Int>("launchCount", defaultValue: 0)
    static let lastReviewRequestDate = DefaultsKey<Date?>("lastReviewRequestDate")
    static let lastReviewRequestLaunchCount = DefaultsKey<Int>("lastReviewRequestLaunchCount", defaultValue: 0)
}
