import UIKit

class CheckmarkControl: UIButton{
    //set checkmark and box as images that were imported
    let checkMark = UIImage(named: "checkboxwithmark")! as UIImage
    let checkBox = UIImage(named: "checkbox")! as UIImage
    
    //checks to see if the box has been checked already
    var isChecked: Bool = false{
        didSet{
            if isChecked == true{
                self.setImage(checkMark, for: UIControlState.normal)
            }else{
                self.setImage(checkBox, for: UIControlState.normal)
            }
        }
    
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton){
        if sender == self{
            isChecked = !isChecked
        }
    }
}
