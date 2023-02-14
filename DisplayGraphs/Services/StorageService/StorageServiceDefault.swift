import Foundation

// MARK: StorageServiceDefault

final class StorageServiceDefault {

    // MARK: - Types

    enum SavingError: Error {
        case failedToSave

        var localizedDescription: String {
            switch self {
                case .failedToSave:
                    return "Не удалось сохранить файл на диск"
            }
        }
    }

    // MARK: - Private Properties

    private weak var serviceLocator: ServiceLocator!

    // MARK: - Lifecycle

    init(serviceLocator: ServiceLocator!) {
        self.serviceLocator = serviceLocator
    }

}

// MARK: StorageServiceDefault: StorageService

extension StorageServiceDefault: StorageService {

    // MARK: - Internal Methods

    func savePoints<Element>(_ points: [Element], with name: String, completion: @escaping VoidResultBlock) where Element : Encodable {

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        guard let jsonData = try? encoder.encode(points),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            print("Failed to encode the array to JSON")
            return
        }

        // Save the JSON string to a text file
        let fileName = name
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)

            do {
                try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
                print("Array saved to file:", fileURL.path)
                completion(.success(()))
            } catch {
                completion(.failure(SavingError.failedToSave))
            }
        }

    }
}
