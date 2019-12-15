import UIKit
import RealmSwift

protocol Choose {
    func choosenWallet(obj: Wallet)
}

class IncomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelInc: UILabel!
    @IBOutlet weak var saveButtonOut: UIButton!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var walletLabel: UILabel!
    
    var select: CategoryIncome?
    var consumtion: CategoryConsumtion?
    var wallet: Wallet?
    var proper = 0
    var numbers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  select != nil {
            labelInc.text = select?.categorysName
            priceLabel.placeholder = "Расход"
            imageView.image = UIImage(named: select?.categorysImage ?? "")
        } else {
            labelInc.text = consumtion?.consumtionName
            priceLabel.placeholder = "Доход"
            imageView.image = UIImage(named: consumtion?.consumtionImage ?? "")
        }
        if wallet != nil {
            walletLabel.textColor = .black
            walletLabel.text = wallet?.name
        }
        else {
            walletLabel.text = "Выберите кошелек"
            walletLabel.textColor = .lightGray
        }
        priceLabel.layer.borderWidth = 0.5
        priceLabel.layer.borderColor = (UIColor.black).cgColor
        
        walletLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(checkFunc))
        walletLabel.layer.borderWidth = 0.8
        walletLabel.layer.borderColor = (UIColor.black).cgColor
        walletLabel.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WalletUIViewController, segue.identifier == "walletSegue" {
            vc.delegativ = self
        }
    }
    
    @objc func checkFunc() {
        performSegue(withIdentifier: "walletSegue", sender: self)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        numbers = Int(priceLabel.text ?? "") ?? 0
        if numbers != 0 && wallet != nil{
            if select != nil {
            persistanceIncome.category.addToCategory(obj: select!, number: numbers)
                persistanceWallet.category.minusValue(income: numbers, obj: wallet!)
            _ = navigationController?.popToRootViewController(animated: true)
            }
            else {
                persistanceConsumtion.category.addToCategory(obj: consumtion!, number: numbers)
                persistanceWallet.category.plusValue(consumtion: numbers, obj: wallet!)
                _ = navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if wallet != nil {
            walletLabel.textColor = .black
            walletLabel.text = wallet?.name
        }
        else {
            walletLabel.text = "Выберите кошелек"
            walletLabel.textColor = .lightGray
        }
    }
}

extension IncomeViewController: Choose {
    func choosenWallet(obj: Wallet) {
        self.wallet = obj
        self.walletLabel.text = wallet?.name
    }
}
