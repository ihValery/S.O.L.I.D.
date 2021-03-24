import Foundation

class NetworkDataFetcher
{
    //Устанавливаем зависимость
    var networkService = NetworkService()
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    //Декодируем полученные JSON данные в конкретную модель
    func fetchNewGames(urlString: String, completion: @escaping (AppGroup?) -> Void)
    {
        networkService.request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(AppGroup.self, from: data)
            completion(response)
        }
    }
    
    //Декодируем полученные JSON данные в конкретную модель
    func fetchFreeGames(urlString: String, completion: @escaping (AppGroup?) -> Void)
    {
        networkService.request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(AppGroup.self, from: data)
            completion(response)
        }
    }
    
    //Декодируем полученные JSON данные в конкретную модель
    func fetchCountry(urlString: String, completion: @escaping ([Country]?) -> Void)
    {
        networkService.request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode([Country].self, from: data)
            completion(response)
        }
    }
}
