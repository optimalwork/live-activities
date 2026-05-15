import Foundation
import Capacitor
import ActivityKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@available(iOS 16.2, *)
@objc(LiveActivityPlugin)
public class LiveActivityPlugin: CAPPlugin {
    private let implementation = LiveActivity()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func start(_ call: CAPPluginCall) {
       let emoji = call.getString("emoji")!
       let name = call.getString("name")!
       let timerType = call.getString("timerType") ?? ""
        let expectedTimeInSeconds = call.getInt("expectedTimeInSeconds") ?? 0
        call.resolve([
            "activityId": implementation.start(emoji, name, timerType, expectedTimeInSeconds)
        ])
   }

   @objc func update(_ call: CAPPluginCall){
       let emoji = call.getString("emoji")!
       let activityId = call.getString("activityId")!
       let expectedTimeInSeconds = call.getInt("expectedTimeInSeconds") ?? 0
       let isPaused = call.getBool("isPaused") ?? false
       let secondsRemainingAtPause = call.getInt("secondsRemainingAtPause") ?? 0
       let notify = call.getBool("notify") ?? false
       let activity = Activity<TimerAttributes>.activities.first { $0.id == activityId}

       if activity != nil {
           let future = Calendar.current.date(byAdding: .second, value: expectedTimeInSeconds, to: Date())!
           let date = Date.now...future
           let updateState = TimerAttributes.ContentState(
               emoji: emoji,
               expectedArrivalSeconds: date,
               isPaused: isPaused,
               secondsRemainingAtPause: secondsRemainingAtPause
           )
           let updatedContent = ActivityContent(state: updateState, staleDate: nil)

           Task {
               if notify {
                   let alertConfiguration = AlertConfiguration(title: "Live update", body: "Getting the things done!", sound: .default)
                   await activity?.update(updatedContent, alertConfiguration: alertConfiguration)
               } else {
                   await activity?.update(updatedContent)
               }
           }
       }
       call.resolve()
   }

   @objc func stop(_ call: CAPPluginCall) {
       let activityId = call.getString("activityId")
       let activity = Activity<TimerAttributes>.activities.first { $0.id == activityId}
       if activity != nil {
           Task {
               await activity?.end(dismissalPolicy: .immediate)
           }
       }
       call.resolve()
   }
}
