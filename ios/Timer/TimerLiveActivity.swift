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
        // Optional so older activities (started before pause-support) still decode.
        var isPaused: Bool?
        var secondsRemainingAtPause: Int?
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

    private func formatTime(_ seconds: Int) -> String {
        let clamped = max(0, seconds)
        let h = clamped / 3600
        let m = (clamped % 3600) / 60
        let s = clamped % 60
        return h > 0
            ? String(format: "%d:%02d:%02d", h, m, s)
            : String(format: "%d:%02d", m, s)
    }

    @ViewBuilder
    private func timerText(state: TimerAttributes.ContentState) -> some View {
        if state.isPaused == true {
            Text(formatTime(state.secondsRemainingAtPause ?? 0))
        } else {
            Text(timerInterval: state.expectedArrivalSeconds, countsDown: true)
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
                VStack(alignment: .trailing, spacing: 2) {
                    if context.state.isPaused == true {
                        Text("Paused")
                            .font(.caption)
                            .foregroundStyle(darkGray.opacity(0.6))
                            .frame(minWidth: 70, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                    }
                    timerText(state: context.state)
                        .monospacedDigit()
                        .font(.title2)
                        .foregroundStyle(darkGray)
                        .frame(minWidth: 70, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
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
                        VStack(alignment: .trailing, spacing: 2) {
                            if context.state.isPaused == true {
                                Text("Paused")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .frame(minWidth: 70, alignment: .trailing)
                                    .multilineTextAlignment(.trailing)
                            }
                            timerText(state: context.state)
                                .monospacedDigit()
                                .font(.title2)
                                .frame(minWidth: 70, alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
            } compactLeading: {
                Image(systemName: context.state.isPaused == true ? "pause.fill" : "timer")
                    .foregroundColor(lightGold)
            } compactTrailing: {
                timerText(state: context.state)
                    .frame(width: 48)
                    .monospacedDigit()
                    .foregroundColor(lightGold)

            } minimal: {
                if context.state.isPaused == true {
                    Image(systemName: "pause.fill")
                        .foregroundColor(lightGold)
                } else {
                    Text(timerInterval: context.state.expectedArrivalSeconds, countsDown: true)
                        .monospacedDigit()
                        .font(.caption2)
                        .foregroundColor(lightGold)
                }
            }
        }
    }
}

extension TimerAttributes {
    fileprivate static var preview: TimerAttributes {
        TimerAttributes(name: "World", timerType: "Preview")
    }
}
