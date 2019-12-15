import UIKit
import RealmSwift

class ChartViewController: UIViewController {

    @IBOutlet var mainView: UIView!
        
    @IBOutlet weak var rightConst: NSLayoutConstraint!
    
    var choosenSeg = 0
    
    var chart = Chart()
    
    @IBOutlet weak var viewForChart: Chart!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
            
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
        viewForChart.setNeedsUpdateConstraints()
        
        let calendar = Calendar.current
        let format = DateFormatter()
        format.dateFormat = "dd.MM"
        
        let width = mainView.bounds.width - rightConst.constant - 20
        let height = Int(mainView.bounds.height / 2 + 152)
        let step = Int(width) / 7
        let begin = 55

        dateLabel.frame = CGRect(x: begin, y: height, width: 100, height: 25)
        secondDateLabel.frame = CGRect(x: begin + (step * 1), y: height, width: 200, height: 25)
        thirdDateLabel.frame = CGRect(x: begin + (step * 2), y: height, width: 200, height: 25)
        fourthDateLabel.frame = CGRect(x: begin + (step * 3), y: height, width: 200, height: 25)
        fifthDateLabel.frame = CGRect(x: begin + (step * 4), y: height, width: 200, height: 25)
        sixthDateLabel.frame = CGRect(x: begin + (step * 5), y: height, width: 200, height: 25)
        seventhDateLabel.frame = CGRect(x: begin + (step * 6), y: height, width: 200, height: 25)
        eighthDateLabel.frame = CGRect(x: begin + (step * 7), y: height, width: 200, height: 25)

        for (index, i) in [eighthDateLabel, seventhDateLabel, sixthDateLabel, fifthDateLabel, fourthDateLabel, thirdDateLabel,secondDateLabel,dateLabel].enumerated() {

            var component = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: date)
            component.day! -= index
            let finalDate = calendar.date(from: component)

            i.text = format.string(from: finalDate!)

