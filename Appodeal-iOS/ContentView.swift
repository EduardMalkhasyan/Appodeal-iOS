import SwiftUI
import Appodeal

struct ContentView: View {
    // Get the root view controller from the connected scenes
    var rootViewController: UIViewController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first?.rootViewController
        }
        return nil
    }

    var body: some View {
        VStack(spacing: 20) {
            Button("Initialize Appodeal") {
                // Enable test mode in Appodeal initialization
                Appodeal.initialize(withApiKey: "97e8e865870a2f0b8c32082332c5c423350be3ae4fd87e26", types: [.interstitial, .banner, .rewardedVideo])
                
                Appodeal.setTestingEnabled(true) 
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Show Interstitial Ad") {
                if Appodeal.isReadyForShow(with: .interstitial), let rootVC = rootViewController {
                    Appodeal.showAd(AppodealShowStyle.interstitial, rootViewController: rootVC)
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Show Banner Ad") {
                if let rootVC = rootViewController {
                    Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: rootVC)
                }
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Show Rewarded Ad") {
                if Appodeal.isReadyForShow(with: .rewardedVideo), let rootVC = rootViewController {
                    Appodeal.showAd(AppodealShowStyle.rewardedVideo, rootViewController: rootVC)
                }
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
