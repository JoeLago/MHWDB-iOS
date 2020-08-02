//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

extension String {
    // http://www.colourlovers.com/palette/452030/you_will_be_free

    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension NSAttributedString {
    convenience init(imageName: String, width: Int = 14, height: Int = 14) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        attachment.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        self.init(attachment: attachment)
    }
}

extension String {
    var attributedImage: NSAttributedString {
        return NSAttributedString(imageName: self)
    }
}

extension Array where Element: NSAttributedString {
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) { (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }

    func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}

// MARK: Special characters

extension String {
    static var star: String { return "\u{2605}" }
}
