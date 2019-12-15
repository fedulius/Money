import UIKit
import RealmSwift

class BalanceViewController: UIViewController {
    
    @IBOutlet weak var walletTable: UITableView!
    
    var wallet: Results<Wallet>!

    override func viewDidLoad() {
        super.viewDidLoad()
        walletTable.dataSource = self
        walletTable.delegate = self
        
        let walletRealm = persistanceWallet.category.realm
        wallet = walletRealm.objects(Wallet.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        walletTable.reloadData()
    }
    
    @IBAction func addWalletButton(_ sender: Any) {
        let walletAlert = UIAlertController(title: "Add wallet", message: "Enter name for new wallet", preferredStyle: .alert)
        walletAlert.addTextField { (textField: UITextField!) in
            textField.placeholder = "Введите имя кошелька"
        }
        
        walletAlert.addTextField { (secondField: UITextField!) in
            secondField.placeholder = "Баланс"
        }
        
        let actionAddWallet = UIAlertAction(title: "Save", style: .default) { (action) in
            if let textF = walletAlert.textFields?[0] {
                let temp = textF.text
                if temp != nil && temp != "" {
                    if let secF = walletAlert.textFields?[1] {
                        var mny = 0
                        mny = Int(secF.text ?? "") ?? 0
                        persistanceWallet.category.addValueToWallet(name: temp!, mny: mny)
                        self.walletTable.reloadData()
                    }
                }
                else {
                    if let secF = walletAlert.textFields?[1] {
                        var mny = 0
                        mny = Int(secF.text ?? "") ?? 0
                        persistanceWallet.category.addValueToWallet(name: "New Wallet", mny: mny)
                        self.walletTable.reloadData()
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        walletAlert.addAction(cancelAction)
        walletAlert.addAction(actionAddWallet)
        present(walletAlert, animated: true, completion: nil)
    }
}

extension BalanceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell") as! WalletTableViewCell
        cell.walletNameLabel.text = wallet[indexPath.row].name
        cell.walletMoneyLabel.text = "\(wallet[indexPath.row].money)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let obj = wallet[indexPath.row]
            persistanceWallet.category.deleteWallet(obj: obj)
            walletTable.reloadData()
        }
    }
}
