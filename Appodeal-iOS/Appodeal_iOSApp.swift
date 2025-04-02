import SwiftUI

@main
struct Appodeal_iOSApp: App {
    // You can set the AppDelegate here
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
