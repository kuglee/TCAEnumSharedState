import ComposableArchitecture
import Popup
import SwiftUI

@Reducer public struct ChildFeature: Sendable {
  public init() {}

  @ObservableState public struct State: Equatable {
    @Shared(.counter) var counterState
    @Presents var destination: Destination.State?

    public init() {}
  }

  public enum Action: Sendable {
    case destination(PresentationAction<Destination.Action>)
    case counterAction(CounterFeature.Action)
    case showCounterButtonTapped
  }

  public var body: some ReducerOf<Self> {
    Scope(state: \.counterState, action: \.counterAction) { CounterFeature() }

    Reduce { state, action in
      switch action {
      case .destination: return .none
      case .counterAction: return .none
      case .showCounterButtonTapped:
        state.destination = .counter(state.counterState)

        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }

  @Reducer(state: .equatable, action: .sendable) public enum Destination {
    case counter(CounterFeature)
  }
}

public struct ChildFeatureView: View {
  @Bindable var store: StoreOf<ChildFeature>

  public init(store: StoreOf<ChildFeature>) { self.store = store }

  public var body: some View {
    VStack {
      CounterView(store: self.store.scope(state: \.counterState, action: \.counterAction))
      Button("Show counter in a popup") { self.store.send(.showCounterButtonTapped) }
        .popup(
          item: self.$store.scope(state: \.destination?.counter, action: \.destination.counter),
          attachmentAnchor: .point(.bottom),
          attachmentEdge: .bottom,
          alignment: .bottom
        ) { CounterView(store: $0) }
    }
  }
}
