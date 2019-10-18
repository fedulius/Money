import UIKit
import Charts
import RealmSwift

class AllChartViewController: UIViewController {

    @IBOutlet weak var pieView: BarChartView!
    
     weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieView.isUserInteractionEnabled = false
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
        var timeIntervalHell: TimeInterval?
        for i in 0..<costCount.count {
            var check = 0
            for j in 0..<costCount[i].check.count {
                timeIntervalHell = costCount[i].check[j].date.timeIntervalSince1970
                print(costCount[i].check[j].date)
                check += costCount[i].check[j].suma
            }
            let dataEntry = BarChartDataEntry(x: Double(timeIntervalHell!), y: Double(check))
            dataEnries.append(dataEntry)
            
        }
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
        
        let xaxis = pieView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
    }
    
    func getCostCaunt() -> Results<CategoryIncome> {
        let realm = try! Realm()
        return realm.objects(CategoryIncome.self)
    }
    
    func getConsumtionCount() -> Results<CategoryConsumtion> {
        let realm = try! Realm()
        return realm.objects(CategoryConsumtion.self)
    }
    
}

extension AllChartViewController: IAxisValueFormatter {
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM"
    return dateFormatter.string(from: Date(timeIntervalSince1970: value))
  }
}
