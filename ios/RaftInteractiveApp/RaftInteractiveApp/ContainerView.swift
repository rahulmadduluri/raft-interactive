import UIKit
import AVKit

class ContainerView: UIView {
    
    var vc: ViewController?
    var cellReuseIdentifier: String?
    var player: AVQueuePlayer?
    
    fileprivate var itemsTable: UITableView?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupBaseVideo()
                
        // Options Table
        itemsTable?.removeFromSuperview()
        itemsTable = UITableView(frame: CGRect(x: self.bounds.minX, y: self.bounds.maxY - 200, width: self.bounds.width, height: 200))
        itemsTable?.delegate = self
        itemsTable?.dataSource = vc
        itemsTable?.separatorStyle = .none
        itemsTable?.register(OptionsTableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier ?? "")
        self.addSubview(itemsTable!)
    }
    
    func setupBaseVideo() {
        guard let path = Bundle.main.path(forResource: Constants.baseVideo, ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        let url : URL? = URL(fileURLWithPath: path)
        if url != nil {
            let playerItem = AVPlayerItem.init(url: url!)
            player = AVQueuePlayer(items: [playerItem])
            player?.actionAtItemEnd = .pause
        }
        
        guard let player = player else { return }

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height-200)
        self.layer.addSublayer(playerLayer)
    }
    
    func playVideo(vidString: String) {
        player?.pause()
        player?.removeAllItems()
        
        guard let path = Bundle.main.path(forResource: vidString, ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let url : URL? = URL(fileURLWithPath: path)
        if url != nil {
            let playerItem = AVPlayerItem.init(url: url!)
            
            self.player?.insert(playerItem, after: nil)
        }
        
        player?.play()
    }

    
}

extension ContainerView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.itemCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


private struct Constants {
    static let itemCellHeight: CGFloat = 50
    
    static let baseVideo = "vid_base"
}
