import UIKit
import youtube_ios_player_helper

final class YTPlayerViewController: UIViewController {

    @IBOutlet private weak var playerView: YTPlayerView!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        self.playerView.load(withVideoId: "k68P66WYnc0", playerVars: ["playsinline" : 1])
        searchTextField.placeholder = "入力してください"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
            if let nextViewController = segue.destination as? ViewController {
                nextViewController.keyword = searchTextField.text ?? ""
            }
        }
    }
    
    //MARK: IBaction
    @IBAction func tapPlay(_ sender: Any) {
        self.playerView.playVideo()
    }
    @IBAction func tapPause(_ sender: Any) {
        self.playerView.pauseVideo()
    }
    @IBAction func tapStop(_ sender: Any) {
        self.playerView.stopVideo()
    }
    @IBAction func subButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Sub", bundle: nil)
        let subView = storyboard.instantiateViewController(identifier: "SubViewController") as! SubViewController
        self.present(subView, animated: true, completion: nil)
    }
    
}

extension YTPlayerViewController: YTPlayerViewDelegate {
    func playerView(_ playerView: YTPlayerView!, didChangeTo state: YTPlayerState) {
        switch (state) {
        case .unstarted:
            stateLabel.text = "停止中"
        case .playing:
            stateLabel.text = "再生中"
        case .ended:
            stateLabel.text = "終了"
        case .paused:
            stateLabel.text = "一時停止"
        case .buffering:
            stateLabel.text = "読み込み中"
        case .queued:
            stateLabel.text = "わからん"
        case .unknown:
            stateLabel.text = "不明"
        @unknown default:
            break
        }
    }
}
