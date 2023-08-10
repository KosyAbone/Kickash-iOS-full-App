
import Foundation

class MessageApiHandler  {
    static func executeAPIRequest<T: Decodable>(url: URL, httpMethod: String = "GET", requestBody: Data? = nil, responseHandler: ((Result<T, Error>) -> Void)? = nil) {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        
        if let requestBody = requestBody {
            //Forcing JSON for now because no message method uses other types
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestBody
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                responseHandler?(.failure(error))
                Utility.debugLog("Invalid request, " + error.localizedDescription)
                return
            }
            
            guard let data = data else {
                Utility.debugLog("Invalid data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data)
                responseHandler?(.success(response))
            } catch {
                responseHandler?(.failure(error))
            }
        }
        
        dataTask.resume()
    }

}
