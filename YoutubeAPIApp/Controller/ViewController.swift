import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    //②URLを変更した際に起きるエラーの解消
    var keyword = ""
    //private let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=poke&key="
    private let apiKey = "AIzaSyCbT5qzUv_r4ixM-HBVr0TKl3cJScZ6Vmo"
    //ストアドプロパティだと参照できない
    //private let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=date&q=\(keyword)&type=video&key="
    //コンピューティッドプロパティだと参照できる ※iOSアカデミアの動画講義復習
    private var url: String {
        return "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=date&q=\(keyword)&type=video&key="
    }
    
    private var videoID: String = ""
    private var videoArray: [String] = []
    private var videos = [Model]()
    //var videoList: [Model] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        //response.JSONは今後使えなくなる
        AF.request("\(url)\(apiKey)").responseData { response in
            // 通信結果のJSON (ここまでがAlamofire)
            if let jsonObject = response.data {
                //print("JSON: \(json)")
                //print(response)
                let json = JSON(jsonObject)
                let Items = json["items"]
                var videoDatas: [Model] = []
                
                for (_, subJson): (String, JSON) in Items {
                    print("投稿日時: \(subJson["snippet"]["publishedAt"])")
                    print("ビデオID: \(subJson["id"]["videoId"])")
                    
                    let imageUrl: String = subJson["snippet"]["thumbnails"]["medium"]["url"].string!
                    let image: UIImage? = UIImage(data: NSData(contentsOf: NSURL(string: imageUrl)! as URL)! as Data)
                    
                    self.videoID = "https://www.youtube.com/watch?v=" + subJson["id"]["videoId"].string!
                    print("URLです: \(self.videoID)")
                    self.videoArray.append(self.videoID)
                    print("URLの配列: \(self.videoArray)")
                    
                    let video: Model = Model.init(title: subJson["snippet"]["title"].string!, name: subJson["snippet"]["channelTitle"].string!, image: image!, videoId: self.videoID)
                    videoDatas.append(video)
                    print("ビデオです: \(video)")
                    print("ビデオデータです: \(videoDatas)")
                }
                
                self.videos = videoDatas
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            cell.setCell(videos[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //選択したセルのURLを参照できるようにしたい
        let cell = tableView.cellForRow(at: indexPath)
        let url = NSURL(string: videoArray[indexPath.row])
        print(url ?? "")
        
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
}

//MVVMのお勉強をする
