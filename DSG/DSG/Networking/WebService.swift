//
//  WebService.swift
//  TypeAheadSearch
//
//  Created by Ben Rettig on 5/19/22.
//

import Foundation


class WebService {
    
    static let shared = WebService().self
    private var dataTask: URLSessionDataTask?
    
    func fetchEventData(searchText: String) async throws -> [EventModel] {
        
        guard let url = URL(string: "\(Constants.Url)?client_id=\(Constants.Id)&q=\(searchText.replacingOccurrences(of: " ", with: "+"))") else {
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let eventsData = try? JSONDecoder().decode(EventsResponse.self, from: data)

        guard let events = eventsData?.events else {
            return []
        }
        return events
    }
}
