import SwiftUI
import Appodeal

struct ContentView: View {
    
    @State private var showMREC = false
    
    var rootViewController: UIViewController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first?.rootViewController
        }
        return nil
    }

    var body: some View {
        VStack(spacing: 20) {
            Button("Show Interstitial Ad") {
                if Appodeal.isReadyForShow(with: .interstitial), let rootVC = rootViewController {
                    Appodeal.showAd(.interstitial, rootViewController: rootVC)
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Show Banner Ad") {
                if let rootVC = rootViewController {
                    Appodeal.showAd(.bannerBottom, rootViewController: rootVC)
                }
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Show Rewarded Ad") {
                if Appodeal.isReadyForShow(with: .rewardedVideo), let rootVC = rootViewController {
                    Appodeal.showAd(.rewardedVideo, rootViewController: rootVC)
                }
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if showMREC {
            MRECAdView()
            .frame(width: 300, height: 250)
            .padding()
            }
         
            Button("Show MREC Ad") {
                showMREC = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct MRECAdView: UIViewRepresentable {
    func makeUIView(context: Context) -> AppodealMRECView {
        guard let mrecView = AppodealMRECView() else {
            fatalError("Failed to create MREC view")
        }
        
        mrecView.usesSmartSizing = false
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            mrecView.rootViewController = rootVC
        }
        
        mrecView.loadAd()
        return mrecView
    }
    
    func updateUIView(_ uiView: AppodealMRECView, context: Context) {
        // Update the view if needed
    }
}

#Preview {
    ContentView()
}
