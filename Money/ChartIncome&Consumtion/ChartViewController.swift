import UIKit
import RealmSwift

class ChartViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var chartView: UIView!
    
    private let dateLabelArray: [UILabel] = []
    
    let date = Date()
    
    let dateLabel = UILabel()
    let secondDateLabel = UILabel()
    let thirdDateLabel = UILabel()
    let fourthDateLabel = UILabel()
    let fifthDateLabel = UILabel()
    let sixthDateLabel = UILabel()
    let seventhDateLabel = UILabel()
    let eighthDateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = Calendar.current
        let format = DateFormatter()
        format.dateFormat = "dd.MM"
        
        dateLabel.frame = CGRect(x: 35, y: 600, width: 100, height: 25)
        secondDateLabel.frame = CGRect(x: 85, y: 600, width: 200, height: 25)
        thirdDateLabel.frame = CGRect(x: 135, y: 600, width: 200, height: 25)
        fourthDateLabel.frame = CGRect(x: 185, y: 600, width: 200, height: 25)
        fifthDateLabel.frame = CGRect(x: 235, y: 600, width: 200, height: 25)
        sixthDateLabel.frame = CGRect(x: 285, y: 600, width: 200, height: 25)
        seventhDateLabel.frame = CGRect(x: 335, y: 600, width: 200, height: 25)
        eighthDateLabel.frame = CGRect(x: 385, y: 600, width: 200, height: 25)
       
        for (index, i) in [eighthDateLabel, seventhDateLabel, sixthDateLabel, fifthDateLabel, fourthDateLabel, thirdDateLabel, secondDateLabel, dateLabel].enumerated() {
            
            var component = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: date)
            component.day! -= index
            let finalDate = calendar.date(from: component)
            
            i.text = format.string(from: finalDate!)
            
            i.font = UIFont.systemFont(ofSize: 10)
            mainView.addSubview(i)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        chartView.setNeedsDisplay()
    }
}
