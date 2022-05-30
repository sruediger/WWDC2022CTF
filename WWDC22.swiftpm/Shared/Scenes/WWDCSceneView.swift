import SwiftUI

/// Main interactive scene presenter and manager
struct WWDCSceneView: View {
    @State internal var viewModel = WWDCSceneViewModel()
    
    var body: some View {
        let device = Snippets.getCurrentDevice()
        if device != .pad && device != .mac {
            self.createUnsupportedDeviceWarningView()
        }else {
            self.autoSwitchViews()
                .background(Color.black)
        }
    }
}
