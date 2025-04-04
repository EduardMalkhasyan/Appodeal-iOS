import SwiftUI

@main
struct Appodeal_iOSApp: App {
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
