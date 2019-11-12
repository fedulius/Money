import UIKit
import Charts
import RealmSwift

class AllChartViewController: UIViewController {

    @IBOutlet weak var pieView: BarChartView!
    @IBOutlet weak var timeSegmentController: UISegmentedControl!
    var arrayOfPrice: [Int] = []
    var arrayOfDate: [Double] = []
    
    var arrayOfConsumtionPrice: [Int] = []
    var arrayOfConsumtionDate: [Double] = []
    
     weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormatDelegate = self
        pieView.isUserInteractionEnabled = true
        pieView.doubleTapToZoomEnabled = false
        pieView.accessibilityScroll(.right)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        axisFormatDelegate = self
        updateChartData()
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
        let consumtionCount = getConsumtionCount()
        let calendar = Calendar.current
        var check = 0
        var variable = 0
        
        let time = costCount[0].date
        let timeComp = calendar.dateComponents([.year, .month, .day], from: time)
        let timeCompNow = calendar.date(from: timeComp)
        let firstTimeInterval = timeCompNow!.timeIntervalSince1970
        
        let secTime = consumtionCount[0].date
        let secTimeComp = calendar.dateComponents([.year, .month, .day], from: secTime)
        let secTimeCompNow = calendar.date(from: secTimeComp)
        let secondTimeInterval = secTimeCompNow!.timeIntervalSince1970
        
