import ComposableArchitecture
import SwiftUI

@Reducer public struct CounterFeature: Sendable {
  public init() {}

  @ObservableState public struct State: Equatable {
    @Shared(.counter) public  var counter

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

public struct CounterView: View {
  let store: StoreOf<CounterFeature>

  public init(store: StoreOf<CounterFeature>) { self.store = store }

  public var body: some View { Button("Counter count: \(self.store.counter.count)") { self.store.send(.count) } }
}
