//  TimeConverter
//
//  Created by Subin Revi on 7/17/23.


import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var currentTime: NSTextField!
    
    @IBOutlet weak var pstTimeLabel: NSTextField!
    
    @IBOutlet weak var cstTimeLabel: NSTextField!
    
    @IBOutlet weak var utcTimeLabel: NSTextField!
    
    @IBOutlet weak var estTimeLabel: NSTextField!
    
    @IBOutlet weak var istTimeLabel: NSTextField!
    
    @IBOutlet weak var timePicker: NSDatePicker!
    
    @IBOutlet weak var errorLabel: NSTextField!
    
    @IBOutlet weak var sgtTimeLabel: NSTextField!
    
    @IBOutlet weak var jstTimeLabel: NSTextField!
    
    var timeInterval: Double?
    
    var timeZones: [String] = [Constants.utc, Constants.ist, Constants.pst, Constants.est, Constants.cst, Constants.jst, Constants.sgt]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.black.cgColor
        
        for time in timeZones {
            switch time {
            case Constants.utc:
                utcTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: Constants.defaultTimeInterval) ?? Constants.emptyString
            case Constants.ist:
                istTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: Constants.defaultTimeInterval) ?? Constants.emptyString
            case Constants.pst:
                pstTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: Constants.defaultTimeInterval) ?? Constants.emptyString
            case Constants.est:
                estTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: Constants.defaultTimeInterval) ?? Constants.emptyString
            case Constants.cst:
                cstTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: Constants.defaultTimeInterval) ?? Constants.emptyString
                currentTime.stringValue = cstTimeLabel.stringValue
            case Constants.jst:
                jstTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: Constants.defaultTimeInterval) ?? Constants.emptyString
            case Constants.sgt:
                sgtTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: Constants.defaultTimeInterval) ?? Constants.emptyString
            default:
                debugPrint("None")
            }
            
        }
    }
    
    @IBAction func convertTimeButtonTapped(_ sender: NSButton) {
        
        guard let newTime = timeInterval else {
            return
        }
        
        if newTime > 1 {
            
            for time in timeZones {
                switch time {
                case Constants.utc:
                    utcTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: newTime) ?? ""
                case Constants.ist:
                    istTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: newTime) ?? ""
                case Constants.pst:
                    pstTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: newTime) ?? ""
                case Constants.est:
                    estTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: newTime) ?? ""
                case Constants.cst:
                    cstTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: newTime) ?? ""
                    currentTime.stringValue = cstTimeLabel.stringValue
                case Constants.jst:
                    jstTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: newTime) ?? ""
                case Constants.sgt:
                    sgtTimeLabel.stringValue = getDateAndTime(timeZoneIdentifier: time, timeInterval: newTime) ?? ""
                    
                default:
                    debugPrint("None")
                }
            }
        }
    }
    
    func getDateAndTime(timeZoneIdentifier: String, timeInterval: TimeInterval) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        dateFormatter.timeStyle = .short
                
        return dateFormatter.string(from: Date().addingTimeInterval(timeInterval))
    }

    @IBAction func selectedTime(_ sender: NSDatePicker) {
        self.timeInterval = sender.dateValue.timeIntervalSinceNow
        
        if let timeInterval = self.timeInterval {
            errorLabel.isHidden = (timeInterval < 0) ? false: true
        }
    }
    
    @IBAction func closeAppButtonTapped(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
    
}

