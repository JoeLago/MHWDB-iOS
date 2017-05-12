//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

extension String {
    // http://www.colourlovers.com/palette/452030/you_will_be_free
    
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
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

struct BoldText: StyledText {
    var text = ""
    var isBold: Bool { return true }
}

extension String {
    var attributedImage: NSAttributedString {
        return NSAttributedString(imageName: self)
    }
    
    var bold: BoldText {
        return BoldText(text: self)
    }
}

extension Array where Element: NSAttributedString {
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
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
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        get {
            return self[Range(i ..< i + 1)]
        }
        
        set(value) {
            let index = self.index(self.startIndex, offsetBy: i)
            self.replaceSubrange(index ... index, with: value)
            //self.replacingCharacters(in: Range(i ... i + 1), with: value)
        }
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< min(to, length))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
}


extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
    
    //let regex = "\\((.*?)\\)"
    func matchesForRegexInText(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
