//
//  HapticManager.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 27/05/2023.
//

import Foundation
import SwiftUI

class HapticManager {
    static let shared: HapticManager = HapticManager()
    private let generator: UINotificationFeedbackGenerator
    
    private init() {
        generator = UINotificationFeedbackGenerator()
    }
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
