//
//  TimerLiveActivity.swift
//  Timer
//
//  Created by brandon bohach on 1/11/24.
//  Copyright © 2024 Max Lynch. All rights reserved.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
        var expectedArrivalSeconds: ClosedRange<Date>
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

@available(iOS 16.2, *)
struct TimerLiveActivity: Widget {
    
    let darkGray = Color(red: 0.2745, green: 0.2863, blue: 0.298)
    let lightGold = Color(red: 0.8980, green: 0.702, blue: 0.3137)
    let lightGray = Color(red: 0.949, green: 0.949, blue: 0.949)

    var body: some WidgetConfiguration {
//      Lock Screen
        ActivityConfiguration(for: TimerAttributes.self) { context in
            HStack(alignment: .lastTextBaseline) {
                Image("icon-small").resizable().cornerRadius(8.0).frame(width: 64, height: 64, alignment: Alignment.center)
                Spacer()
                Text(context.attributes.name).font(.title3).foregroundStyle(darkGray)
                Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true).frame(width: 96)
                    .monospacedDigit()
                    .font(.largeTitle)
                    .foregroundStyle(darkGray)
            }
            .padding()
            .activityBackgroundTint(lightGray)
        }
    dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    HStack(alignment: .lastTextBaseline) {
                        Image("icon-small").resizable().cornerRadius(8.0).frame(width: 64, height: 64, alignment: Alignment.center)
                            Spacer() // Add Spacer to push views to the end
                            Text(context.attributes.name).font(.title3)
                            Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true).frame(width: 96)
                                .monospacedDigit()
                                .font(.largeTitle)
                        }
                }
            } compactLeading: {
                Image(systemName: "timer").foregroundColor(lightGold)
            } compactTrailing: {
                Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true)
                    .frame(width: 48)
                    .monospacedDigit()
                    .foregroundColor(lightGold)

            } minimal: {
                Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true)
                    .monospacedDigit()
                    .font(.caption2)
                    .foregroundColor(lightGold)

            }
        }
    }
}

extension TimerAttributes {
    fileprivate static var preview: TimerAttributes {
        TimerAttributes(name: "World")
    }
}
