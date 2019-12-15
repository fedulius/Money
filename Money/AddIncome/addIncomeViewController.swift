import UIKit
import RealmSwift

protocol Updates {
    func didUpdate(sender: PlusOrMinus, check: Int)
}

class addIncomeViewController: UIViewController {

    @IBOutlet weak var otherButtonOutlet: UIButton!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var otherButton: UIButton!
    
    let plusOrMinus = PlusOrMinus()
    
    var edit: Bool = false
    var check = 0
    
    var clase: Results<CategoryIncome>!
    var consumtion: Results<CategoryConsumtion>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otherButton.setTitleColor(.black, for: .normal)
        colView.delegate = self
        let realm = persistanceIncome.category.realm
        clase = realm.objects(CategoryIncome.self)
        
        let consuptionRealm = persistanceConsumtion.category.realm
        consumtion = consuptionRealm.objects(CategoryConsumtion.self)
        
        otherButtonOutlet.setTitle("Расход⇩", for: .normal)

        plusOrMinus.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if check == 2 {
            check = 0
        }
        colView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVC" && check == 0 {
            if let vc = segue.destination as? IncomeViewController{
                let select = sender as? CategoryIncome
                vc.select = select
            }
        }
        else if segue.identifier == "showVC" && check == 1 {
            if let vc = segue.destination as? IncomeViewController {
                let select = sender as? CategoryConsumtion
                vc.consumtion = select
            }
        }
        else if segue.identifier == "addCategory" {
            if let vc = segue.destination as? addCategoryViewController {
                let select = sender as? Int
                vc.proper = select ?? 0
            }
        }
    }
    
    func alert(select: Object) {
        let alert = UIAlertController(title: "Вы хотите удалить категорию?", message: "", preferredStyle: .alert)
        
        let deleteCategory = UIAlertAction(title: "Удалить", style: .default) { (action) in
            if self.check == 0 {
                persistanceIncome.category.deleteValue(check: select)
            }
            else {
                persistanceConsumtion.category.deleteValue(check: select)
            }
            self.colView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteCategory)
        
        present(alert, animated: true, completion: nil)
    }
        
    @IBAction func otherButton(_ sender: Any) {
        plusOrMinus.menuOut()
    }
}

extension addIncomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if check == 0 {
            if edit == true{
                return clase.count + 1
            }
            return clase.count
        }
        else {
            if edit == true{
                return consumtion.count + 1
            }
            return consumtion.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colCel = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! addIncomeCollectionViewCell
        if check == 0 {
            otherButtonOutlet.setTitle("Расход⇩", for: .normal)
            if indexPath.item < clase.count {
                if edit == false {
                        colCel.label.text = clase[indexPath.row].categorysName ?? ""
                        colCel.incomeImage.image = UIImage(named: clase[indexPath.row].categorysImage ?? "")
                        colCel.xLabel.isHidden = true
                        return colCel
                }
                else {
                    colCel.label.text = clase[indexPath.row].categorysName ?? ""
                    colCel.incomeImage.image = UIImage(named: clase[indexPath.row].categorysImage ?? "")
                    colCel.xLabel.isHidden = false
                    return colCel
                }
            }
            else {
                colCel.incomeImage.image = UIImage(named: "addButton")
                colCel.label.text = ""
                colCel.xLabel.isHidden = true
                return colCel
            }
        }
        else if check == 1 {
            otherButtonOutlet.setTitle("Доход⇩", for: .normal)
            if indexPath.item < consumtion.count {
                if edit == false {
                    colCel.label.text = consumtion[indexPath.row].consumtionName ?? ""
                    colCel.incomeImage.image = UIImage(named: consumtion[indexPath.row].consumtionImage ?? "")
                    colCel.xLabel.isHidden = true
                    return colCel
                }
                else {
                    colCel.label.text = consumtion[indexPath.row].consumtionName ?? ""
                    colCel.incomeImage.image = UIImage(named: consumtion[indexPath.row].consumtionImage ?? "")
                    colCel.xLabel.isHidden = false
                    return colCel
                }
            }
            else {
            colCel.incomeImage.image = UIImage(named: "addButton")
            colCel.label.text = ""
            colCel.xLabel.isHidden = true
            return colCel
            }
        }
        else {
            performSegue(withIdentifier: "swapVC", sender: Any?.self)
            return colCel
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if check == 0 {
            if indexPath.row < clase.count {
                let select = clase[indexPath.row]
                if edit == false {
                    performSegue(withIdentifier: "showVC", sender: select)
                }
                else {
                    alert(select: select)
                }
            }
            else {
                performSegue(withIdentifier: "addCategory", sender: check)
                edit = false
            }
        }
        else if check == 1 {
            if indexPath.row < consumtion.count {
                let select = consumtion[indexPath.row]
                if edit == false {
                    performSegue(withIdentifier: "showVC", sender: select)
                }
                else {
                    alert(select: select)
                }
            }
            else {
                performSegue(withIdentifier: "addCategory", sender: check)
                edit = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        let w = headerView.frame.size.width
        let h = headerView.frame.size.height
        
        let button = UIButton(frame: CGRect(x: w - (w / 5) - 10, y: h / 4, width: w / 5, height: h / 2))
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonPress(sender:)), for: .touchUpInside)
        headerView.addSubview(button)
        return headerView
    }
    
    @objc func buttonPress(sender: UIButton) {
        edit = !edit
        colView.reloadData()
    }
}

extension addIncomeViewController: Updates {
    func didUpdate(sender: PlusOrMinus, check: Int) {
        self.check = check
        self.colView.reloadData()
    }
}
