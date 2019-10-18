import UIKit

class WalletTableViewCell: UITableViewCell {

    @IBOutlet weak var walletImageView: UIImageView!
    @IBOutlet weak var walletNameLabel: UILabel!
    @IBOutlet weak var walletMoneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
