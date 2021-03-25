import UIKit

class ViewController: UIViewController
{
    let urlTestJson = "https://raw.githubusercontent.com/softex-group/task-mobile/master/test.json"
    let urlFreeGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/games/10/explicit.json"
    let urlNewGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/10/explicit.json"
    
    var networkDataFetcher = NetworkDataFetcher()
    let dataStore = DataStore()
    
    @IBOutlet weak var textFieldToEnterName: UITextField!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var viewForDesign: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        displayingButton(bool: false)
        
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
    
    func changeEmail()
    {
        guard let textEmail = textFieldToEnterName.text else { return }
        displayingButton(bool: isValidEmail(textEmail))
    }
    
    //MARK: - User interface
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField)
    {
        changeEmail()
        displayNameLabel.text = textFieldToEnterName.text
        easterEgg()
    }
    
    @IBAction func fakeSaveAction(_ sender: Any)
    {
        //Мы сюда не попадем при пустом textFieldToEnterName.text
        dataStore.fakeSaveNameInCache(email: textFieldToEnterName.text!)
        showAlert()
        textFieldToEnterName.text = ""
        displayingButton(bool: false)
    }
    
    private func showAlert()
    {
        let alert = UIAlertController(title: "Фейковый вход произведен", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    //MARK: - Business Logic Button Сustomization
    
    private func easterEgg()
    {
        guard let easterText = textFieldToEnterName.text else { return }
        switch easterText {
            case "S":
                displayNameLabel.text = "Single Responsibly Principle\nПринцип единственной ответственности"
            case "O":
                displayNameLabel.text = "Open Closed Principle\nПринцип открытости/закрытости"
            case "L":
                displayNameLabel.text = "Liskov Substitution Principle\nПринцип подстановки Барбары Лисков"
            case "I":
                displayNameLabel.text = "Interface Segregation Principle\nПринцип разделения интерфейса"
            case "D":
                displayNameLabel.text = "Dependency Inversion Principle\nПринцип инверсии зависимостей"
            default:
                return
        }
    }
    
    private func displayingButton(bool: Bool)
    {
        saveButton.alpha = bool ? 1 : 0.3
        saveButton.isEnabled = bool
    }
    
    private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
    }
    
    private func designButton()
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


