import SwiftUI

/// WWDC22 CTF interactive scene view entry point
@main
struct Main: App {
    var body: some Scene {
        WindowGroup {
            WWDCSceneView()
                .preferredColorScheme(.dark)
        }
    }
}
