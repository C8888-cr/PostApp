import Foundation
enum HTTPError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case noData
    case unknown
}
class HTTPClient {
    static let shared = HTTPClient()
    private init() {}
    func data(from url: URL) async throws -> (Data, URLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.invalidResponse(statusCode: -1) 
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw HTTPError.invalidResponse(statusCode: httpResponse.statusCode)
            }
            return (data, response)
        } catch {
            throw error
        }
    }
    func upload(for request: URLRequest, from data: Data) async throws -> (Data, URLResponse) {
        do {
            let (uploadData, response) = try await URLSession.shared.upload(for: request, from: data)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.invalidResponse(statusCode: -1)
            }
            guard (200...299).contains(httpResponse.statusCode) else { //Akzeptiere auch andere Erfolgs-Codes
                throw HTTPError.invalidResponse(statusCode: httpResponse.statusCode)
            }
            return (uploadData, response)
        } catch {
            throw error
        }
    }
}
