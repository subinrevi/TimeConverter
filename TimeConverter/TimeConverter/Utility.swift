//  TimeConverter
//
//  Created by Subin Revi on 7/17/23.

import Foundation

extension Date {
    func hour() -> Int {
        //Get Hour
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: self)

        //Return Hour
        return hour
    }


    func minute() -> Int {
        //Get Minute
        let calendar = NSCalendar.current
        let minute = calendar.component(.minute, from: self)

        //Return Minute
        return minute
    }

    func toShortTimeString() -> String {
        //Get Short Time String
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timeString = formatter.string(from: self)

        //Return Short Time String
        return timeString
    }
    
    // Convert local time to UTC (or GMT)
        func toGlobalTime() -> Date {
            let timezone = TimeZone.current
            let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
            return Date(timeInterval: seconds, since: self)
        }

        // Convert UTC (or GMT) to local time
        func toLocalTime() -> Date {
            
            // 1) Get the current TimeZone's seconds from GMT. Since I am in Chicago this will be: 60*60*5 (18000)
            let timezoneOffset = TimeZone.current.secondsFromGMT()
            
            // 2) Get the current date (GMT) in seconds since 1970. Epoch datetime.
            let epochDate = self.timeIntervalSince1970
            
            // 3) Perform a calculation with timezoneOffset + epochDate to get the total seconds for the
            //    local date since 1970.
            //    This may look a bit strange, but since timezoneOffset is given as -18000.0, adding epochDate and timezoneOffset
            //    calculates correctly.
            let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
            
            
            // 4) Finally, create a date using the seconds offset since 1970 for the local date.
            return Date(timeIntervalSince1970: timezoneEpochOffset)
        }

}
