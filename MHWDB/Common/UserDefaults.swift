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
    var firstLaunchDate: DefaultsKey<Date?> { .init("firstLaunchDate") }
    var launchCount: DefaultsKey<Int> { .init("launchCount", defaultValue: 0) }
    var lastReviewRequestDate: DefaultsKey<Date?> { .init("lastReviewRequestDate") }
    var lastReviewRequestLaunchCount: DefaultsKey<Int> { .init("lastReviewRequestLaunchCount", defaultValue: 0) }
}
