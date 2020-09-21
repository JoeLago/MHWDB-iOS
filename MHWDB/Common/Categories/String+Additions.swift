//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

extension String: Identifiable {
    public var id: String { return self }
}

extension String {
    // http://www.colourlovers.com/palette/452030/you_will_be_free

    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
  func indexInt(of char: Character) -> Int? {
    return firstIndex(of: char)?.utf16Offset(in: self)
  }
}

// MARK: Special characters

extension String {
    static var star: String { return "\u{2605}" }
}
