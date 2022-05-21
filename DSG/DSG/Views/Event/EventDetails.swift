
//  Created by Ben Rettig on 5/19/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventDetailView: View {
    
   
    var event: EventModel
    @State var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            topViewSection
            webImageView
            bottomDetailView
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Details")
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        }}}


    }

    private var favoriteButton: some View {
        Button {
            isSelected.toggle()
        } label: {
            Image(systemName: isSelected ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color.red)
        }.onChange(of: isSelected) { newValue in
            event.favorite = newValue
            UserDefaults.standard.set(event.favorite, forKey: String(event.id))
        }
    }
    
    private var topViewSection: some View {
        HStack {
            Text(event.title)
                .font(.title)
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .padding(.horizontal,4 )
                .padding(.top,4)
            Spacer()
            HStack{
            favoriteButton
            }
        }
        .padding(.horizontal)
        .padding(.top,4)

    }

    private var webImageView: some View {
        VStack {
            WebImage(url: URL(string: event.performers![0].image))
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
        }
    }

    
    private var bottomDetailView: some View {
        VStack(alignment: .leading) {
            Text(event.returnDateString())
                .font(.title)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
            
            Text(event.venue!.display_location)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(Color.gray)
              Spacer()
        }
        .padding(.horizontal)

    }
}


