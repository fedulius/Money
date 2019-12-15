import UIKit
import RealmSwift

class Chart: UIView {
    
    let calendar = Calendar.current
    
    let date = Date()
    
    var smth = 0
    
    let zero = UIView()
    let one = UIView()
    let two = UIView()
    let three = UIView()
    let four = UIView()
    let five = UIView()
    let six = UIView()
    let seven = UIView()
    
    let zeroHor = UIView()
    let oneHor = UIView()
    let twoHor = UIView()
    let threeHor = UIView()
    let fourHor = UIView()
    let fiveHor = UIView()
    let sixHor = UIView()
    let sevenHor = UIView()

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func draw(_ rect: CGRect) {
        if smth == 0 {
            updateBackgroundForWeek()
            drawWeek()
        }
        else if smth == 1 {
            updateBackgroundForMonth()
            drawMonth()
        }
        else if smth == 2 {
            updateBackgroundForQurter()
            drawQarter()
        }
        else if smth == 3 {
            updateBackgroundForWeek()
            drawAllTime()
        }
        else {
            return
        }
    }
    
    func drawAllTime() {
        var arrayForCome: [Int] = []
        var arrayForFillCome: [Int] = []
        
        var arrayForIncome: [Int] = []
        var arrayForFillIncome: [Int] = []
        
        let dateArrayIncome = doIncomeArray(&arrayForIncome)
        let dateArrayForCome = doConsumptionArray(&arrayForCome)
        
        var count = 0
        
        for i in 0..<8 {
            var component = calendar.dateComponents([.year, .month], from: Date())
            component.month! -= i
            for j in 0..<dateArrayIncome.count {
                let arrayComp = calendar.dateComponents([.year, .month], from: dateArrayIncome[j])
                if arrayComp == component {
                    count += arrayForIncome[j]
                }
            }
            arrayForFillIncome.append(count)
            count = 0
        }
        
        for i in 0..<8 {
            var component = calendar.dateComponents([.year, .month], from: Date())
            component.month! -= i
            for j in 0..<dateArrayForCome.count {
                let arrayComp = calendar.dateComponents([.year, .month], from: dateArrayForCome[j])
                if arrayComp == component {
                    count += arrayForCome[j]
                }
            }
            arrayForFillCome.append(count)
            count = 0
        }
        
        var iy = 0
        let height = self.bounds.height
        let width = self.bounds.width
        let step = Int(width) / 7
                
        guard let incMax = arrayForFillIncome.max() else { return }
        guard let consMax = arrayForFillCome.max() else { return }
        
        if incMax > consMax || incMax == consMax && incMax != 0 {
            iy = incMax / Int(height)
        }
        else if consMax > incMax && consMax != 0{
            iy = consMax / Int(height)
        }
        else {
            iy = 1
        }
        
        let zeroInc = CGPoint(x: 0, y: Int(height) - arrayForFillIncome[7] / iy)
        let firstInc = CGPoint(x: step * 1, y: Int(height) - arrayForFillIncome[6] / iy)
        let secondInc = CGPoint(x: step * 2, y: Int(height) - arrayForFillIncome[5] / iy)
        let thirdInc = CGPoint(x: step * 3, y: Int(height) - arrayForFillIncome[4] / iy)
        let fourthInc = CGPoint(x: step * 4, y: Int(height) - arrayForFillIncome[3] / iy)
        let fifthInc = CGPoint(x: step * 5, y: Int(height) - arrayForFillIncome[2] / iy)
        let sixthInc = CGPoint(x: step * 6, y: Int(height) - arrayForFillIncome[1] / iy)
        let seventhInc = CGPoint(x: step * 7, y: Int(height) - arrayForFillIncome[0] / iy)
        
        let chartLineInc = UIBezierPath()
        
        chartLineInc.move(to: zeroInc)
        
        for i in [firstInc, secondInc, thirdInc, fourthInc, fifthInc, sixthInc, seventhInc] {
            
            chartLineInc.addLine(to: i)
        }
        
        let colorInc = UIColor.red
        colorInc.setStroke()
        
        chartLineInc.lineWidth = 2.0
        chartLineInc.stroke()
        
        let zeroCons = CGPoint(x: 0, y: Int(height) - arrayForFillCome[7] / iy)
        let firstCons = CGPoint(x: step * 1, y: Int(height) - arrayForFillCome[6] / iy)
        let secondCons = CGPoint(x: step * 2, y: Int(height) - arrayForFillCome[5] / iy)
        let thirdCons = CGPoint(x: step * 3, y: Int(height) - arrayForFillCome[4] / iy)
        let fourthCons = CGPoint(x: step * 4, y: Int(height) - arrayForFillCome[3] / iy)
        let fifthCons = CGPoint(x: step * 5, y: Int(height) - arrayForFillCome[2] / iy)
        let sixthCons = CGPoint(x: step * 6, y: Int(height) - arrayForFillCome[1] / iy)
        let seventhCons = CGPoint(x: step * 7, y: Int(height) - arrayForFillCome[0] / iy)
        
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
    
    func updateBackgroundForQurter() {
        let width = self.bounds.width
        let height = self.bounds.height
//        vertical
        let vetrticalView = [zero, one, two, three, four]
        let step = Double(width) / Double(vetrticalView.count - 1)
        let lostViews = [five, six, seven]
        for i in 0..<vetrticalView.count {
            let ix = Double(i) * step
            vetrticalView[i].frame = CGRect(x: CGFloat(ix), y: 0, width: 0.5, height: height)
            vetrticalView[i].backgroundColor = .gray
            self.addSubview(vetrticalView[i])
        }
        for l in 0..<lostViews.count {
            lostViews[l].backgroundColor = .white
        }
    }
    
    func drawQarter() {
        var arrayForCome: [Int] = []
        var arrayForFillCome: [Int] = []
        
        var arrayForIncome: [Int] = []
        var arrayForFillIncome: [Int] = []
        
        let incomeDateArray = doIncomeArray(&arrayForIncome)
        let comeDateArray = doConsumptionArray(&arrayForCome)
        
        var variable = 0
        
        for i in 1..<13 {
            var componentCurrently = calendar.dateComponents([.year, .month], from: Date())
            componentCurrently.month = i
            for j in 0..<incomeDateArray.count {
                let componentAllIncome = calendar.dateComponents([.year, .month], from: incomeDateArray[j])
                if componentAllIncome == componentCurrently {
                    variable += arrayForIncome[j]
                }
            }
            if i % 3 == 0 {
                arrayForFillIncome.append(variable)
                variable = 0
            }
        }
        
        for i in 1..<13 {
            var componentCurrently = calendar.dateComponents([.year, .month], from: Date())
            componentCurrently.month = i
            for j in 0..<comeDateArray.count {
                let componentAllCome = calendar.dateComponents([.year, .month], from: comeDateArray[j])
                if componentAllCome == componentCurrently {
                    variable += arrayForCome[j]
                }
            }
            if i % 3 == 0 {
                arrayForFillCome.append(variable)
                variable = 0
            }
        }
        
        var iy = 1
        
        let height = self.bounds.height
        let width = self.bounds.width
        let step = Int(width) / 4
        
        guard let incMax = arrayForFillIncome.max() else { return }
        guard let consMax = arrayForFillCome.max() else { return }
        
        if incMax > consMax || incMax == consMax && incMax != 0 {
            iy = incMax / Int(height)
        }
        else if consMax > incMax && consMax != 0 {
            iy = consMax / Int(height)
        }
        else {
            iy = 1
        }
                
        let zeroInc = CGPoint(x: 0, y: 300)
        let oneInc = CGPoint(x: step * 1, y: Int(height) - arrayForFillIncome[0] / iy)
        let twoInc = CGPoint(x: step * 2, y: Int(height) - arrayForFillIncome[1] / iy)
        let threeInc = CGPoint(x: step * 3, y: Int(height) - arrayForFillIncome[2] / iy)
        let fourInc = CGPoint(x: step * 4, y: Int(height) - arrayForFillIncome[3] / iy)
        
        let chartLineInc = UIBezierPath()
        chartLineInc.move(to: zeroInc)
        
        for i in [oneInc, twoInc, threeInc, fourInc] {
            chartLineInc.addLine(to: i)
        }
        let color = UIColor.red
        color.setStroke()
        
        chartLineInc.lineWidth = 2.0
        chartLineInc.stroke()
        
        let zeroCome = CGPoint(x: 0, y: 300)
        let oneCome = CGPoint(x: step * 1, y: Int(height) - arrayForFillCome[0] / iy)
        let twoCome = CGPoint(x: step * 2, y: Int(height) - arrayForFillCome[1] / iy)
        let threeCome = CGPoint(x: step * 3, y: Int(height) - arrayForFillCome[2] / iy)
        let fourCome = CGPoint(x: step * 4, y: Int(height) - arrayForFillCome[3] / iy)
        
        let chartLineCome = UIBezierPath()
        chartLineCome.move(to: zeroCome)
        
        for i in [oneCome, twoCome, threeCome, fourCome] {
            chartLineCome.addLine(to: i)
        }
        let colorCome = UIColor.blue
        colorCome.setStroke()
        
        chartLineCome.lineWidth = 2.0
        chartLineCome.stroke()
    }
    
    
    func updateBackgroundForMonth() {
        let width = self.bounds.width
        let height = self.bounds.height
        //vertical
        let verticalView = [zero, one, two, three, four, five]
        six.backgroundColor = .white
        seven.backgroundColor = .white
        let stepVert = Int(width) / (verticalView.count - 1)
        for i in 0..<verticalView.count {
            let ix = i * stepVert
            verticalView[i].frame = CGRect(x: CGFloat(ix), y: 0, width: 0.5, height: height)
            verticalView[i].backgroundColor = .gray
            self.addSubview(verticalView[i])
        }
        
        //horizontal
        let horizontalView = [zeroHor, oneHor, twoHor, threeHor, fourHor, fiveHor]
        let stepHor = Int(height) / (horizontalView.count - 1)
        for i in 0..<horizontalView.count {
            let iy = i * stepHor
            horizontalView[i].frame = CGRect(x: 0, y: CGFloat(iy), width: width, height: 0.5)
            horizontalView[i].backgroundColor = .gray
            self.addSubview(horizontalView[i])
        }
    }
    
    func drawMonth() {
        //здесь начинается какая то хрень с датами в которую лучше не вникать
        var count = 0
                
        var firstComponentsDate = calendar.dateComponents([.year, .month, .day, .weekOfMonth], from: date)
        firstComponentsDate.day = 1
        let firstDate = calendar.date(from: firstComponentsDate)
                
        var lastComponentDate = calendar.dateComponents([.year, .month, .day, .weekOfMonth], from: date)
        lastComponentDate.day = 1
        lastComponentDate.month? += 1
        count = lastComponentDate.day!
        let lastDate = calendar.date(from: lastComponentDate)
        
        let daysInMonth = Int((lastDate?.timeIntervalSince(firstDate!))! / 60 / 60 / 24)
        
        var counter = calendar.dateComponents([.year, .month, .weekOfMonth], from: date)
        counter.day = daysInMonth
        let dateForKnew = calendar.date(from: counter)
        let check = calendar.dateComponents([.year, .month, .day, .weekOfMonth], from: dateForKnew!)
        count = check.weekOfMonth!
        //здесь она заканчивается
        
        var arrayForIncome: [Int] = []
        var arrayForFillIncome: [Int] = []
        
        var arrayForCome: [Int] = []
        var arrayForFillCome: [Int] = []
        
        let incomeDateArray = doIncomeArray(&arrayForIncome)
        let comeDateArray = doConsumptionArray(&arrayForCome)
        
        var iy = 0
        
        let height = self.bounds.height
        let width = self.bounds.width
        let step = Int(width) / 5
                        
        for i in 0..<count {
            var variable = 0
            var component = calendar.dateComponents([.year, .month, .weekOfMonth], from: firstDate!)
            component.weekOfMonth! += i
            for j in 0..<incomeDateArray.count {
                let checlDate = calendar.dateComponents([.year, .month, .weekOfMonth], from: incomeDateArray[j])
                if checlDate == component {
                    variable += arrayForIncome[j]
                }
            }
            arrayForFillIncome.append(variable)
        }
        
        for i in 0..<count {
            var variable = 0
            var component = calendar.dateComponents([.year, .month, .weekOfMonth], from: firstDate!)
            component.weekOfMonth! += i
            for j in 0..<comeDateArray.count {
                let checlDate = calendar.dateComponents([.year, .month, .weekOfMonth], from: comeDateArray[j])
                if checlDate == component {
                    variable += arrayForCome[j]
                }
            }
            arrayForFillCome.append(variable)
        }
        
        guard let incMax = arrayForFillIncome.max() else { return }
        guard let consMax = arrayForFillCome.max() else { return }
        
        if incMax > consMax || incMax == consMax && incMax != 0 {
            iy = incMax / Int(height)
        }
        else if consMax > incMax && consMax != 0 {
            iy = consMax / Int(height)
        }
        else {
            iy = 1
        }
        
        let zeroInc = CGPoint(x: 0, y: 300)
        let oneInc = CGPoint(x: step * 1, y: Int(height) - arrayForFillIncome[0] / iy)
        let twoInc = CGPoint(x: step * 2, y: Int(height) - arrayForFillIncome[1] / iy)
        let threeInc = CGPoint(x: step * 3, y: Int(height) - arrayForFillIncome[2] / iy)
        let fourInc = CGPoint(x: step * 4, y: Int(height) - arrayForFillIncome[3] / iy)
        let fiveInc = CGPoint(x: step * 5, y: Int(height) - arrayForFillIncome[4] / iy)
        
        let chartLineInc = UIBezierPath()
        chartLineInc.move(to: zeroInc)
        
        for i in [oneInc, twoInc, threeInc, fourInc, fiveInc] {
            chartLineInc.addLine(to: i)
        }
        let color = UIColor.red
        color.setStroke()
        
        chartLineInc.lineWidth = 2.0
        chartLineInc.stroke()
        
        let zeroCome = CGPoint(x: 0, y: 300)
        let oneCome = CGPoint(x: step * 1, y: Int(height) - arrayForFillCome[0] / iy)
        let twoCome = CGPoint(x: step * 2, y: Int(height) - arrayForFillCome[1] / iy)
        let threeCome = CGPoint(x: step * 3, y: Int(height) - arrayForFillCome[2] / iy)
        let fourCome = CGPoint(x: step * 4, y: Int(height) - arrayForFillCome[3] / iy)
        let fiveCome = CGPoint(x: step * 5, y: Int(height) - arrayForFillCome[4] / iy)
        
        let chartLineCome = UIBezierPath()
        chartLineCome.move(to: zeroCome)
        
        for i in [oneCome, twoCome, threeCome, fourCome, fiveCome] {
            chartLineCome.addLine(to: i)
        }
        let colorCome = UIColor.blue
        colorCome.setStroke()
        
        chartLineCome.lineWidth = 2.0
        chartLineCome.stroke()
    }
    
    
        
    func drawWeek() {
        var arrayForIncome: [Int] = []
        var arrayForFillIncome: [Int] = []
        
        var arrayForCome: [Int] = []
        var arrayForFillCome: [Int] = []
        
        let incomeDateArray = doIncomeArray(&arrayForIncome)
        let dateArray = doConsumptionArray(&arrayForCome)
        var iy = 0
        
        let height = self.bounds.height
        
        let width = self.bounds.width
        
        let step = Int(width) / 7
                
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
        
        guard let incMax = arrayForFillIncome.max() else { return }
        guard let consMax = arrayForFillCome.max() else { return }
        
       if incMax > consMax || incMax == consMax && incMax != 0 {
            iy = incMax / Int(height)
        }
        else if consMax > incMax && consMax != 0 {
            iy = consMax / Int(height)
        }
        else {
            iy = 1
        }
        
        let zeroInc = CGPoint(x: 0, y: Int(height) - arrayForFillIncome[7] / iy)
        let firstInc = CGPoint(x: step * 1, y: Int(height) - arrayForFillIncome[6] / iy)
        let secondInc = CGPoint(x: step * 2, y: Int(height) - arrayForFillIncome[5] / iy)
        let thirdInc = CGPoint(x: step * 3, y: Int(height) - arrayForFillIncome[4] / iy)
        let fourthInc = CGPoint(x: step * 4, y: Int(height) - arrayForFillIncome[3] / iy)
        let fifthInc = CGPoint(x: step * 5, y: Int(height) - arrayForFillIncome[2] / iy)
        let sixthInc = CGPoint(x: step * 6, y: Int(height) - arrayForFillIncome[1] / iy)
        let seventhInc = CGPoint(x: step * 7, y: Int(height) - arrayForFillIncome[0] / iy)
        
        let chartLineInc = UIBezierPath()
        
        chartLineInc.move(to: zeroInc)
        
        for i in [firstInc, secondInc, thirdInc, fourthInc, fifthInc, sixthInc, seventhInc] {
            chartLineInc.addLine(to: i)
        }
        
        let colorInc = UIColor.red
        colorInc.setStroke()
        
        chartLineInc.lineWidth = 2.0
        chartLineInc.stroke()
        
        
        
        let zeroCons = CGPoint(x: 0, y: Int(height) - arrayForFillCome[7] / iy)
        let firstCons = CGPoint(x: step * 1, y: Int(height) - arrayForFillCome[6] / iy)
        let secondCons = CGPoint(x: step * 2, y: Int(height) - arrayForFillCome[5] / iy)
        let thirdCons = CGPoint(x: step * 3, y: Int(height) - arrayForFillCome[4] / iy)
        let fourthCons = CGPoint(x: step * 4, y: Int(height) - arrayForFillCome[3] / iy)
        let fifthCons = CGPoint(x: step * 5, y: Int(height) - arrayForFillCome[2] / iy)
        let sixthCons = CGPoint(x: step * 6, y: Int(height) - arrayForFillCome[1] / iy)
        let seventhCons = CGPoint(x: step * 7, y: Int(height) - arrayForFillCome[0] / iy)
        
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
            let dateComponent = calendar.dateComponents([.year, .month, .day, .weekOfMonth], from: currentDate)
            let dateFromComponent = calendar.date(from: dateComponent)
            if i > 0 {
                let yesterday = consumtion[i - 1].date
                let yesterdayComponent = calendar.dateComponents([.year, .month, .day, .weekOfMonth], from: yesterday)
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
            let dateComponent = calendar.dateComponents([.year, .month, .day, .weekOfMonth], from: currentDate)
            let dateFromComponent = calendar.date(from: dateComponent)
            if i > 0 {
                let yesterday = income[i - 1].date
                let yesterdayComponent = calendar.dateComponents([.year, .month, .day, .weekOfMonth], from: yesterday)
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
    
    func updateBackgroundForWeek() {
        let width = self.bounds.width
        let height = self.bounds.height
        // vertical
        let viewsArray: [UIView] = [zero, one, two, three, four, five, six, seven]
        let stepVert = Int(width) / (viewsArray.count - 1)
        for i in 0..<viewsArray.count {
            let j = i * stepVert
            viewsArray[i].frame = CGRect(x: CGFloat(j), y: 0, width: 0.5, height: height)
            viewsArray[i].backgroundColor = .gray
            addSubview(viewsArray[i])
        }
        
        //horizontal
        let viewsHorizontalArray: [UIView] = [zeroHor, oneHor, twoHor, threeHor, fourHor, fiveHor, sixHor]
        let stepHor = Int(height) / (viewsHorizontalArray.count - 1)
        for i in 0..<viewsHorizontalArray.count {
            let j = i * stepHor
            viewsHorizontalArray[i].frame = CGRect(x: 0, y: CGFloat(j), width: width, height: 0.5)
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
