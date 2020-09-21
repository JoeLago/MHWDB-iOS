//
//  View+KeyboardObserving.swift
//
//  Created by Nicholas Fox on 10/4/19.
//

import SwiftUI

// Only nessecary for iOS 13
extension View {
  public func keyboardObserving() -> some View {
    self.modifier(KeyboardObserving())
  }
}
