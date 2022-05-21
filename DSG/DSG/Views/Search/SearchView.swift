//
//  SearchView.swift
//  DSG
//
//  Created by Ben Rettig on 5/19/22.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchListViewModel: SearchListViewModel = SearchListViewModel()
    @State private var searchText: String = ""

    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.init(Color(Constants.navBarColor))
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.init(.white)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
    }
    
    var body: some View {
       searchListView
    }
    
  
    
    private var searchListView: some View {
        
        List(searchListViewModel.events) { event in
            
            ZStack {
                Color.white
                    .cornerRadius(12)


                NavigationLink (destination: EventDetailView(event: event, isSelected: event.favorite ?? false)) {
                    EmptyView()
                }
                .opacity(0)
                              .buttonStyle(PlainButtonStyle())
            label: do {
                EventListRow(event: event, isSelected: event.favorite ?? false)
                       }
        
        }
            .listRowSeparator(.hidden)

                    .fixedSize(horizontal: false, vertical: true)

        .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
            
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)

        .onDisappear {
            UITableView.appearance().separatorStyle = .singleLine
            
        } }

        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Constants.searchText)
        .foregroundColor(Color.white)
        .onChange(of: searchText) { text in
            Task { await searchListViewModel.getEvent(searchText: text) }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