        for i in 0..<costCount.count {
            let date = costCount[i].date
            let dateComp = calendar.dateComponents([.year, .month, .day], from: date)
            let dateNowComp = calendar.date(from: dateComp)
            let timeInterval = dateNowComp!.timeIntervalSince1970
            let xValue = (timeInterval - firstTimeInterval) / (3600 * 24)
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
                            arrayOfDate.append(xValue)
                            arrayOfPrice.append(check)
                        }
                    }
                    else {
                        arrayOfDate.append(xValue)
                        arrayOfPrice.append(check)
                    }
                }
                else if dateNowComp != dateNowComp2 && i == costCount.count - 1 {
                    check = 0
                    check += costCount[i].suma
                    arrayOfDate.append(xValue)
                    arrayOfPrice.append(check)
                }
                else {
                    check = 0
                    check += costCount[i].suma
                    if i < costCount.count - 1 {
                        let tomorrow = costCount[i + 1].date
                        let tomorrowComp = calendar.dateComponents([.year, .month, .day], from: tomorrow)
                        let dateTomrrow = calendar.date(from: tomorrowComp)
                        if dateNowComp != dateTomrrow {
                            arrayOfDate.append(xValue)
                            arrayOfPrice.append(check)
                        }
                    }
                }
            }
            else if costCount.count == 1 {
                check = costCount[0].suma
                arrayOfDate.append(xValue)
                arrayOfPrice.append(check)
            }
            else {
                check += costCount[i].suma
            }
        }
        
        for i in 0..<consumtionCount.count {
            let date = consumtionCount[i].date
            let dateComp = calendar.dateComponents([.year, .month, .day], from: date)
            let dateNowComp = calendar.date(from: dateComp)
            let timeInterval = dateNowComp!.timeIntervalSince1970
            let xValue = (timeInterval - secondTimeInterval) / (3600 * 24)
            if i > 0 {
                let date2 = consumtionCount[i - 1].date
                let dateComp2 = calendar.dateComponents([.year, .month, .day], from: date2)
                let dateNowComp2 = calendar.date(from: dateComp2)
                let check = dateNowComp2?.timeIntervalSince1970
                if dateNowComp == dateNowComp2 {
                    variable += consumtionCount[i].sumaConsumtion
                    if i < consumtionCount.count - 1 {
                        let tomorrow = consumtionCount[i + 1].date
                        let tomorrowComp = calendar.dateComponents([.year, .month, .day], from: tomorrow)
                        let dateTomrrow = calendar.date(from: tomorrowComp)
                        if dateNowComp != dateTomrrow {
                            arrayOfConsumtionDate.append(xValue)
                            arrayOfConsumtionPrice.append(variable)
                        }
                    }
                    else {
                        arrayOfConsumtionDate.append(xValue)
                        arrayOfConsumtionPrice.append(variable)
                    }
                }
                else if dateNowComp != dateNowComp2 && i == consumtionCount.count - 1 {
                    arrayOfConsumtionPrice.append(variable)
                    arrayOfConsumtionDate.append(check!)
                    variable = 0
                    variable += consumtionCount[i].sumaConsumtion
                    arrayOfConsumtionDate.append(xValue)
                    arrayOfConsumtionPrice.append(variable)
                }
                else {
                    arrayOfConsumtionPrice.append(variable)
                    arrayOfConsumtionDate.append(check!)
                    variable = 0
                    variable += consumtionCount[i].sumaConsumtion
                    if i < consumtionCount.count - 1 {
                        let tomorrow = consumtionCount[i + 1].date
                        let tomorrowComp = calendar.dateComponents([.year, .month, .day], from: tomorrow)
                        let dateTomrrow = calendar.date(from: tomorrowComp)
                        if dateNowComp != dateTomrrow {
                            arrayOfConsumtionDate.append(xValue)
                            arrayOfConsumtionPrice.append(variable)
                        }
                    }
                }
            }
            else if consumtionCount.count == 1 {
                variable = consumtionCount[0].sumaConsumtion
                arrayOfConsumtionDate.append(xValue)
                arrayOfConsumtionPrice.append(variable)
            }
            else {
                variable += consumtionCount[i].sumaConsumtion
            }
        }
    
        for i in 0..<arrayOfPrice.count {
            let dataEntry = BarChartDataEntry(x: arrayOfDate[i], y: Double(arrayOfPrice[i]))
            dataEnries.append(dataEntry)
        }
        
        for i in 0..<arrayOfConsumtionPrice.count {
            let dataConsEntry = BarChartDataEntry(x: arrayOfConsumtionDate[i], y: Double(arrayOfConsumtionPrice[i]))
            secDataEntrie.append(dataConsEntry)
            print(arrayOfConsumtionPrice.count)
        }
        
        let xaxis = pieView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.granularityEnabled = true
        xaxis.enabled = true
        xaxis.setLabelCount(7, force: false)

        let chartDataSet = BarChartDataSet(entries: dataEnries, label: "Расход")
        let secChartDataSet = BarChartDataSet(entries: secDataEntrie, label: "Доход")
        let arraySets: [BarChartDataSet] = [chartDataSet, secChartDataSet]
        let chartData = BarChartData(dataSets: arraySets)
        let colors = [UIColor.yellow]
        chartDataSet.colors = colors
        
        let groupSpace = 0.1
        let barSpace = 0.003
        let barWidth = 0.4
        
        xaxis.axisMinimum = 0.0
        xaxis.axisMaximum = 0.0 + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(arrayOfDate.count)
        
        chartData.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        
        xaxis.granularity = xaxis.axisMaximum / Double(arrayOfDate.count)
        
        chartData.barWidth = barWidth
        
        pieView.data = chartData
        
        pieView.notifyDataSetChanged()
        pieView.animate(yAxisDuration: 1.0, easingOption: .linear)
        
        arrayOfPrice.removeAll()
        arrayOfDate.removeAll()
        arrayOfConsumtionDate.removeAll()
        arrayOfConsumtionPrice.removeAll()
    }
    
    func getCostCaunt() -> Results<SumaIncome> {
        let realm = try! Realm()
        return realm.objects(SumaIncome.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    func getConsumtionCount() -> Results<SumaConsumtion> {
        let realm = try! Realm()
        return realm.objects(SumaConsumtion.self).sorted(byKeyPath: "date", ascending: true)
    }
}

extension AllChartViewController: IAxisValueFormatter {
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let dateFormatter = DateFormatter()
    let costCaunt = getCostCaunt()
    let calendar = Calendar.current
    let time = costCaunt[0].date
    let timeComp = calendar.dateComponents([.year, .month, .day], from: time)
    let timeCompNow = calendar.date(from: timeComp)
    let refTime = timeCompNow?.timeIntervalSince1970
    dateFormatter.dateFormat = "dd.MM"
    let date = Date(timeIntervalSince1970: value * 3600 * 24 + refTime!)
    return dateFormatter.string(from: date)
  }
}
