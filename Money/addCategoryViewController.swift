import UIKit

class addCategoryViewController: UIViewController {
    
    @IBOutlet weak var imageCat: UIImageView!

    @IBOutlet weak var catNameTextField: UITextField!
    
    var check: CategoryIncome?
    var consumtion: CategoryConsumtion?
    var proper = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCat.image = UIImage(named: "dollarBagMoney")
    }

    @IBAction func saveToCategoryButton(_ sender: Any) {
        if catNameTextField.text?.isEmpty != true {
            if proper == 0 {
                let name = catNameTextField.text
                persistanceIncome.category.addValue(name: name!, image: "dollarBagMoney")
                _ = navigationController?.popViewController(animated: true)
            }
            else {
                let name = catNameTextField.text
                persistanceConsumtion.category.addValue(name: name!, image: "dollarBagMoney")
                _ = navigationController?.popViewController(animated: true)
            }
        }
    }
}
