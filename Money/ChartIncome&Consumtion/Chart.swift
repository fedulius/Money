import UIKit
import RealmSwift

class Chart: UIView {
    
    let calendar = Calendar.current
    let date = Date()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBackground()
    }
    
    override func draw(_ rect: CGRect) {
        drawWeek()
    }
    
    func drawWeek(){
        var arrayForIncome: [Int] = []
        var arrayForFillIncome: [Int] = []
        
        var arrayForCome: [Int] = []
        var arrayForFillCome: [Int] = []
        
        let incomeDateArray = doIncomeArray(&arrayForIncome)
        let dateArray = doConsumptionArray(&arrayForCome)
        var iy = 0
        
        let height = self.bounds.height
                
        guard let incMax = arrayForIncome.max() else { return }
        guard let consMax = arrayForCome.max() else { return }
        
        if incMax > consMax {
            iy = incMax / Int(height)
        }
        else if consMax > incMax {
            iy = consMax / Int(height)
        }
        else {
            iy = incMax / Int(height)
        }
        
        var secondCount = 0
        
        for i in 0..<8 {
            var component = calendar.dateComponents([.year, .month, .day], from: date)
            component.day! -= i
            let checkDate = calendar.date(from: component)
            for j in 0..<incomeDateArray.count {
                if incomeDateArray[j] == checkDate {
                    arrayForFillIncome.append(arrayForIncome[j])
                }
            }
            secondCount += 1
            if secondCount > arrayForFillIncome.count {
                arrayForFillIncome.append(0)
            }
        }
        
        let zeroInc = CGPoint(x: 0, y: Int(height) - arrayForFillIncome[7] / iy)
        let firstInc = CGPoint(x: 50, y: Int(height) - arrayForFillIncome[6] / iy)
        let secondInc = CGPoint(x: 100, y: Int(height) - arrayForFillIncome[5] / iy)
        let thirdInc = CGPoint(x: 150, y: Int(height) - arrayForFillIncome[4] / iy)
        let fourthInc = CGPoint(x: 200, y: Int(height) - arrayForFillIncome[3] / iy)
        let fifthInc = CGPoint(x: 250, y: Int(height) - arrayForFillIncome[2] / iy)
        let sixthInc = CGPoint(x: 300, y: Int(height) - arrayForFillIncome[1] / iy)
        let seventhInc = CGPoint(x: 350, y: Int(height) - arrayForFillIncome[0] / iy)
        
        let chartLineInc = UIBezierPath()
        
        chartLineInc.move(to: zeroInc)
        
        for i in [firstInc, secondInc, thirdInc, fourthInc, fifthInc, sixthInc, seventhInc] {
            
            chartLineInc.addLine(to: i)
        }
        
        let colorInc = UIColor.red
        colorInc.setStroke()
        
        chartLineInc.lineWidth = 2.0
        chartLineInc.stroke()
//        let format = DateFormatter()
        var count = 0
        
        for i in 0..<8 {
            var component = calendar.dateComponents([.year, .month, .day], from: date)
            component.day! -= i
            let checkDate = calendar.date(from: component)
            for j in 0..<dateArray.count {
                if dateArray[j] == checkDate {
                    arrayForFillCome.append(arrayForCome[j])
                }
            }
            count += 1
            if count > arrayForFillCome.count {
                arrayForFillCome.append(0)
            }
        }
        
        let zeroCons = CGPoint(x: 0, y: Int(height) - arrayForFillCome[7] / iy)
        let firstCons = CGPoint(x: 50, y: Int(height) - arrayForFillCome[6] / iy)
        let secondCons = CGPoint(x: 100, y: Int(height) - arrayForFillCome[5] / iy)
        let thirdCons = CGPoint(x: 150, y: Int(height) - arrayForFillCome[4] / iy)
        let fourthCons = CGPoint(x: 200, y: Int(height) - arrayForFillCome[3] / iy)
        let fifthCons = CGPoint(x: 250, y: Int(height) - arrayForFillCome[2] / iy)
        let sixthCons = CGPoint(x: 300, y: Int(height) - arrayForFillCome[1] / iy)
        let seventhCons = CGPoint(x: 350, y: Int(height) - arrayForFillCome[0] / iy)
        
        let chartLineCons = UIBezierPath()
        
        chartLineCons.move(to: zeroCons)
        
        for i in [firstCons, secondCons, thirdCons, fourthCons, fifthCons, sixthCons, seventhCons] {
            chartLineCons.addLine(to: i)
        }
        
        let colorCons = UIColor.blue
        colorCons.setStroke()
        
        chartLineCons.lineWidth = 2.0
        chartLineCons.stroke()
    }
    
    func doConsumptionArray(_ arrayForCome: inout [Int]) -> [Date] {
        let consumtion = getConsumtion()
        var come = 0
        var arrayForComeDate: [Date] = []

        for i in 0..<consumtion.count {
            let currentDate = consumtion[i].date
            let dateComponent = calendar.dateComponents([.year, .month, .day], from: currentDate)
            let dateFromComponent = calendar.date(from: dateComponent)
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
                    arrayForComeDate.append(dateFromComponent!)
                }
                else {
                    arrayForCome.append(come)
                    arrayForComeDate.append(yesterdayAsDate!)
                    come = consumtion[i].sumaConsumtion
                    if i == consumtion.count - 1 {
                        arrayForCome.append(come)
                        arrayForComeDate.append(dateFromComponent!)
                    }
                }
            }
            else if consumtion.count == 1 {
                come += consumtion[0].sumaConsumtion
                arrayForCome.append(come)
                arrayForComeDate.append(dateFromComponent!)
            }
            else {
                come += consumtion[0].sumaConsumtion
            }
        }
        return arrayForComeDate
    }
    
    func doIncomeArray(_ arrayForSuma: inout [Int]) -> [Date] {
        let income = getIncome()
        var variable = 0
        var arrayForIncomeDate: [Date] = []
        
        for i in 0..<income.count {
            let currentDate = income[i].date
            let dateComponent = calendar.dateComponents([.year, .month, .day], from: currentDate)
            let dateFromComponent = calendar.date(from: dateComponent)
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
                    arrayForIncomeDate.append(dateFromComponent!)
                }
                else {
                    arrayForSuma.append(variable)
                    arrayForIncomeDate.append(yesterdayAsDate!)
                    variable = income[i].suma
                    if i == income.count - 1 {
                        arrayForSuma.append(variable)
                        arrayForIncomeDate.append(dateFromComponent!)
                    }
                }
            }
            else if income.count == 1 {
                variable += income[0].suma
                arrayForSuma.append(variable)
                arrayForIncomeDate.append(dateFromComponent!)
            }
            else {
                variable += income[0].suma
            }
        }
        return arrayForIncomeDate
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
