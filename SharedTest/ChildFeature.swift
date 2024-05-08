import ComposableArchitecture
import SwiftUI

@Reducer public struct ChildFeature: Sendable {
  public init() {}

  @ObservableState public struct State: Equatable {
    @Shared(.counter) var grandChildState: GrandChildFeature.State

    public init() {}
  }

  public enum Action: Sendable { case grandChildAction(GrandChildFeature.Action) }

  public var body: some ReducerOf<Self> {
    Scope(state: \.grandChildState, action: \.grandChildAction) {
      GrandChildFeature()
    }
    Reduce { state, action in
      switch action {
      case .grandChildAction:
        return .none
      }
    }
  }
}

public struct ChildFeatureView: View {
  let store: StoreOf<ChildFeature>

  public init(store: StoreOf<ChildFeature>) { self.store = store }

  public var body: some View {
    Text("grandChild: \(self.store.state.grandChildState.count)")
    GrandChildFeatureView(store: self.store.scope(state: \.grandChildState, action: \.grandChildAction))
  }
}

