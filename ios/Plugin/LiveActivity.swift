import Foundation
import ActivityKit

@available(iOS 16.2, *)
@objc public class LiveActivity: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    
    /// Native-to-native pause/resume for the running activity — for callers
    /// that can't go through the webview (e.g. the host app's
    /// WatchConnectivity handler: a watch-initiated pause arrives while the
    /// phone is locked, which is exactly when the lock screen is showing the
    /// Live Activity and the webview JS is suspended). Everything is derived
    /// from the activity's own current content, so no fresh timer params are
    /// needed:
    /// - pause, duration mode: freeze at `deadline − now`, no stale date
    ///   (a frozen display stays accurate indefinitely);
    /// - pause, fixed-end mode: keep the countdown counting (the end time is
    ///   a wall-clock stop — pause halts work logging, not the clock), stale
    ///   at the deadline so "Time's up" still lands at zero;
    /// - resume, duration mode: new window `now → now + frozen remaining`;
    /// - resume, fixed-end mode: the untouched window is still correct.
    /// A webview-side update for the same transition (if the app is awake) is
    /// an idempotent duplicate. No-op when no activity is running.
    /// Static: no instance state, and callable cross-module without relying
    /// on an inherited initializer's access level.
    public static func applyPauseState(isPaused: Bool, fixedEnd: Bool) {
        guard let activity = Activity<TimerAttributes>.activities.first else { return }
        let state = activity.content.state
        let now = Date.now
        var newState = state
        newState.isPaused = isPaused
        newState.fixedEnd = fixedEnd
        let staleDate: Date?

        if isPaused {
            if fixedEnd {
                newState.secondsRemainingAtPause = nil
                staleDate = state.expectedArrivalSeconds.upperBound
            } else {
                newState.secondsRemainingAtPause =
                    max(0, Int(state.expectedArrivalSeconds.upperBound.timeIntervalSince(now)))
                staleDate = nil
            }
        } else {
            if !fixedEnd {
                let remaining = newState.secondsRemainingAtPause
                    ?? max(0, Int(state.expectedArrivalSeconds.upperBound.timeIntervalSince(now)))
                newState.expectedArrivalSeconds = now...now.addingTimeInterval(TimeInterval(max(0, remaining)))
            }
            newState.secondsRemainingAtPause = nil
            staleDate = newState.expectedArrivalSeconds.upperBound
        }

        let content = ActivityContent(state: newState, staleDate: staleDate)
        Task { await activity.update(content) }
    }

    @objc func start(_ emoji: String, _ name: String, _ timerType: String, _ expectedTimeInSeconds: Int) -> String {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            // Clamp like update(): a nonpositive remaining time (e.g. starting
            // straight into overtime) must not produce a `now...past` range —
            // that's a fatal error.
            let now = Date.now
            let end = Calendar.current.date(byAdding: .second, value: (expectedTimeInSeconds), to: now)!
            let future = max(now, end)
            let date = now...future
            let initialContentState = TimerAttributes.ContentState(emoji: emoji, expectedArrivalSeconds: date)
            let activityAttributes = TimerAttributes(name: name, timerType: timerType)
            // Stale exactly when the timer ends: the app may never get to run
            // again (suspended/killed at zero), and staleDate is the only
            // app-free re-render the system gives us — the widget switches to
            // its "Time's up" state instead of sitting on a live-looking 0:00.
            let activityContent = ActivityContent(state: initialContentState, staleDate: future, relevanceScore: 100)
            
            do {
                let activity = try Activity.request(attributes: activityAttributes, content: activityContent)
                return activity.id
            } catch (let error) {
                print("Error requesting Live Activity \(error.localizedDescription).")
                return "Error"
            }
        } else {
            return "Activities not enabled"
        }
   }
}
