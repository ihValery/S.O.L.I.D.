import Foundation

protocol DataFetcher
{
    func fetchGenericJSONData<T: Decodable>(urlString: String, complitionResponse: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher
{

    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, complitionResponse: @escaping (T?) -> Void)
    {
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Ошибка при запросе \(error.localizedDescription)")
                complitionResponse(nil)
            }
            let decoded = self.decodeJSON(type: T.self, data: data)
            complitionResponse(decoded)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T?
    {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let response = try decoder.decode(type.self, from: data)
            return response
        } catch let errorJson {
            print("Не смогли распарсить", errorJson)
            return nil
        }
    }
}
