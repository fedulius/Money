import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var dataLabel: UILabel!
        
    var realmsClass: Results<CategoryIncome>!
    var consumtionRealmClass: Results<CategoryConsumtion>!
    var all: Results<AllCategorys>!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd.MM|EEEE"
        dataLabel.text = format.string(from: date)
        
        let realm = persistanceIncome.category.realm
        realmsClass = realm.objects(CategoryIncome.self)
        
        let consumtionRealm = persistanceConsumtion.category.realm
        consumtionRealmClass = consumtionRealm.objects(CategoryConsumtion.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainTableView.reloadData()
    }
    
    @IBAction func addCostsButton(_ sender: Any) {
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return realmsClass.count + consumtionRealmClass.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = section
        if section < realmsClass.count {
            return realmsClass[section].check.count
        }
        else {
            count = section - realmsClass.count
            return consumtionRealmClass[count].money.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var count = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellsForCosts") as! MainTableViewCell
        if indexPath.section < realmsClass.count{
            cell.priceOfCost.text = realmsClass[indexPath.section].categorysName
            cell.costImage.image = UIImage(named: realmsClass[indexPath.section].categorysImage ?? "")
            cell.moneyLabel.text = "\(realmsClass[indexPath.section].check[indexPath.row].suma)"
            cell.moneyLabel.backgroundColor = .yellow
        }
        else {
            count = indexPath.section - realmsClass.count
            cell.priceOfCost.text = consumtionRealmClass[count].consumtionName
            cell.costImage.image = UIImage(named: consumtionRealmClass[count].consumtionImage ?? "")
            cell.moneyLabel.text = "\(consumtionRealmClass[count].money[indexPath.row].sumaConsumtion)"
            cell.moneyLabel.backgroundColor = .red
        }
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var count = indexPath.section
        if editingStyle == .delete{
            if count < realmsClass.count {
                let ob = realmsClass[indexPath.section]
                persistanceIncome.category.deleteValue(check: ob.check[indexPath.row])
                mainTableView.reloadData()
            }
            else {
                count = indexPath.section - realmsClass.count
                let ob = consumtionRealmClass[count]
                persistanceConsumtion.category.deleteValue(check: ob.money[indexPath.row])
                mainTableView.reloadData()
            }
        }
    }
}
