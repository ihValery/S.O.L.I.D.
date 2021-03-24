import UIKit

struct Country: Decodable
{
    var Id: String
    var Time: String
    var Name: String
    var Image: String?
}

class ViewController: UIViewController
{
    let urlString = "https://raw.githubusercontent.com/softex-group/task-mobile/master/test.json"
    
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
        dataFetcher()
        designButton()
    }
    
    //MARK: - Business Logic
    func changeName()
    {
        guard let textName = textFieldToEnterName.text, textName != "" else {
            showAlert()
            return
        }
        fakeSaveNameInCache(name: textName)
    }
    
    //MARK: - Data Storage
    
    func fakeSaveNameInCache(name: String)
    {
        print("Ваше имя \(name) - сохраненно")
    }
    
    func fakeGetNameInCache() -> String
    {
        return "Valery"
    }
    
    //MARK: - Networking
    
    func dataFetcher()
    {
        request { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode([Country].self, from: data)
            print(response)
        }
    }
    
    func request(completion: @escaping (Data?, Error?) -> Void)
    {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
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
