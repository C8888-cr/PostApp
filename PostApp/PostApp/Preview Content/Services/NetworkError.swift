//
//  NetworkError.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//


// NetworkError.swift
import Foundation
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(statusCode: Int) // Beispiel für Serverfehler
    case unknownError(Error?) // Für alle anderen Fehler
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Ungültige URL."
        case .noData: return "Keine Daten empfangen."
        case .decodingError(let error): return "Fehler beim Decodieren der Daten: \(error.localizedDescription)"
        case .serverError(let statusCode): return "Serverfehler: Status Code \(statusCode)."
        case .unknownError(let error): return "Ein unbekannter Fehler ist aufgetreten: \(error?.localizedDescription ?? "Keine Details")."
        }
    }
}