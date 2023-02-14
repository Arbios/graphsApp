import Foundation

// MARK: StorageService

protocol StorageService: DefaultService {
    func savePoints<Element: Encodable>(_ points: [Element], with name: String, completion: @escaping VoidResultBlock)
}
