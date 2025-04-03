import UIKit
import Appodeal


final class MyAppDelegate: UIResponder, UIApplicationDelegate, AppodealInitializationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // Optional configuration (turn off caching for specific ad types)
//        Appodeal.setAutocache(true, types: .interstitial)
        Appodeal.setLogLevel(.verbose)
        Appodeal.setTestingEnabled(true)
        
        // Set the initialization delegate for Appodeal
        Appodeal.setInitializationDelegate(self)
        
        // Initialize Appodeal with the API Key and ad types
        Appodeal.initialize(
            withApiKey: "a05a20335c7ebe5af82bd007139548cff952be2075d30a46",
            types: [.interstitial, .banner, .rewardedVideo]
        )
        
        return true
    }
    
    // Appodeal SDK did complete initialization callback
    func appodealSDKDidInitialize() {
        // Optional: Handle actions once the SDK has initialized
        print("Appodeal SDK Initialization Complete")
    }
}
