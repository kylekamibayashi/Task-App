import UIKit

class TaskTableViewCell: UITableViewCell {
    
    //Task Properties
    @IBOutlet weak var taskLabel: UILabel!
    @IBAction func checkbox(_ sender: CheckmarkControl) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
