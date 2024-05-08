import ComposableArchitecture
import SwiftUI

extension PersistenceKey where Self == PersistenceKeyDefault<InMemoryKey<GrandChildFeature.State>> {
  public static var counter: Self { PersistenceKeyDefault(.inMemory("counter"), .init()) }
}

@Reducer public struct GrandChildFeature: Sendable {
  public init() {}

  @ObservableState public struct State: Equatable {
    public var count = 0

    public init() {}
  }

  public enum Action: Sendable { case count }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .count:
        state.count += 1
        return .none
      }
    }
  }
}

public struct GrandChildFeatureView: View {
  let store: StoreOf<GrandChildFeature>

  public init(store: StoreOf<GrandChildFeature>) { self.store = store }

  public var body: some View {
    Button("grandChild: \(self.store.count)") { self.store.send(.count) }
  }
}
