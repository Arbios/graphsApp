import Foundation

// MARK: API

extension API {

    // MARK: - Types

    enum Errors: Error {
        case invalidData
    }

    // MARK: - Private Properties

    private var baseURL: URL {
        return URL(string: "https://hr-challenge.interactivestandard.com/")!
    }

    private var path: String {
        switch self {
            case .fetchPoints:
                return "api/test/points"
        }
    }

    private var queryItems: [URLQueryItem] {
        switch self {
            case .fetchPoints(let count):
                return [URLQueryItem(name: "count", value: String(count))]
        }
    }

    // MARK: - Internal Properties

    var url: URL { baseURL.appendingPathComponent(path).appending(queryItems: queryItems) }
}

// MARK: APIServiceDefault

final class APIServiceDefault {

    // MARK: - Private Properties

    private weak var serviceLocator: ServiceLocator!

    // MARK: - Lifecycle

    init(serviceLocator: ServiceLocator!) {
        self.serviceLocator = serviceLocator
    }
}

// MARK: APIServiceDefault: APIService

extension APIServiceDefault: APIService {

    func request<Model>(_ api: API, queue: DispatchQueue, then completion: @escaping (Result<Model, Error>) -> Void) where Model : Decodable {

        URLSession.shared.dataTask(with: api.url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(API.Errors.invalidData))
                return
            }

            do {
                let forecast = try JSONDecoder().decode(Model.self, from: data)
                completion(.success(forecast))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
