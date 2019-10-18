import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var costImage: UIImageView!
    @IBOutlet weak var priceOfCost: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
