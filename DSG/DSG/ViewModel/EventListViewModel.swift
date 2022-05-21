//
//  SearchListViewModel.swift
//  DSG
//
//  Created by Ben Rettig on 5/19/22.
//

import Combine
import Foundation
import SwiftUI

class SearchListViewModel: ObservableObject {
    
   
    @Published public private(set) var events: [EventModel] = []
    private let webService: WebService = WebService()
    
    
    func getEvent(searchText: String) async {
        do {
            let events = try? await WebService.shared.fetchEventData(searchText: searchText)
            DispatchQueue.main.async {
                self.events = events.map([EventModel].init) ?? []
                _ = self.events.map {
                    $0.favorite = UserDefaults.standard.bool(forKey: String($0.id))
                }
            }
        }
    }
    
}
