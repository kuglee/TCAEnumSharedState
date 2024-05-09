import ComposableArchitecture
import SwiftUI

extension PersistenceKey where Self == PersistenceKeyDefault<InMemoryKey<Counter>> {
  public static var counter: Self { PersistenceKeyDefault(.inMemory("counter"), .init()) }
}

public struct Counter: Equatable {
  public var count = 0

  public init() {}
}
