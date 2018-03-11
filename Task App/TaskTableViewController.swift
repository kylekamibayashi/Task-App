import UIKit

class TaskTableViewController: UITableViewController {
    
    var tasks: [String] = ["Task1", "Task2", "Task3"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    @IBAction func AddTaskButton(_ sender: Any) {
        tasks.append("New Task")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell")!
        cell.textLabel?.text = task
        return cell
    }
}
