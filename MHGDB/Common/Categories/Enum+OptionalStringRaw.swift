//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import Foundation

extension RawRepresentable where RawValue == String {
    init?(optionalRaw: String?) {
        if optionalRaw == nil {
            return nil
        } else {
            self.init(rawValue: optionalRaw as String!)
        }
    }
}
