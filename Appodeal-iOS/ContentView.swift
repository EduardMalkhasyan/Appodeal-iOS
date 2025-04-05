import SwiftUI
import Appodeal

struct ContentView: View {
    @State private var showMREC = false
    @State private var showNativeAd = false
    @State private var nativeAd: APDNativeAd?
    
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
            
            Button("Show Native Ad") {
                loadAndShowNativeAd()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if showNativeAd, let nativeAd = nativeAd {
                NativeAdView(nativeAd: nativeAd)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .padding()
    }
    
    private func loadAndShowNativeAd() {
        let adQueue = APDNativeAdQueue()
        let settings = APDNativeAdSettings.default()
        settings.autocacheMask = [.icon, .media]
        adQueue.settings = settings
        
        adQueue.loadAd()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let loadedAd = adQueue.getNativeAds(ofCount: 1).first {
                self.nativeAd = loadedAd
                self.showNativeAd = true
            } else {
                print("No native ad available yet")
            }
        }
    }
}


struct NativeAdView: UIViewRepresentable {
    let nativeAd: APDNativeAd
    
    func makeUIView(context: Context) -> UIView {
        guard let rootVC = UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?
            .windows
            .first?
            .rootViewController else {
                print("No root view controller found")
                return UIView()
        }
        
        do {
            let adView = try nativeAd.getViewForPlacement("default", withRootViewController: rootVC)
            return adView
        } catch {
            print("Error getting native ad view: \(error)")
            return UIView()
        }
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update if needed
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
