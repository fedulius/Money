import UIKit

class PlusOrMinus: NSObject {
    
    var delegate: Updates?
    
    var variable = 0
    let darkView = UIView()
    let height: CGFloat = 200
    let cellId = "MyCell"
    let array = ["Расход", "Доход", "Перевод средств"]
        
    let collectionView: UICollectionView = {
        let rect = CGRect(x: 0, y: 0, width: 20, height: 20)
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.isScrollEnabled = false
        return cv
    }()
        
    func out() -> Int {
        return variable
    }
    
    func menuOut() {
        if let window = UIApplication.shared.keyWindow {
            
            darkView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(darkView)
            window.addSubview(collectionView)
            
            let height: CGFloat = 165
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            darkView.frame = window.frame
            darkView.alpha = 0
            
            UIView.animate(withDuration: 0.35) {
                self.darkView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.35) {
            self.darkView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CellSettingsId.self, forCellWithReuseIdentifier: cellId)
    }
}

extension PlusOrMinus: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CellSettingsId
        cellID.nameLabel.text = array[indexPath.row]
        return cellID
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        variable = indexPath.row
        self.delegate!.didUpdate(sender: self, check: indexPath.row)
        UIView.animate(withDuration: 0.35) {
            self.darkView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
             }
         }
    }
}

