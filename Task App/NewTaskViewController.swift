import UIKit
import os.log

class NewTaskViewController: UIViewController,
    UITextFieldDelegate {
    
    @IBOutlet weak var taskText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskText.delegate = self
        
        if let task = task{
            navigationItem.title = task.taskDescription
            taskText.text = task.taskDescription
        }
        updateSavedButton()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSavedButton()
        navigationItem.title = textField.text
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let taskDescription = taskText.text ?? ""
        task = Task(taskDescription: taskDescription)
        
    }
    
    private func updateSavedButton() {
        let text = taskText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    
}


