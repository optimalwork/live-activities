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
            .activityBackgroundTint(Color(red: 0.949, green: 0.949, blue: 0.949)) // light gray
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
