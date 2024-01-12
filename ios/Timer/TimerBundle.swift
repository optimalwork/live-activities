//
//  TimerBundle.swift
//  Timer
//
//  Created by brandon bohach on 1/11/24.
//  Copyright © 2024 Max Lynch. All rights reserved.
//

import WidgetKit
import SwiftUI

@available(iOS 17.1, *)
//@main
struct TimerBundle: WidgetBundle {
    var body: some Widget {
        Timer()
        TimerLiveActivity()
    }
}
