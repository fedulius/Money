import UIKit
import Charts
import RealmSwift

class AllChartViewController: UIViewController {

    @IBOutlet weak var pieView: BarChartView!
    
     weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieView.isUserInteractionEnabled = false
//        pieView.accessibilityScroll(.right)
        updateChartData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        axisFormatDelegate = self
        updateChartData()
    }
    
    func updateChartData() {
        var dataEnries: [BarChartDataEntry] = []
        var secDataEntrie: [BarChartDataEntry] = []
        let costCount = getCostCaunt()
        var timeIntervalFirst: TimeInterval?
        var timeIntervalSecond: TimeInterval?
        var check = 0
        for i in 0..<costCount.count {
            timeIntervalFirst = costCount[0].date.timeIntervalSince1970
            check = costCount[i].suma
            let dataEntry = BarChartDataEntry(x: Double(timeIntervalFirst!), y: Double(check))
            dataEnries.append(dataEntry)
        }
//            let dataEntry = BarChartDataEntry(x: Double(timeIntervalHell!), y: Double(check))
//            dataEnries.append(dataEntry)
//        let consCount = getConsumtionCount()
//        for o in 0..<consCount.count {
//            var consumtion = 0
//            for p in 0..<consCount[o].money.count {
//                consumtion += consCount[o].money[p].sumaConsumtion
//            }
//            let secDataEntry = BarChartDataEntry(x: Double(timeIntervalHell!), y: Double(consumtion))
//            secDataEntrie.append(secDataEntry)
//        }
        let chartDataSet = BarChartDataSet(entries: dataEnries, label: "Расход")
//        let secChartDataSet = BarChartDataSet(entries: secDataEntrie, label: "Доход")
        let chartData = BarChartData(dataSet: chartDataSet)
//        let colors = [UIColor.yellow]
//        chartDataSet.colors = colors
        
        pieView.data = chartData
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        let xaxis = pieView.xAxis
        xaxis.spaceMin = 10.0
        xaxis.spaceMax = 5
        xaxis.xOffset = 4.0
        xaxis.valueFormatter = axisFormatDelegate
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
    dateFormatter.dateFormat = "dd.MM.yy"
    return dateFormatter.string(from: Date(timeIntervalSince1970: value))
  }
}