            i.font = UIFont.systemFont(ofSize: 10)
            mainView.addSubview(i)
        }
    }
    
    @IBAction func segmentController(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            choosenSeg = segmentedControl.selectedSegmentIndex
            viewForChart.smth = choosenSeg
            viewForChart.setNeedsDisplay()
            
            let calendar = Calendar.current
            let format = DateFormatter()
            format.dateFormat = "dd.MM"
            
            let width = mainView.bounds.width - rightConst.constant - 20
            let height = Int(mainView.bounds.height / 2 + 152)
            let step = Int(width) / 7
            let begin = 55

            dateLabel.frame = CGRect(x: begin, y: height, width: 100, height: 25)
            secondDateLabel.frame = CGRect(x: begin + (step * 1), y: height, width: 200, height: 25)
            thirdDateLabel.frame = CGRect(x: begin + (step * 2), y: height, width: 200, height: 25)
            fourthDateLabel.frame = CGRect(x: begin + (step * 3), y: height, width: 200, height: 25)
            fifthDateLabel.frame = CGRect(x: begin + (step * 4), y: height, width: 200, height: 25)
            sixthDateLabel.frame = CGRect(x: begin + (step * 5), y: height, width: 200, height: 25)
            seventhDateLabel.frame = CGRect(x: begin + (step * 6), y: height, width: 200, height: 25)
            eighthDateLabel.frame = CGRect(x: begin + (step * 7), y: height, width: 200, height: 25)
        
            for (index, i) in [eighthDateLabel, seventhDateLabel, sixthDateLabel, fifthDateLabel, fourthDateLabel, thirdDateLabel, secondDateLabel,dateLabel].enumerated() {
            
                var component = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: date)
                component.day! -= index
                let finalDate = calendar.date(from: component)
                
                i.text = format.string(from: finalDate!)
                
                i.font = UIFont.systemFont(ofSize: 10)
                mainView.addSubview(i)
            }
        case 1:
            choosenSeg = segmentedControl.selectedSegmentIndex
            viewForChart.smth = choosenSeg
            viewForChart.setNeedsDisplay()
            
            let width = viewForChart.bounds.width
            let height = Int(mainView.bounds.height / 2 + 152)
            let step = Int(width) / 5
            let begin = 65
            
            dateLabel.frame = CGRect(x: 50, y: height, width: 200, height: 25)
            secondDateLabel.frame = CGRect(x: begin + (step * 1), y: height, width: 200, height: 25)
            thirdDateLabel.frame = CGRect(x: begin + (step * 2), y: height, width: 200, height: 25)
            fourthDateLabel.frame = CGRect(x: begin + (step * 3), y: height, width: 200, height: 25)
            fifthDateLabel.frame = CGRect(x: begin + (step * 4), y: height, width: 200, height: 25)
            sixthDateLabel.frame = CGRect(x: begin + (step * 5), y: height, width: 200, height: 25)
            
            sixthDateLabel.text = "5"
            fifthDateLabel.text = "4"
            fourthDateLabel.text = "3"
            thirdDateLabel.text = "2"
            secondDateLabel.text = "1"
            dateLabel.text = "Неделя"
            
            for i in [sixthDateLabel, fifthDateLabel ,fourthDateLabel, thirdDateLabel, secondDateLabel, dateLabel] {
                mainView.addSubview(i)
            }
            
            for i in [seventhDateLabel, eighthDateLabel] {
                i.text = ""
            }
            
            
        case 2:
            choosenSeg = segmentedControl.selectedSegmentIndex
            viewForChart.smth = choosenSeg
            viewForChart.setNeedsDisplay()
            
            let width = viewForChart.bounds.width
            let height = Int(mainView.bounds.height / 2 + 152)
            let step = Int(width) / 4
            let begin = 67
            
            dateLabel.frame = CGRect(x: 50, y: height, width: 100, height: 25)
            secondDateLabel.frame = CGRect(x: begin + (step * 1), y: height, width: 100, height: 25)
            thirdDateLabel.frame = CGRect(x: begin + (step * 2), y: height, width: 100, height: 25)
            fourthDateLabel.frame = CGRect(x: begin + (step * 3), y: height, width: 100, height: 25)
            fifthDateLabel.frame = CGRect(x: begin + (step * 4), y: height, width: 100, height: 25)
            
            fifthDateLabel.text = "4"
            fourthDateLabel.text = "3"
            thirdDateLabel.text = "2"
            secondDateLabel.text = "1"
            dateLabel.text = "Квартал"
            
            for i in [sixthDateLabel, seventhDateLabel, eighthDateLabel] {
                i.text = ""
            }
        case 3:
            choosenSeg = segmentedControl.selectedSegmentIndex
            viewForChart.smth = choosenSeg
            viewForChart.setNeedsDisplay()
            let calendar = Calendar.current
            let format = DateFormatter()
            format.dateFormat = "MM"
            
            let width = mainView.bounds.width - rightConst.constant - 20
            let height = Int(mainView.bounds.height / 2 + 152)
            let step = Int(width) / 7
            let begin = 63
            
            dateLabel.frame = CGRect(x: begin, y: height, width: 100, height: 25)
            secondDateLabel.frame = CGRect(x: begin + (step * 1), y: height, width: 200, height: 25)
            thirdDateLabel.frame = CGRect(x: begin + (step * 2), y: height, width: 200, height: 25)
            fourthDateLabel.frame = CGRect(x: begin + (step * 3), y: height, width: 200, height: 25)
            fifthDateLabel.frame = CGRect(x: begin + (step * 4), y: height, width: 200, height: 25)
            sixthDateLabel.frame = CGRect(x: begin + (step * 5), y: height, width: 200, height: 25)
            seventhDateLabel.frame = CGRect(x: begin + (step * 6), y: height, width: 200, height: 25)
            eighthDateLabel.frame = CGRect(x: begin + (step * 7), y: height, width: 200, height: 25)
            
            for (index, i) in [eighthDateLabel, seventhDateLabel, sixthDateLabel, fifthDateLabel, fourthDateLabel, thirdDateLabel,secondDateLabel,dateLabel].enumerated() {
            
                var component = calendar.dateComponents([.year, .month], from: date)
                component.month! -= index
                let finalDate = calendar.date(from: component)
                
                i.text = format.string(from: finalDate!)
                
                i.font = UIFont.systemFont(ofSize: 10)
                mainView.addSubview(i)
            }
       default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewForChart.setNeedsDisplay()
    }
}
