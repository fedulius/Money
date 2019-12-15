import UIKit
import RealmSwift

class SwapViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var textFieldForMoney: UITextField!
    
    var wallet: Results<Wallet>!
    
    var array: [Wallet] = []
    
    var money = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = persistanceWallet.category.realm
        wallet = realm.objects(Wallet.self)
        
        textFieldForMoney.placeholder = "Введите сумму"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstLabel.isUserInteractionEnabled = true
        firstLabel.layer.borderWidth = 0.5
        firstLabel.layer.borderColor = (UIColor.black).cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(openWalletForFirst))
        firstLabel.addGestureRecognizer(tap)
        if array.count > 1 {
            let preLast = array.count - 2
            firstLabel.text = array[preLast].name
        }
        else if array.count == 1 {
            firstLabel.text = array[0].name
        }
        else {
            firstLabel.text = "from:"
        }
        
        secondLabel.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(openWalletForFirst))
        secondLabel.layer.borderWidth = 0.5
        secondLabel.layer.borderColor = (UIColor.black).cgColor
        secondLabel.addGestureRecognizer(tap2)
        if array.count > 1 && firstLabel.text != "from:"{
            let last = array.count - 1
            secondLabel.text = array[last].name
        }
        else {
            secondLabel.text = "to:"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WalletUIViewController, segue.identifier == "openWallets" {
            vc.delegativ = self
        }
    }
    
    @objc func openWalletForFirst() {
        performSegue(withIdentifier: "openWallets", sender: self)
    }
    
    func alert() {
        let alert = UIAlertController(title: "Выберите кошельки для перевода и укажите сумму", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func swapButton(_ sender: Any) {
        if array.count >= 2 && textFieldForMoney.text != nil {
            money = Int(textFieldForMoney.text ?? "") ?? 0
            let from = array.count - 2
            let to = array.count - 1
            if money != 0 {
                persistanceWallet.category.swapMoney(from: array[from], to: array[to], mny: money)
                _ = navigationController?.popToRootViewController(animated: true)
            }
            else {
                alert()
            }
        }
        else {
            alert()
        }
    }
}

extension SwapViewController: Choose {
    func choosenWallet(obj: Wallet) {
        self.array.append(obj)
    }
}
