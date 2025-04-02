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
            Button("Show Interstitial Ad") {
                // Ensure the interstitial ad is ready and then show it
                if Appodeal.isReadyForShow(with: .interstitial), let rootVC = rootViewController {
                    Appodeal.showAd(.interstitial, rootViewController: rootVC)
                } else {
                    print("Interstitial Ad is not ready")
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Show Banner Ad") {
                // Ensure the banner ad is ready and then show it
                if let rootVC = rootViewController {
                    Appodeal.showAd(.bannerBottom, rootViewController: rootVC)
                } else {
                    print("Banner Ad failed to load")
                }
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Show Rewarded Ad") {
                // Ensure the rewarded ad is ready and then show it
                if Appodeal.isReadyForShow(with: .rewardedVideo), let rootVC = rootViewController {
                    Appodeal.showAd(.rewardedVideo, rootViewController: rootVC)
                } else {
                    print("Rewarded Video Ad is not ready")
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
