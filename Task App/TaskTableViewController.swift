import UIKit
import os.log

class TaskTableViewController: UITableViewController {
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedTasks = loadTasks(){
            tasks += savedTasks
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TaskTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell
            else{
                fatalError()
        }
        
        let task = tasks[indexPath.row]
        cell.taskLabel.text = task.taskDescription
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? ""){
            
        case "AddTask":
            os_log("Adding new task", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let taskDetailViewController = segue.destination as? NewTaskViewController
                else{
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedTaskCell = sender as? TaskTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedTaskCell)else{
                fatalError("The selected cell is not being displayed")
            }
            
            let selectedTask = tasks[indexPath.row]
            taskDetailViewController.task = selectedTask
            
        default:
            fatalError("Unexpected segue identifier: \(segue.identifier)")
        }
    }
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            NewTaskViewController, let task = sourceViewController.task{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                tasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                let newIndexPath = IndexPath(row: tasks.count, section: 0)
                tasks.append(task)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            saveTasks()
        }
    }
    
    private func saveTasks(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path)
        if isSuccessfulSave{
            os_log("Tasks successfully saved.", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save tasks.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Task.ArchiveURL.path) as? [Task]
        
    }
    
    
   /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
    }*/
}
