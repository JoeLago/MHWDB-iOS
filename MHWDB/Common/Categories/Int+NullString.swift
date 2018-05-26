//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation

extension Int {
    init?(_ string: String?) {
        guard let string = string else { return nil }
        self.init(string)
    }
}
