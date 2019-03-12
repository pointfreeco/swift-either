public typealias E2<A, Z> = Either<A, Z>
public typealias E3<A, B, Z> = Either<A, E2<B, Z>>
public typealias E4<A, B, C, Z> = Either<A, E3<B, C, Z>>
public typealias E5<A, B, C, D, Z> = Either<A, E4<B, C, D, Z>>
public typealias E6<A, B, C, D, E, Z> = Either<A, E5<B, C, D, E, Z>>
public typealias E7<A, B, C, D, E, F, Z> = Either<A, E6<B, C, D, E, F, Z>>
public typealias E8<A, B, C, D, E, F, G, Z> = Either<A, E7<B, C, D, E, F, G, Z>>
public typealias E9<A, B, C, D, E, F, G, H, Z> = Either<A, E8<B, C, D, E, F, G, H, Z>>
public typealias E10<A, B, C, D, E, F, G, H, I, Z> = Either<A, E9<B, C, D, E, F, G, H, I, Z>>
public typealias E11<A, B, C, D, E, F, G, H, I, J, Z> = Either<A, E10<B, C, D, E, F, G, H, I, J, Z>>

public enum Done {}

extension Done: Decodable {
  public init(from decoder: Decoder) throws {
    switch self {}
  }
}

extension Done: Encodable {
  public func encode(to encoder: Encoder) throws {
  }
}

public typealias Either1<A> = E2<A, Done>
public typealias Either2<A, B> = E3<A, B, Done>
public typealias Either3<A, B, C> = E4<A, B, C, Done>
public typealias Either4<A, B, C, D> = E5<A, B, C, D, Done>
public typealias Either5<A, B, C, D, E> = E6<A, B, C, D, E, Done>
public typealias Either6<A, B, C, D, E, F> = E7<A, B, C, D, E, F, Done>
public typealias Either7<A, B, C, D, E, F, G> = E8<A, B, C, D, E, F, G, Done>
public typealias Either8<A, B, C, D, E, F, G, H> = E9<A, B, C, D, E, F, G, H, Done>
public typealias Either9<A, B, C, D, E, F, G, H, I> = E10<A, B, C, D, E, F, G, H, I, Done>
public typealias Either10<A, B, C, D, E, F, G, H, I, J> = E11<A, B, C, D, E, F, G, H, I, J, Done>

extension Either {
  public static func in1(_ value: Left) -> Either {
    return .left(value)
  }

  public static func in2<A, B>(_ value: A) -> Either
    where Right == E2<A, B> {
      return .right(.left(value))
  }

  public static func in3<A, B, C>(_ value: B) -> Either
    where Right == E3<A, B, C> {
      return .right(.right(.left(value)))
  }

  public static func in4<A, B, C, D>(_ value: C) -> Either
    where Right == E4<A, B, C, D> {
      return .right(.right(.right(.left(value))))
  }

  public static func in5<A, B, C, D, E>(_ value: D) -> Either
    where Right == E5<A, B, C, D, E> {
      return .right(.right(.right(.right(.left(value)))))
  }

  public static func in6<A, B, C, D, E, F>(_ value: E) -> Either
    where Right == E6<A, B, C, D, E, F> {
      return .right(.right(.right(.right(.right(.left(value))))))
  }

  public static func in7<A, B, C, D, E, F, G>(_ value: F) -> Either
    where Right == E7<A, B, C, D, E, F, G> {
      return .right(.right(.right(.right(.right(.right(.left(value)))))))
  }

  public static func in8<A, B, C, D, E, F, G, H>(_ value: G) -> Either
    where Right == E8<A, B, C, D, E, F, G, H> {
      return .right(.right(.right(.right(.right(.right(.right(.left(value))))))))
  }

  public static func in9<A, B, C, D, E, F, G, H, I>(_ value: H) -> Either
    where Right == E9<A, B, C, D, E, F, G, H, I> {
      return .right(.right(.right(.right(.right(.right(.right(.right(.left(value)))))))))
  }

  public static func in10<A, B, C, D, E, F, G, H, I, J>(_ value: I) -> Either
    where Right == E10<A, B, C, D, E, F, G, H, I, J> {
      return .right(.right(.right(.right(.right(.right(.right(.right(.right(.left(value))))))))))
  }

  public func at1<R>(_ transform: (Left) -> R) -> R? {
    return self.left.map(transform)
  }

  public func at2<A, B, R>(_ transform: (A) -> R) -> R?
    where Right == E2<A, B> {
      guard
        case let .right(.left(value)) = self
        else { return nil }
      return transform(value)
  }

  public func at3<A, B, C, R>(_ transform: (B) -> R) -> R?
    where Right == E3<A, B, C> {
      guard
        case let .right(.right(.left(value))) = self
        else { return nil }
      return transform(value)
  }

  public func at4<A, B, C, D, R>(_ transform: (C) -> R) -> R?
    where Right == E4<A, B, C, D> {
      guard
        case let .right(.right(.right(.left(value)))) = self
        else { return nil }
      return transform(value)
  }

  public func at5<A, B, C, D, E, R>(_ transform: (D) -> R) -> R?
    where Right == E5<A, B, C, D, E> {
      guard
        case let .right(.right(.right(.right(.left(value))))) = self
        else { return nil }
      return transform(value)
  }

  public func at6<A, B, C, D, E, F, R>(_ transform: (E) -> R) -> R?
    where Right == E6<A, B, C, D, E, F> {
      guard
        case let .right(.right(.right(.right(.right(.left(value)))))) = self
        else { return nil }
      return transform(value)
  }

  public func at7<A, B, C, D, E, F, R, G>(_ transform: (F) -> R) -> R?
    where Right == E7<A, B, C, D, E, F, G> {
      guard
        case let .right(.right(.right(.right(.right(.right(.left(value))))))) = self
        else { return nil }
      return transform(value)
  }

  public func at8<A, B, C, D, E, F, G, H, R>(_ transform: (G) -> R) -> R?
    where Right == E8<A, B, C, D, E, F, G, H> {
      guard
        case let .right(.right(.right(.right(.right(.right(.right(.left(value)))))))) = self
        else { return nil }
      return transform(value)
  }

  public func at9<A, B, C, D, E, F, G, H, I, R>(_ transform: (H) -> R) -> R?
    where Right == E9<A, B, C, D, E, F, G, H, I> {
      guard
        case let .right(.right(.right(.right(.right(.right(.right(.right(.left(value))))))))) = self
        else { return nil }
      return transform(value)
  }

  public func at10<A, B, C, D, E, F, G, H, I, J, R>(_ transform: (I) -> R) -> R?
    where Right == E10<A, B, C, D, E, F, G, H, I, J> {
      guard
        case let .right(.right(.right(.right(.right(.right(.right(.right(.right(.left(value)))))))))) = self
        else { return nil }
      return transform(value)
  }
}
