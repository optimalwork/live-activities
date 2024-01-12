import Foundation
import ActivityKit

@available(iOS 16.2, *)
@objc public class LiveActivity: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    
    @objc func start(_ emoji: String, _ name: String, _ expectedTimeInSeconds: Int) -> String {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            var future = Calendar.current.date(byAdding: .minute, value: (0), to: Date())!
            future = Calendar.current.date(byAdding: .second, value: (expectedTimeInSeconds), to: future)!
            let date = Date.now...future
            let initialContentState = TimerAttributes.ContentState(emoji: emoji, expectedArrivalSeconds: date)
            let activityAttributes = TimerAttributes(name: name)
            let activityContent = ActivityContent(state: initialContentState, staleDate: Calendar.current.date(byAdding: .minute, value: 30, to: Date())!, relevanceScore: 100)
            
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
