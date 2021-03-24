import Foundation

class DataStore
{    
    func fakeSaveNameInCache(name: String)
    {
        print("Ваше имя \(name) - сохраненно")
    }
    
    func fakeGetNameInCache() -> String
    {
        return "Valery"
    }
}
