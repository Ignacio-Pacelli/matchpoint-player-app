//
//  ReservationViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 27/1/21.
//
import UIKit
import Foundation
import CalendarKit
import Alamofire
import CoreData

class ReservationViewController: DayViewController {
    
    var bookings: [Booking] = []
    var club : Club?
    var court : Court?
    
    var selectedStartDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = court?.name
        self.fetchBookings()
    }
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        print(#function)
        self.selectedStartDate = eventView.descriptor!.startDate
        self.performSegue(withIdentifier: "BookingSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "BookingSegue":
            let bookingVC = segue.destination as! Cart4View
            bookingVC.club = self.club!
            bookingVC.court = self.court!
            bookingVC.playerId = 1
            bookingVC.startBooking = self.selectedStartDate
            bookingVC.endBooking = Calendar.current.date(byAdding: .hour, value: 1, to: self.selectedStartDate!)
            bookingVC.reservationsVC = self
        default:
            return
        }
}
    
    
    // Return an array of EventDescriptors for particular date
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        
        var events = [Event]()
        var availableSlots = [Event]()
        
        // Reservas ya realizadas
        for booking in bookings {
            let event = Event()
            event.startDate = booking.startDate!
            let end = Calendar.current.date(byAdding: .minute, value: -1, to: booking.endDate!)
            event.endDate = end!
            event.text = "RESERVADA"
            event.backgroundColor = .systemRed
            events.append(event)
        }
        
        var day = Date()
        // Horas disponibles
        for _ in 1...14{
            let startHour = Calendar.current.component(.hour, from: (court?.openingTime)!)
            let endHour = Calendar.current.component(.hour, from: (court?.closingTime)!)-1
            
            for hour in startHour...endHour{
                if(!existsBookigAtHour(hour: hour, day: day, events: events) &&
                isInTheFuture(hour: hour, day: day)){
                    print("Added hour %d", hour)
                    let newEvent = Event()
                    let startHour = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: day)!
                    let endHour = Calendar.current.date(byAdding: .minute, value: 59, to: startHour)
                    newEvent.startDate = startHour
                    newEvent.endDate = endHour!
                    newEvent.text = "DISPONIBLE"
                    newEvent.backgroundColor = .systemGreen
                    availableSlots.append(newEvent)
                }
            }
            day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
        }
        
        events.append(contentsOf: availableSlots)
        
        let nowHour = Calendar.current.component(.hour, from: Date())
        self.dayView.scrollTo(hour24: Float(nowHour))

        return events
    }
    
    func isInTheFuture(hour : Int, day : Date) -> Bool{
    
        let hourNow = Calendar.current.component(.hour, from: Date())
        
        if(Calendar.current.isDate(day, inSameDayAs: Date()) &&
            hourNow < hour){
            return true
        }
        else if (Calendar.current.compare(day, to: Date(), toGranularity: .day).rawValue > 0){
            return true
        }
        
        return false
    }
    
    func existsBookigAtHour(hour : Int, day : Date, events : [Event]) -> Bool{
        for event in events {
            let eventStartHour = Calendar.current.component(.hour, from: (event.startDate))
            let eventEndHour = Calendar.current.component(.hour, from: (event.endDate))
            
            if hour >= eventStartHour && hour <= eventEndHour &&
                Calendar.current.isDate(day, inSameDayAs: event.startDate)
            {
                print("hay evento en la hora %d", hour)
                print(event)
                return true
            }
        }
        return false
    }
    
    func fetchBookings() {
        
        let clubId : String = String(club!.id)
        let courtId : String = String(court!.id)
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let url : String = BASE_URL+CLUB_URL+clubId+COURT_URL+courtId+BOOKING_URL
        
        AF.request(url, headers: nil).responseJSON { response in
            if let data = response.data {
                self.bookings = try! decoder.decode(Array<Booking>.self, from: data)
                self.reloadData()
            }
        }
    }
    
}
