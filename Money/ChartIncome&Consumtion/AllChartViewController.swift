import UIKit
import Charts
import RealmSwift

class AllChartViewController: UIViewController {

    @IBOutlet weak var pieView: BarChartView!
    @IBOutlet weak var timeSegmentController: UISegmentedControl!
    
     weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormatDelegate = self
        pieView.isUserInteractionEnabled = false
//        pieView.accessibilityScroll(.right)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        axisFormatDelegate = self
    }
    
    @IBAction func changeSegment() {
        switch timeSegmentController.selectedSegmentIndex {
        case 0:
            updateChartData()
        case 1:
            print("Month")
        case 2:
            print("Hello world")
        case 3:
            print("Star Wars")
        default:
            break
        }
    }
    
    func updateChartData() {
        var dataEnries: [BarChartDataEntry] = []
        var secDataEntrie: [BarChartDataEntry] = []
        let costCount = getCostCaunt()
        let calendar = Calendar.current
        var check = 0
        let time: TimeInterval = costCount[0].date.timeIntervalSince1970
        for i in 0..<costCount.count {
            let date = costCount[i].date
            let dateComp = calendar.dateComponents([.year, .month, .day], from: date)
            let dateNowComp = calendar.date(from: dateComp)
            let timeInterval = dateNowComp!.timeIntervalSince1970
            let xValue = (timeInterval - time) / (3600 * 24)
            if i > 0 {
                let date2 = costCount[i - 1].date
                let dateComp2 = calendar.dateComponents([.year, .month, .day], from: date2)
                let dateNowComp2 = calendar.date(from: dateComp2)
                if dateNowComp == dateNowComp2 {
                    check += costCount[i].suma
                    if i < costCount.count - 1 {
                        let tomorrow = costCount[i + 1].date
                        let tomorrowComp = calendar.dateComponents([.year, .month, .day], from: tomorrow)
                        let dateTomrrow = calendar.date(from: tomorrowComp)
                        if dateNowComp != dateTomrrow {
                            let dataEntry = BarChartDataEntry(x: Double(xValue), y: Double(check))
                            dataEnries.append(dataEntry)
                        }
                    }
                    else {
                        let dataEntry = BarChartDataEntry(x: Double(xValue), y: Double(check))
                        dataEnries.append(dataEntry)
                    }
                }
                else {
                    check = 0
                    check += costCount[i].suma
                }
            }
            else {
                check += costCount[i].suma
            }
        }

        let chartDataSet = BarChartDataSet(entries: dataEnries, label: "Расход")
        let secChartDataSet = BarChartDataSet(entries: secDataEntrie, label: "Доход")
        let chartData = BarChartData(dataSet: chartDataSet)
        let colors = [UIColor.yellow]
        chartDataSet.colors = colors
//        chartDataSet.colors = ChartColorTemplates.colorful()
        
        let xaxis = pieView.xAxis
        xaxis.spaceMin = 1
        xaxis.spaceMax = 2
        xaxis.valueFormatter = axisFormatDelegate
//        xaxis.drawLimitLinesBehindDataEnabled = true
        xaxis.granularityEnabled = true
        xaxis.granularity = 1.0
        xaxis.labelPosition = .bottom
        xaxis.setLabelCount(7, force: true)
        
        pieView.data = chartData
    }
    
    func getCostCaunt() -> Results<SumaIncome> {
        let realm = try! Realm()
        return realm.objects(SumaIncome.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    func getConsumtionCount() -> Results<CategoryConsumtion> {
        let realm = try! Realm()
        return realm.objects(CategoryConsumtion.self)
    }
}

extension AllChartViewController: IAxisValueFormatter {
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let dateFormatter = DateFormatter()
    let costCaunt = getCostCaunt()
    let refTime: TimeInterval = costCaunt[0].date.timeIntervalSince1970
    dateFormatter.dateFormat = "dd.MM"
    let date = Date(timeIntervalSince1970: value * 3600 * 24 + refTime)
    return dateFormatter.string(from: date)
  }
}
