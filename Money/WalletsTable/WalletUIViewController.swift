import UIKit
import RealmSwift

class WalletUIViewController: UIViewController {
    
    @IBOutlet weak var walletTableView: UITableView!
    var wallet: Results<Wallet>!
    
    var delegativ: Choose?
    var vc = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = persistanceWallet.category.realm
        wallet = realm.objects(Wallet.self)
        
        walletTableView.dataSource = self
        walletTableView.delegate = self
    }

}

extension WalletUIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "walletCell") as! WalletsTableViewCell
        walletCell.walletNameLabel.text = wallet[indexPath.row].name
        walletCell.numberWalletLabel.text = "\(wallet[indexPath.row].money)"
        return walletCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = wallet[indexPath.row]
        self.delegativ?.choosenWallet(obj: obj)
        _ = navigationController?.popViewController(animated: true)
    }
}
