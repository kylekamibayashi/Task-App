import UIKit
import os.log

class NewTaskViewController: UIViewController,
    UITextFieldDelegate {
    
    @IBOutlet weak var taskText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //handles the users input through delegation.
        taskText.delegate = self
        
        if let task = task{
            navigationItem.title = task.taskDescription
            taskText.text = task.taskDescription
        }
        updateSavedButton()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
        //if user is editing task, disables save button
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //hides keyboard once user finishes writing out the task
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSavedButton()
        navigationItem.title = textField.text
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        //returns to homescreen when user hits cancel button
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The NewTaskViewController is not inside a navigation controller.")
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("Cancelling proccess, save button was not pressed. ", log: OSLog.default, type: .debug)
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


