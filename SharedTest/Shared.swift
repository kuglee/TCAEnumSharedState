import ComposableArchitecture

extension PersistenceKey where Self == PersistenceKeyDefault<InMemoryKey<Int>> {
  public static var count: Self { PersistenceKeyDefault(.inMemory("count"), 0) }
}
