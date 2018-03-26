import UIKit
import os.log

class Task: NSObject, NSCoding{
    
    var taskDescription: String
    //var checkmarked: Bool?
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("tasks")
    
    struct Key{
        static let taskDescription = "taskDescription"
    }
    init?(taskDescription: String) {
        if taskDescription.isEmpty {
            return nil
        }
        self.taskDescription = taskDescription
        //self.checkmarked = checkmarked
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskDescription, forKey: Key.taskDescription)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let taskDescription = aDecoder.decodeObject(forKey: Key.taskDescription) as? String
            else{
                os_log("Unable to decode taskDescription for Task object", log: OSLog.default, type: .debug)
                return nil
        }
        
        self.init(taskDescription: taskDescription)
    }
}
