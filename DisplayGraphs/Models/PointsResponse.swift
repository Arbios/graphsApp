import Foundation

// MARK: PointsResponse

struct PointsResponse: Codable {

    // MARK: - Internal Properties

    var points: [Point]
}

// MARK: Point

struct Point: Codable {

    // MARK: - Internal Properties

    var x: Double
    var y: Double
}
