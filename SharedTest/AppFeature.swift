import ComposableArchitecture
import Popup
import SwiftUI

@Reducer public struct AppFeature: Sendable {
  public init() {}

  @ObservableState public struct State: Equatable {
    @Shared(.counter) var counter

    var childState: ChildFeature.State = .init()

    public init() {}
  }

  public enum Action: Sendable {
    case count
    case childAction(ChildFeature.Action)
  }

  public var body: some ReducerOf<Self> {
    Scope(state: \.childState, action: \.childAction) { ChildFeature() }

    Reduce { state, action in
      switch action {
      case .count:
        state.counter.count += 1
        return .none
      case .childAction: return .none
      }
    }
  }
}

public struct AppFeatureView: View {
  @Bindable var store: StoreOf<AppFeature>

  public init(store: StoreOf<AppFeature>) { self.store = store }

  public var body: some View {
    VStack {
      Button("App count: \(self.store.counter.count)") { self.store.send(.count) }
      ChildFeatureView(store: self.store.scope(state: \.childState, action: \.childAction))
    }
  }
}
