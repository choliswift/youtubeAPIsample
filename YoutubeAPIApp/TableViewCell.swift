import UIKit
import Alamofire
import SwiftyJSON

class TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var thumbnailImage: UIImageView!
    @IBOutlet private weak var titleTextField: UILabel!
    @IBOutlet private weak var channelNAmeTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(_ video: Model) {
        self.titleTextField.text = video.title as String
        self.channelNAmeTextField.text = video.name as String
        self.thumbnailImage.image = video.image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
