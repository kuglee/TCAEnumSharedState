import ComposableArchitecture
import Popup
import SwiftUI

@Reducer public struct AppFeature: Sendable {
  public init() {}

  @ObservableState public struct State: Equatable {
    @Shared(.counter) var counter

    var childState: ChildFeature.State = .init()
    @Presents var destination: Destination.State?

    public init() {}
  }

  public enum Action: Sendable {
    case count
    case destination(PresentationAction<Destination.Action>)
    case showChildButtonTapped
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .count:
        state.counter.count += 1
        return .none
      //      case .childAction: return .none
      case .destination: return .none
      case .showChildButtonTapped:
        state.destination = .child(.init())

        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }

  @Reducer(state: .equatable, action: .sendable) public enum Destination {
    case child(ChildFeature)
  }
}

public struct AppFeatureView: View {
  @Bindable var store: StoreOf<AppFeature>

  public init(store: StoreOf<AppFeature>) { self.store = store }

  public var body: some View {
    VStack {
      Text("app: \(self.store.state.counter.count)")
      Text("child: \(self.store.state.childState.grandChildState.count)")
      Button("app: \(self.store.counter.count)") { self.store.send(.count) }
      Button("Show child") { self.store.send(.showChildButtonTapped) }
        .popup(item: self.$store.scope(state: \.destination?.child, action: \.destination.child),
               attachmentAnchor: .point(.bottomTrailing),
               attachmentEdge: .bottom,
               alignment: .bottomLeading
        ) {
          ChildFeatureView(store: $0)
        }
    }
  }
}
