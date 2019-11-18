import UIKit
import RealmSwift

class Chart: UIView {
    
    let calendar = Calendar.current
        
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBackground()
    }
    
    override func draw(_ rect: CGRect) {
        drawWeek()
    }
    
    func drawWeek() {
        let income = doIncomeArray()
        let consumtion = doConsumptionArray()
        var iy = 0
        
        let height = self.bounds.height
                
        guard let incMax = income.max() else { return }
        guard let consMax = consumtion.max() else { return }
        
        if incMax > consMax {
            iy = incMax / Int(height)
        }
        else if consMax > incMax {
            iy = consMax / Int(height)
        }
        else {
            iy = incMax / Int(height)
        }
        
        let center = CGPoint(x: 0, y: height)
        
        let firstInc = CGPoint(x: 50, y: 300 - income[0] / iy)
        let secondInc = CGPoint(x: 100, y: 300 - income[1] / iy)
        let thirdInc = CGPoint(x: 150, y: 300 - income[2] / iy)
        let fourthInc = CGPoint(x: 200, y: 300 - income[3] / iy)
        let fifthInc = CGPoint(x: 250, y: 300 - income[4] / iy)
        let sixthInc = CGPoint(x: 300, y: 300)
        
        let chartLineInc = UIBezierPath()
        
        chartLineInc.move(to: center)
        
        for i in [firstInc, secondInc, thirdInc, fourthInc, fifthInc, sixthInc] {
            chartLineInc.addLine(to: i)
        }
        
        let colorInc = UIColor.red
        colorInc.setStroke()
        
        chartLineInc.lineWidth = 2.0
        chartLineInc.stroke()
        
        let firstCons = CGPoint(x: 50, y: 300 - consumtion[0] / iy)
        let secondCons = CGPoint(x: 100, y: 300 - consumtion[1] / iy)
        let thirdCons = CGPoint(x: 150, y: 300 - consumtion[2] / iy)
        let fourthCons = CGPoint(x: 200, y: 300 - consumtion[3] / iy)
        let fifthCons = CGPoint(x: 250, y: 300 - consumtion[4] / iy)
        let sixthCons = CGPoint(x: 300, y: 300)
        
        let chartLineCons = UIBezierPath()
        
        chartLineCons.move(to: center)
        
        for i in [firstCons, secondCons, thirdCons, fourthCons, fifthCons, sixthCons] {
            chartLineCons.addLine(to: i)
        }
        
        let colorCons = UIColor.blue
        colorCons.setStroke()
        
        chartLineCons.lineWidth = 2.0
        chartLineCons.stroke()
    }
    
    func doConsumptionArray() -> [Int]{
        let consumtion = getConsumtion()
        var come = 0
        var arrayForCome: [Int] = []
        
        let time = consumtion[0].date
        let timeComponent = calendar.dateComponents([.year, .month, .day], from: time)
        let getDateFromComponent = calendar.date(from: timeComponent)
        let timeInterval = getDateFromComponent!.timeIntervalSince1970
        
        for i in 0..<consumtion.count {
            let currentDate = consumtion[i].date
            let dateComponent = calendar.dateComponents([.year, .month, .day], from: currentDate)
            let dateFromComponent = calendar.date(from: dateComponent)
            let dateInterval = dateFromComponent!.timeIntervalSince1970
            if i > 0 {
                let yesterday = consumtion[i - 1].date
                let yesterdayComponent = calendar.dateComponents([.year, .month, .day], from: yesterday)
                let yesterdayAsDate = calendar.date(from: yesterdayComponent)
                if dateFromComponent == yesterdayAsDate && i < consumtion.count - 1 {
                    come += consumtion[i].sumaConsumtion
                }
                else if i == consumtion.count - 1 && dateFromComponent == yesterdayAsDate {
                    come += consumtion[i].sumaConsumtion
                    arrayForCome.append(come)
                }
                else {
                    arrayForCome.append(come)
                    come = consumtion[i].sumaConsumtion
                    if i == consumtion.count - 1 {
                        arrayForCome.append(come)
                    }
                }
            }
            else if consumtion.count == 1 {
                come += consumtion[0].sumaConsumtion
                arrayForCome.append(come)
            }
            else {
                come += consumtion[0].sumaConsumtion
            }
        }
        return arrayForCome
    }
    
    func doIncomeArray() -> [Int]{
        let income = getIncome()
        var variable = 0
        var arrayForSuma: [Int] = []
        
        let time = income[0].date
        let timeComponent = calendar.dateComponents([.year, .month, .day], from: time)
        let getDateFromComponent = calendar.date(from: timeComponent)
        let timeInterval = getDateFromComponent!.timeIntervalSince1970
        
        for i in 0..<income.count {
            let currentDate = income[i].date
            let dateComponent = calendar.dateComponents([.year, .month, .day], from: currentDate)
            let dateFromComponent = calendar.date(from: dateComponent)
            let dateInterval = dateFromComponent!.timeIntervalSince1970
//            let xValue = (dateInterval - timeInterval) / (3600 * 24)
            if i > 0 {
                let yesterday = income[i - 1].date
                let yesterdayComponent = calendar.dateComponents([.year, .month, .day], from: yesterday)
                let yesterdayAsDate = calendar.date(from: yesterdayComponent)
                if dateFromComponent == yesterdayAsDate && i < income.count - 1 {
                    variable += income[i].suma
                }
                else if i == income.count - 1 && dateFromComponent == yesterdayAsDate {
                    variable += income[i].suma
                    arrayForSuma.append(variable)
                }
                else {
                    arrayForSuma.append(variable)
                    variable = income[i].suma
                    if i == income.count - 1 {
                        arrayForSuma.append(variable)
                    }
                }
            }
            else if income.count == 1 {
                variable += income[0].suma
                arrayForSuma.append(variable)
            }
            else {
                variable += income[0].suma
            }
        }
        return arrayForSuma
    }
    
    func updateBackground() {
        // vertical
        let zero = UIView()
        let one = UIView()
        let two = UIView()
        let three = UIView()
        let four = UIView()
        let five = UIView()
        let six = UIView()
        let seven = UIView()
        
        let viewsArray: [UIView] = [zero, one, two, three, four, five, six, seven]
        for i in 0..<viewsArray.count {
            let j = i * 50
            viewsArray[i].frame = CGRect(x: CGFloat(j), y: 0, width: 0.5, height: self.bounds.height)
            viewsArray[i].backgroundColor = .gray
            addSubview(viewsArray[i])
        }
        
        //horizontal
        let zeroHor = UIView()
        let oneHor = UIView()
        let twoHor = UIView()
        let threeHor = UIView()
        let fourHor = UIView()
        let fiveHor = UIView()
        let sixHor = UIView()
        
        let viewsHorizontalArray: [UIView] = [zeroHor, oneHor, twoHor, threeHor, fourHor, fiveHor, sixHor]
        for i in 0..<viewsHorizontalArray.count {
            let j = i * 50
            viewsHorizontalArray[i].frame = CGRect(x: 0, y: CGFloat(j), width: self.bounds.width, height: 0.5)
            viewsHorizontalArray[i].backgroundColor = .gray
            addSubview(viewsHorizontalArray[i])
        }
    }
    
    func getIncome() -> Results<SumaIncome> {
        let realm = try! Realm()
        return realm.objects(SumaIncome.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    func getConsumtion() -> Results<SumaConsumtion> {
        let realm = try! Realm()
        return realm.objects(SumaConsumtion.self).sorted(byKeyPath: "date", ascending: true)
    }
}
