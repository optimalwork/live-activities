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
    var timerType: String
}

@available(iOS 16.2, *)
struct TimerLiveActivity: Widget {

    let darkGray = Color(red: 0.2745, green: 0.2863, blue: 0.298)
    let lightGold = Color(red: 0.8980, green: 0.702, blue: 0.3137)
    let lightGray = Color(red: 0.949, green: 0.949, blue: 0.949)

    @ViewBuilder
    private var iconView: some View {
        if let uiImage = UIImage(named: "live-activity-icon") {
            Image(uiImage: uiImage)
                .resizable()
                .cornerRadius(8.0)
                .frame(width: 48, height: 48)
        } else {
            Image(systemName: "timer")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(darkGray)
        }
    }

    var body: some WidgetConfiguration {
//      Lock Screen
        ActivityConfiguration(for: TimerAttributes.self) { context in
            HStack(spacing: 12) {
                iconView
                VStack(alignment: .leading, spacing: 2) {
                    if !context.attributes.timerType.isEmpty {
                        Text(context.attributes.timerType)
                            .font(.caption)
                            .foregroundStyle(darkGray.opacity(0.6))
                    }
                    Text(context.attributes.name)
                        .font(.headline)
                        .foregroundStyle(darkGray)
                        .lineLimit(1)
                }
                Spacer()
                Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true)
                    .monospacedDigit()
                    .font(.title2)
                    .foregroundStyle(darkGray)
                    .fixedSize()
            }
            .padding()
            .activityBackgroundTint(lightGray)
        }
    dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    HStack(spacing: 12) {
                        iconView
                        VStack(alignment: .leading, spacing: 2) {
                            if !context.attributes.timerType.isEmpty {
                                Text(context.attributes.timerType)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Text(context.attributes.name)
                                .font(.headline)
                                .lineLimit(1)
                        }
                        Spacer()
                        Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true)
                            .monospacedDigit()
                            .font(.title2)
                            .fixedSize()
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
        TimerAttributes(name: "World", timerType: "Preview")
    }
}
