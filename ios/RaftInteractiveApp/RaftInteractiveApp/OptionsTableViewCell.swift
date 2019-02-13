import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    var vc: ViewController?
    
    // these two are mutually exclusive
    
    var checkbox: Checkbox?
    var itemLabel: UILabel?
    var index: Int = 0
    
    // MARK: Initalizers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        checkbox = Checkbox(frame: CGRect(x: self.bounds.minX+Constants.leftMargin, y: Constants.totalHeight/2 - Constants.checkboxWidth/2, width: Constants.checkboxWidth, height: Constants.checkboxWidth))
        checkbox?.checkedBorderColor = UIColor(hexString: Constants.checkboxColorHex)
        checkbox?.uncheckedBorderColor = UIColor(hexString: Constants.checkboxColorHex)
        checkbox?.checkmarkColor = UIColor(hexString: Constants.checkboxColorHex)
        checkbox?.useHapticFeedback = true
        checkbox?.borderWidth = 3.0
        checkbox?.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        contentView.addSubview(checkbox!)
        
        let labelHeight = Constants.fontSize+2
        itemLabel = UILabel(frame: CGRect(x: checkbox!.frame.maxX + Constants.checkboxLabelBuffer, y: Constants.totalHeight/2 - labelHeight/2, width: Constants.itemLabelWidth, height: Constants.fontSize+2))
        itemLabel?.textAlignment = .left
        itemLabel?.font = FontManager.sharedInstance.regular(size: Constants.fontSize)
        itemLabel?.textColor = UIColor.darkGray
        contentView.addSubview(itemLabel!)
        
        
        // cell config
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        vc?.playVideo(index: index)
    }
    
}

private struct Constants {
    static let leftMargin: CGFloat = 20
    static let fontSize: CGFloat = 16
    static let totalHeight: CGFloat = 50
    
    // checkbox
    static let checkboxWidth: CGFloat = 25
    static let checkboxTopMargin: CGFloat = 5
    static let checkboxColorHex = "0076FF"
    
    // Labels
    static let checkboxLabelBuffer: CGFloat = 10
    static let itemLabelWidth: CGFloat = 200
    static let priceLabelWidth: CGFloat = 50
}
