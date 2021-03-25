import Foundation

class DataFetcherService
{
    var networkDataFetcher: DataFetcher
    var localDataFetcher: DataFetcher
    
    //Авноматически инициализировали его и как NetworkDataFetcher()
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher(), localDataFetcher: DataFetcher = LocalDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
        self.localDataFetcher = localDataFetcher
    }
    
    func fetchNewGames(completion: @escaping (AppGroup?) -> Void)
    {
        let urlNewGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/10/explicit.json"
        networkDataFetcher.fetchGenericJSONData(urlString: urlNewGames, complitionResponse: completion)
    }
    
    func fetchFreeGames(completion: @escaping (AppGroup?) -> Void)
    {
        let urlFreeGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/games/10/explicit.json"
        networkDataFetcher.fetchGenericJSONData(urlString: urlFreeGames, complitionResponse: completion)
    }
 
    func fetchCountry(completion: @escaping ([Country]?) -> Void)
    {
        let urlTestJson = "https://raw.githubusercontent.com/softex-group/task-mobile/master/test.json"
        networkDataFetcher.fetchGenericJSONData(urlString: urlTestJson, complitionResponse: completion)
    }
    
    func fetchLocalCountry(completion: @escaping ([Country]?) -> Void)
    {
        let localUrlString = "localJSON.txt"
        localDataFetcher.fetchGenericJSONData(urlString: localUrlString, complitionResponse: completion)
    }
}
