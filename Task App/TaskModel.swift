import UIKit
import os.log

class Task: NSObject, NSCoding{
    
    var taskDescription: String
    
    //creates paths to the data through the system in order to keep track of where the saved tasks go. 
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("tasks")
    
    struct Key{
        static let taskDescription = "taskDescription"
    }
    
    init?(taskDescription: String) {
        //checks if task is empty
        if taskDescription.isEmpty {
            return nil
        }
        self.taskDescription = taskDescription
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskDescription, forKey: Key.taskDescription)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //The initializer will fail if there is no task description
        guard let taskDescription = aDecoder.decodeObject(forKey: Key.taskDescription) as? String
            else{
                os_log("Unable to decode the task description.", log: OSLog.default, type: .debug)
                return nil
        }
        
        self.init(taskDescription: taskDescription)
    }
}
