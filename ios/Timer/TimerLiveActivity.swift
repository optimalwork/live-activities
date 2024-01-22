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

    var body: some WidgetConfiguration {
//      Lock Screen
        ActivityConfiguration(for: TimerAttributes.self) { context in
            HStack(alignment: .bottom) {
                Spacer()
                Text(context.attributes.name).font(.title3)
                Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true).frame(width: 96)
                    .monospacedDigit()
                    .font(.largeTitle)
            }
            .padding()
            .activityBackgroundTint(Color.gray)
            .activitySystemActionForegroundColor(Color.white)
        }
    dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                        HStack(alignment: .bottom) {
                            Spacer() // Add Spacer to push views to the end
                            Text(context.attributes.name).font(.title3)
                            Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true).frame(width: 96)
                                .monospacedDigit()
                                .font(.largeTitle)
                        }
                }
            } compactLeading: {
                Image(systemName: "timer")
            } compactTrailing: {
                Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true)
                    .frame(width: 48)
                    .monospacedDigit()
                
            } minimal: {
                Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true)
                    .monospacedDigit()
                    .font(.caption2)
            }
        }
    }
}

extension TimerAttributes {
    fileprivate static var preview: TimerAttributes {
        TimerAttributes(name: "World")
    }
}

//extension TimerAttributes.ContentState {
//    fileprivate static var smiley: TimerAttributes.ContentState {
//        TimerAttributes.ContentState(emoji: "😀", expectedArrivalSeconds: <#ClosedRange<Date>#>)
//     }
//
//     fileprivate static var starEyes: TimerAttributes.ContentState {
//         TimerAttributes.ContentState(emoji: "🤩")
//     }
//}

//#Preview("Notification", as: .content, using: TimerAttributes.preview) {
//   TimerLiveActivity()
//} contentStates: {
//    TimerAttributes.ContentState.smiley
//    TimerAttributes.ContentState.starEyes
//}
