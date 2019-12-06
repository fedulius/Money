import UIKit
import RealmSwift

class ChartViewController: UIViewController {

    @IBOutlet var mainView: UIView!
        
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
    
    @IBAction func segmentController(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            choosenSeg = segmentedControl.selectedSegmentIndex
            viewForChart.smth = choosenSeg
            viewForChart.setNeedsDisplay()
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
            dateLabel.frame = CGRect(x: 25, y: 600, width: 100, height: 25)
            secondDateLabel.frame = CGRect(x: 110, y: 600, width: 100, height: 25)
            thirdDateLabel.frame = CGRect(x: 180, y: 600, width: 100, height: 25)
            fourthDateLabel.frame = CGRect(x: 250, y: 600, width: 100, height: 25)
            fifthDateLabel.frame = CGRect(x: 320, y: 600, width: 100, height: 25)
            sixthDateLabel.frame = CGRect(x: 390, y: 600, width: 100, height: 25)
            
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
            dateLabel.frame = CGRect(x: 25, y: 600, width: 100, height: 25)
            secondDateLabel.frame = CGRect(x: 130, y: 600, width: 100, height: 25)
            thirdDateLabel.frame = CGRect(x: 215, y: 600, width: 100, height: 25)
            fourthDateLabel.frame = CGRect(x: 305, y: 600, width: 100, height: 25)
            fifthDateLabel.frame = CGRect(x: 390, y: 600, width: 100, height: 25)
            
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
                
                dateLabel.frame = CGRect(x: 40, y: 600, width: 100, height: 25)
                secondDateLabel.frame = CGRect(x: 90, y: 600, width: 200, height: 25)
                thirdDateLabel.frame = CGRect(x: 140, y: 600, width: 200, height: 25)
                fourthDateLabel.frame = CGRect(x: 190, y: 600, width: 200, height: 25)
                fifthDateLabel.frame = CGRect(x: 240, y: 600, width: 200, height: 25)
                sixthDateLabel.frame = CGRect(x: 290, y: 600, width: 200, height: 25)
                seventhDateLabel.frame = CGRect(x: 340, y: 600, width: 200, height: 25)
                eighthDateLabel.frame = CGRect(x: 390, y: 600, width: 200, height: 25)
            
                for (index, i) in [eighthDateLabel, seventhDateLabel, sixthDateLabel, fifthDateLabel, fourthDateLabel, thirdDateLabel, secondDateLabel,dateLabel].enumerated() {
                
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
    
        for (index, i) in [eighthDateLabel, seventhDateLabel, sixthDateLabel, fifthDateLabel, fourthDateLabel, thirdDateLabel,secondDateLabel,dateLabel].enumerated() {
        
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
        viewForChart.setNeedsDisplay()
    }
}
