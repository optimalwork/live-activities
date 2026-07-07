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
        // Fixed-end-time session: a wall-clock stop — a paused timer KEEPS
        // counting down (pause halts work logging, not the clock). Optional so
        // older activities still decode.
        var fixedEnd: Bool?
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
        // Frozen only for a duration-mode pause. A fixed-end pause keeps the
        // live countdown — the deadline is a wall-clock stop the pause can't
        // move, so a frozen number would be a lie.
        if state.isPaused == true && state.fixedEnd != true {
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
                    if context.isStale {
                        // Stale = the timer's end passed with the app never
                        // running again to end this activity (staleDate is
                        // set to the deadline) — say so instead of sitting
                        // on a live-looking 0:00. Checked BEFORE paused: a
                        // fixed-end pause counts down to zero too, and at
                        // zero "Time's up" beats "Paused".
                        Text("Time's up")
                            .font(.caption)
                            .foregroundStyle(darkGray.opacity(0.6))
                            .frame(minWidth: 70, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                    } else if context.state.isPaused == true {
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
                            if context.isStale {
                                Text("Time's up")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .frame(minWidth: 70, alignment: .trailing)
                                    .multilineTextAlignment(.trailing)
                            } else if context.state.isPaused == true {
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
                // Stale beats paused: a fixed-end pause counts to zero too.
                Image(systemName: context.isStale
                    ? "checkmark"
                    : (context.state.isPaused == true ? "pause.fill" : "play.fill"))
                    .foregroundColor(lightGold)
                    // Nudge right off the hard left edge of the compact region.
                    .padding(.leading, 4)
            } compactTrailing: {
                timerText(state: context.state)
                    .frame(width: 48)
                    .monospacedDigit()
                    .foregroundColor(lightGold)

            } minimal: {
                if context.isStale {
                    Image(systemName: "checkmark")
                        .foregroundColor(lightGold)
                } else if context.state.isPaused == true && context.state.fixedEnd != true {
                    Image(systemName: "pause.fill")
                        .foregroundColor(lightGold)
                } else {
                    // Running — or a fixed-end pause, whose countdown is live.
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
