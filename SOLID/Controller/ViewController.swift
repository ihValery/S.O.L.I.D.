import UIKit

class ViewController: UIViewController
{
    let urlTestJson = "https://raw.githubusercontent.com/softex-group/task-mobile/master/test.json"
    let urlFreeGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/games/10/explicit.json"
    let urlNewGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/10/explicit.json"
    
//    var networkServise = NetworkService()
    var networkDataFetcher = NetworkDataFetcher()
    let dataStore = DataStore()
    
    //Элементы пользовательского элемента
    @IBOutlet weak var enterYourNameLabel: UILabel!
    @IBOutlet weak var textFieldToEnterName: UITextField!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var viewForDesign: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        networkDataFetcher.fetchFreeGames(urlString: urlFreeGames) { (freeGames) in
            print(freeGames?.feed.results.first?.name)
        }
        
        networkDataFetcher.fetchNewGames(urlString: urlNewGames) { (newGames) in
            print(newGames?.feed.results.first?.name)
            print(newGames?.feed.results[9].name)
        }
        
        networkDataFetcher.fetchCountry(urlString: urlTestJson) { (countries) in
            print(countries?.first?.Name)
        }
        designButton()
    }
    
    //MARK: - Business Logic
    func changeName()
    {
        guard let textName = textFieldToEnterName.text, textName != "" else {
            showAlert()
            return
        }
        dataStore.fakeSaveNameInCache(name: textName)
    }
    
    //MARK: - User interface
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField)
    {
        displayNameLabel.text = textFieldToEnterName.text
    }
    
    @IBAction func fakeSaveAction(_ sender: Any)
    {
        changeName()
        textFieldToEnterName.text = ""
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: "Нечего сохранять", message: "Попробуй указать имя", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func designButton()
    {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = viewForDesign.bounds
        viewForDesign.layer.insertSublayer(gradient, at: 0)
        viewForDesign.mask = saveButton
        saveButton.layer.cornerRadius = 7
        saveButton.layer.borderWidth = 2.0
    }
}

