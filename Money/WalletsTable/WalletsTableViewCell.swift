import UIKit

class WalletsTableViewCell: UITableViewCell {

    @IBOutlet weak var walletNameLabel: UILabel!
    @IBOutlet weak var numberWalletLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
