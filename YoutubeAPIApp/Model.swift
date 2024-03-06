import UIKit

class Model: NSObject {
    var title: String
    var name: String
    var image: UIImage
    var videoId: String
    
    init(title: String, name: String, image: UIImage, videoId: String) {
        self.title = title as String
        self.name = name as String
        self.image = image
        self.videoId = videoId as String
    }
}
