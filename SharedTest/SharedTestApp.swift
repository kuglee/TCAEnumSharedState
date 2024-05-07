import SwiftUI
import ComposableArchitecture

@main
struct SharedTestApp: App {
  @Bindable var store = Store.init(initialState: .init(), reducer: { AppFeature()._printChanges() })

    var body: some Scene {
        WindowGroup {
          AppFeatureView(store: store)
        }
    }
}
