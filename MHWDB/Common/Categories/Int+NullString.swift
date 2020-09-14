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

extension Int {
    var stringWithSymbol: String? {
        if self == 0 {
            return nil
        } else if self > 0 {
            return "+\(self)"
        } else {
            return "\(self)"
        }
    }
}
