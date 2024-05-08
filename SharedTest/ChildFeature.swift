import ComposableArchitecture
import SwiftUI

@Reducer public struct ChildFeature: Sendable {
  public init() {}

  @ObservableState public struct State: Equatable {
    @Shared(.counter) var counter

    public init() {}
  }

  public enum Action: Sendable { case count }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .count:
        state.counter.count += 1
        return .none
      }
    }
  }
}

public struct ChildFeatureView: View {
  let store: StoreOf<ChildFeature>

  public init(store: StoreOf<ChildFeature>) { self.store = store }

  public var body: some View {
    Button("child: \(self.store.counter.count)") { self.store.send(.count) }
  }
}
