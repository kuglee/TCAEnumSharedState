import ComposableArchitecture

extension PersistenceKey where Self == PersistenceKeyDefault<InMemoryKey<CounterState>> {
  public static var counter: Self { PersistenceKeyDefault(.inMemory("counter"), .init()) }
}

public struct CounterState: Equatable { public var count = 0 }
