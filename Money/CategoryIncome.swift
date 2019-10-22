import Foundation
import RealmSwift


class SumaIncome: Object {
    @objc dynamic var suma: Int = 0
    @objc dynamic var date: Date = Date()
}

class CategoryIncome: Object {
    @objc dynamic var categorysName: String?
    @objc dynamic var categorysImage: String?
    var check = List<SumaIncome>()
}

class CategoryConsumtion: Object {
    @objc dynamic var consumtionName: String?
    @objc dynamic var consumtionImage: String?
    var money = List<SumaConsumtion>()
}

class SumaConsumtion: Object {
    @objc dynamic var sumaConsumtion: Int = 0
    @objc dynamic var date: Date = Date()
}

class AllCategorys: Object {
    var income = List<CategoryIncome>()
    var consumtion = List<CategoryConsumtion>()
}

class Wallet: Object {
    @objc dynamic var money: Int = 0
    @objc dynamic var name: String?
}

class persistanceWallet: MainViewController {
    static let category = persistanceWallet()
    let realm = try! Realm()
    
    func plusValue(consumtion: Int, obj: Wallet) {
        try! realm.write {
            obj.money += consumtion
        }
    }
    
    func minusValue(income: Int, obj: Wallet) {
        try! realm.write {
            obj.money -= income
        }
    }
    
    func addValueToWallet(name: String) {
        let variable = Wallet()
        variable.name = name
        try! realm.write {
            realm.add(variable)
        }
    }
    
    func deleteWallet(obj: Wallet) {
        try! realm.write {
            realm.delete(obj)
        }
    }
}

class persistanceConsumtion: MainViewController {
    
    static let category = persistanceConsumtion()
    
    let realm = try! Realm()
    
    func addValue(name: String, image: String) {
        let check = CategoryConsumtion()
        check.consumtionName = name
        check.consumtionImage = image
        try! realm.write {
            realm.add(check)
        }
    }
    
    func addToCategory(obj: CategoryConsumtion, number: Int) {
        let cat = obj
        let suma = SumaConsumtion()
        try! realm.write {
            suma.sumaConsumtion = suma.sumaConsumtion + number
            cat.money.append(suma)
        }
    }
    
    func deleteValue(check: Object) {
        try! realm.write {
            realm.delete(check)
        }
    }
}

class persistanceIncome: MainViewController {
    
    static let category = persistanceIncome()
    
    let realm = try! Realm()
    
    func addValue(name: String, image: String) {
        let check = CategoryIncome()
        check.categorysName = name
        check.categorysImage = image
        try! realm.write {
            realm.add(check)
        }
    }
    
    func addToCategory(obj: CategoryIncome, number: Int) {
        let cat = obj
        let suma = SumaIncome()
        try! realm.write {
            suma.suma = suma.suma + number
            cat.check.append(suma)
        }
    }
    
    func deleteValue(check: Object) {
        try! realm.write {
            realm.delete(check)
        }
    }
    
}
