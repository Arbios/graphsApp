import CoreGraphics
import UIKit.UIGeometry

// MARK: Then

protocol Then { }

// MARK: - Then (Any)

extension Then where Self: Any {

    // MARK: - Internal Methods

    @inlinable
    func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }

    @inlinable
    func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }
}

// MARK: - Then (AnyObject)

extension Then where Self: AnyObject {

    // MARK: - Internal Methods

    @inlinable
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

// MARK: - NSObject (Then)

extension NSObject: Then { }

// MARK: - CGPoint (Then)

extension CGPoint: Then { }

// MARK: - CGRect (Then)

extension CGRect: Then { }

// MARK: - CGSize (Then)

extension CGSize: Then { }

// MARK: - CGVector (Then)

extension CGVector: Then { }

// MARK: - Array (Then)

extension Array: Then { }

// MARK: - Dictionary (Then)

extension Dictionary: Then { }

// MARK: - Set (Then)

extension Set: Then { }

// MARK: - UIEdgeInsets (Then)

extension UIEdgeInsets: Then { }

// MARK: - UIOffset (Then)

extension UIOffset: Then { }

// MARK: - UIRectEdge (Then)

extension UIRectEdge: Then { }

// MARK: - JSONEncoder (Then)

extension JSONEncoder: Then { }

// MARK: - JSONDecoder (Then)

extension JSONDecoder: Then { }

// MARK: - URLRequest (Then)

extension URLRequest: Then { }
