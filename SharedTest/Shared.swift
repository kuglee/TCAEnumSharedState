import ComposableArchitecture
import SwiftUI

extension PersistenceKey where Self == PersistenceKeyDefault<InMemoryKey<CounterFeature.State>> {
  public static var counter: Self { PersistenceKeyDefault(.inMemory("counter"), .init()) }
}

