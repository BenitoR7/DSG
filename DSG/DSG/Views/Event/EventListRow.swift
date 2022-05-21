//
//  EventListRow.swift
//  DSG
//
//  Created by Ben Rettig on 5/19/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventListRow: View {
    
    var event: EventModel
    @State var isSelected: Bool
    
    var body: some View {
        VStack {
            HStack {
             ImageView
                eventInfoView
            }
        }.onAppear {
            isSelected = event.favorite ?? false
        }
    }
    private var eventInfoView: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .lineLimit(2)
            Text(event.venue!.display_location)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(event.returnDateString())
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical,4)
        .padding(.horizontal,2)
        .frame(width: 180)


        
    }
    
    private var ImageView: some View {
        WebImage(url: URL(string: event.performers?[0].image ?? ""))
        .resizable()
        .frame(width: 60, height: 60)
        .cornerRadius(5)
        .padding(.horizontal,2)

        .overlay(alignment: .topLeading) {
            if isSelected {
                favoriteButton
                    .offset(x: -15, y: -10)

            }

        }
    }
    
    private var favoriteButton: some View {
        Image(systemName: isSelected ? "heart.fill" : "heart")
            .resizable()
            .frame(width: 18, height: 18)
            .shadow(color: .white, radius: 5, x: 10, y: 10)
            .foregroundColor(Color.red)
    }
}
