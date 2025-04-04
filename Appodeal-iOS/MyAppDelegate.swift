import UIKit
import Appodeal


final class MyAppDelegate: UIResponder, UIApplicationDelegate, AppodealInitializationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        //Appodeal.setAutocache(true, types: .interstitial)
        Appodeal.setLogLevel(.verbose)
        Appodeal.setTestingEnabled(true)
        
        Appodeal.setInitializationDelegate(self)
        
        Appodeal.initialize(
            withApiKey: "a05a20335c7ebe5af82bd007139548cff952be2075d30a46",
            types: [.interstitial, .banner, .rewardedVideo, .MREC, .nativeAd]
        )
        
        return true
    }
    
    func appodealSDKDidInitialize() {
        print("Appodeal SDK Initialization Complete")
    }
}
