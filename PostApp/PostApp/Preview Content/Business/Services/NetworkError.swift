import Foundation
enum RepositoryError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error?)
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Ungültige URL."
        case .networkError(let error):
            return "Netzwerkfehler: \(error.localizedDescription)"
        case .decodingError:
            return "Fehler beim Verarbeiten der Antwort."
        case .serverError(let statusCode):
            return "Serverfehler mit Statuscode \(statusCode)."
        case .unknown(let error):
            return "Ein unbekannter Fehler ist aufgetreten: \(error?.localizedDescription ?? "Keine Details")."
        }
    }
}
