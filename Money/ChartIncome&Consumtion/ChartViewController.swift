import UIKit
import RealmSwift

class ChartViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var chartView: UIView!
    
    private let dateLabelArray: [UILabel] = []
    
    let dateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        dateLabel.frame = CGRect(x: 43, y: 600, width: 200, height: 25)
        dateLabel.text = "0"
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        mainView.addSubview(dateLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        chartView.setNeedsDisplay()
    }
    
}
