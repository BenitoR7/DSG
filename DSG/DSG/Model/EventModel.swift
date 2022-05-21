//
//  EventModel.swift
//  TypeAheadSearch
//
//  Created by Ben Rettig on 5/19/22.
//

import Foundation
import SwiftUI


struct EventsResponse: Decodable {
    let events: [EventModel]
}

class EventModel: Decodable, Identifiable
{

    var id: Int
    var title: String
    var datetime_local: String
    var venue: Venue? = nil
    var performers: [Performer]? = []
    var favorite: Bool? = false
    
    init(id: Int, title: String, datetime_local: String) {
        self.id = id
        self.title = title
        self.datetime_local = datetime_local
    }

    
    struct Venue: Codable {
        let display_location: String
    }
    
    struct Performer: Codable {
        let image: String
    }
    
    func fetchDate() -> Date {
        let dateString = datetime_local
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:dateString) ?? Date()
        return date
    }
    
    func returnDateString() -> String {
        let date = fetchDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy h:mm a"
        return dateFormatter.string(from: date).uppercased()
    }
}

