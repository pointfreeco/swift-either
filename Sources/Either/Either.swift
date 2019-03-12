public enum Either<Left, Right> {
  case left(Left)
  case right(Right)

  public var left: Left? {
    return self.either(ifLeft: Optional.some, ifRight: { _ in Optional.none })
  }

  public var right: Right? {
    return self.either(ifLeft: { _ in Optional.none }, ifRight: Optional.some)
  }

  public func either<Value>(
    ifLeft: (Left) throws -> Value,
    ifRight: (Right) throws -> Value
    ) rethrows -> Value {
    switch self {
    case let .left(left):
      return try ifLeft(left)
    case let .right(right):
      return try ifRight(right)
    }
  }

  public func `do`(
    ifLeft: (Left) throws -> Void,
    ifRight: (Right) throws -> Void
    ) rethrows {
    switch self {
    case let .left(left):
      try ifLeft(left)
    case let .right(right):
      try ifRight(right)
    }
  }

  public func bimap<NewLeft, NewRight>(
    ifLeft transformLeft: (Left) throws -> NewLeft,
    ifRight transformRight: (Right) throws -> NewRight
    ) rethrows -> Either<NewLeft, NewRight> {
    return try self.either(
      ifLeft: { .left(try transformLeft($0)) },
      ifRight: { .right(try transformRight($0)) }
    )
  }

  public func mapLeft<NewLeft>(
    _ transform: (Left) throws -> NewLeft
    ) rethrows -> Either<NewLeft, Right> {
    return try self.bimap(ifLeft: transform, ifRight: { $0 })
  }

  public func mapRight<NewRight>(
    _ transform: (Right) throws -> NewRight
    ) rethrows -> Either<Left, NewRight> {
    return try self.bimap(ifLeft: { $0 }, ifRight: transform)
  }

  public func flatMapLeft<NewLeft>(
    _ transform: (Left) throws -> Either<NewLeft, Right>
    ) rethrows -> Either<NewLeft, Right> {
    return try self.either(ifLeft: transform, ifRight: { .right($0) })
  }

  public func flatMapRight<NewRight>(
    _ transform: (Right) throws -> Either<Left, NewRight>
    ) rethrows -> Either<Left, NewRight> {
    return try self.either(ifLeft: { .left($0) }, ifRight: transform)
  }
}

public struct Errors: Error {
  let errors: [Error]
}

extension Either: Equatable where Left: Equatable, Right: Equatable {
  public static func == (lhs: Either, rhs: Either) -> Bool {
    switch (lhs, rhs) {
    case let (.left(lhs), .left(rhs)):
      return lhs == rhs
    case let (.right(lhs), .right(rhs)):
      return lhs == rhs
    default:
      return false
    }
  }
}

extension Either: Comparable where Left: Comparable, Right: Comparable {
  public static func < (lhs: Either, rhs: Either) -> Bool {
    switch (lhs, rhs) {
    case let (.left(lhs), .left(rhs)):
      return lhs < rhs
    case let (.right(lhs), .right(rhs)):
      return lhs < rhs
    case (.left, .right):
      return true
    case (.right, .left):
      return false
    }
  }
}

extension Either: Hashable where Left: Hashable, Right: Hashable {
  public func hash(into hasher: inout Hasher) {
    self.do(
      ifLeft: { hasher.combine($0) },
      ifRight: { hasher.combine($0) }
    )
  }
}

extension Either: Decodable where Left: Decodable, Right: Decodable {
  public init(from decoder: Decoder) throws {
    do {
      self = try .left(Left(from: decoder))
    } catch let leftError {
      do {
        self = try .right(Right(from: decoder))
      } catch let rightError {
        throw DecodingError.typeMismatch(
          Either.self,
          .init(
            codingPath: decoder.codingPath,
            debugDescription: "Could not decode \(Left.self) or \(Right.self)",
            underlyingError: Errors(errors: [leftError, rightError])
          )
        )
      }
    }
  }
}

extension Either: Encodable where Left: Encodable, Right: Encodable {
  public func encode(to encoder: Encoder) throws {
    return try self.either(
      ifLeft: { try $0.encode(to: encoder) },
      ifRight: { try $0.encode(to: encoder) }
    )
  }
}

#if swift(>=5.0)
extension Either where Left: Error {
  public var asRightResult: Result<Right, Left> {
    return self.either(ifLeft: Result.failure, ifRight: Result.success)
  }
}

extension Either where Right: Error {
  public var asLeftResult: Result<Left, Right> {
    return self.either(ifLeft: Result.success, ifRight: Result.failure)
  }
}
#endif
