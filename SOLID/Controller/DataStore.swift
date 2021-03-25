import Foundation

class DataStore
{    
    func fakeSaveNameInCache(email: String)
    {
        print("Вы якобы вошли в \(email)")
    }
    
    func fakeGetNameInCache() -> String
    {
        return "Valery"
    }
}
