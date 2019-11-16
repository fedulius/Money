import UIKit
import RealmSwift

class Chart: UIView {
        
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBackground()
    }
    
    override func draw(_ rect: CGRect) {
        doIncomeLineChart()
    }
    
    func doIncomeLineChart(){
        let income = getIncome()
        let calendar = Calendar.current
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
        
        guard let max = arrayForSuma.max() else { return }
        
        let iy = max / Int(self.bounds.height)
        
        let center = CGPoint(x: 0, y: self.bounds.height)
        let second = CGPoint(x: 50, y: 300 - arrayForSuma[0] / iy)
        let third = CGPoint(x: 100, y: 300 - arrayForSuma[1] / iy)
        let fourth = CGPoint(x: 150, y: 300 - arrayForSuma[2] / iy)
        let fifth = CGPoint(x: 200, y: 300 - arrayForSuma[3] / iy)
        let sixth = CGPoint(x: 250, y: 300 - arrayForSuma[4] / iy)
        let seventh = CGPoint(x: 300, y: 200)
        
        let chartLine = UIBezierPath()
        
        chartLine.move(to: center)
        
        for i in [second, third, fourth, fifth, sixth, seventh] {
            chartLine.addLine(to: i)
        }        
        let color = UIColor.red
        color.setStroke()
        
        chartLine.lineWidth = 2
        chartLine.stroke()
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
}
