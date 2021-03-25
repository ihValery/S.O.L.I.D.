import Foundation

class LocalDataFetcher: NetworkDataFetcher
{
    override func fetchGenericJSONData<T>(urlString: String, complitionResponse: @escaping (T?) -> Void) where T : Decodable {
        //Проверили существует ли путь к файлу
        guard let file = Bundle.main.url(forResource: urlString, withExtension: nil) else {
            print("Не смогли найти \(urlString) в главном Bundle")
            complitionResponse(nil)
            return
        }
        //Лежит ли data в этом файле
        let data = try? Data(contentsOf: file)
        
        //Парсинг файла
        let decoded = self.decodeJSON(type: T.self, data: data)
        //Выносим decoded наружу
        complitionResponse(decoded)
    }
}
