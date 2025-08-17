import Foundation


class HttpClient {
    
    static let shared = HttpClient()
        private init() {}
    
    private func handleResponse<T: Decodable>(_ data: Data, _ response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RepositoryError.unknown(nil) // Unbekannter Fehler, wenn keine HTTP-Antwort
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw RepositoryError.serverError(statusCode: httpResponse.statusCode) // Serverfehler
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data) // Versucht, die Daten zu dekodieren
        } catch {
            throw RepositoryError.decodingError // Dekodierungsfehler, wenn das JSON nicht geparst werden kann
        }
    }
    
    func get<T: Decodable>(_ urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw RepositoryError.invalidURL // Fehlerhafte URL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url) // Führt die Netzwerkanfrage aus
            return try handleResponse(data, response) // Verarbeitet die Antwort
        } catch {
            throw RepositoryError.networkError(error) // Netzwerkfehler während der Anfrage
        }
    }
    
    func post<T: Encodable, U: Decodable>(_ urlString: String, data: T) async throws -> U {
        guard let url = URL(string: urlString) else {
            throw RepositoryError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(data) // Kodiert die Daten in JSON
        } catch {
            throw RepositoryError.decodingError
        }
        
        do {
            let (responseData, response) = try await URLSession.shared.data(for: request)
            return try handleResponse(responseData, response) // Verarbeitet die Antwort
        } catch {
            throw RepositoryError.networkError(error)
        }
    }
    
    func put<T: Encodable, U: Decodable>(_ urlString: String, data: T) async throws -> U {
        guard let url = URL(string: urlString) else {
            throw RepositoryError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(data) // Kodiert die Daten in JSON
        } catch {
            throw RepositoryError.decodingError
        }
        
        do {
            let (responseData, response) = try await URLSession.shared.data(for: request)
            return try handleResponse(responseData, response) // Verarbeitet die Antwort
        } catch {
            throw RepositoryError.networkError(error)
        }
    }
    
    func delete(_ urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            throw RepositoryError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RepositoryError.unknown(nil)
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw RepositoryError.serverError(statusCode: httpResponse.statusCode)
            }
        } catch {
            throw RepositoryError.networkError(error)
        }
    }
}
