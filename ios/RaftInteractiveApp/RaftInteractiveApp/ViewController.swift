//
//  ViewController.swift
//  RaftInteractiveApp
//
//  Created by Rahul Madduluri on 2/10/19.
//  Copyright © 2019 Raft. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

class ViewController: UIViewController {
    
    fileprivate var containerView: ContainerView?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        containerView?.player?.play()
    }
    
    override func loadView() {
        containerView = ContainerView(frame: UIScreen.main.bounds)
        containerView?.vc = self
        containerView?.cellReuseIdentifier = Constants.cellReuseIdentifier
        self.view = containerView
    }
    
    func playVideo(index: Int) {
        var vidString = ""
        switch index {
        case 0:
            vidString = Constants.orgasmVideo
        case 1:
            vidString = Constants.spicyVideo
        case 2:
            vidString = Constants.mehVideo
        default:
            vidString = Constants.disgustVideo
        }
        
        containerView?.playVideo(vidString: vidString)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! OptionsTableViewCell
        
        cell.vc = self
        cell.index = indexPath.row
        cell.checkbox?.borderStyle = .circle
        cell.checkbox?.checkmarkStyle = .circle
        
        switch indexPath.row {
        case 0:
            cell.itemLabel?.text = "Orgasm"
        case 1:
            cell.itemLabel?.text = "Spicy"
        case 2:
            cell.itemLabel?.text = "Meh"
        default:
            cell.itemLabel?.text = "Disgust"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
}

fileprivate struct Constants {
    static let cellReuseIdentifier = "OptionItemCell"
    
    static let orgasmVideo = "vid_orgasm"
    static let disgustVideo = "vid_disgust"
    static let mehVideo = "vid_meh"
    static let spicyVideo = "vid_spicy"

}
