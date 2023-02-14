import Foundation

// MARK: - API

enum API {
    case fetchPoints(Int)
}

// MARK: - APIService

protocol APIService: DefaultService {
    func request<Model: Decodable>(
        _ api: API,
        queue: DispatchQueue,
        then completion: @escaping (Result<Model, Error>) -> Void
    )
    func request<Model: Decodable>(
        _ api: API,
        then completion: @escaping (Result<Model, Error>) -> Void
    )
    func request(_ api: API, then completion: @escaping VoidResultBlock)
}

extension APIService {
    func request<Model: Decodable>(
        _ api: API,
        then completion: @escaping (Result<Model, Error>) -> Void
    ) {
        request(api, queue: .main, then: completion)
    }

    func request(_ api: API, then completion: @escaping VoidResultBlock) {
        request(api, then: completion)
    }
}
