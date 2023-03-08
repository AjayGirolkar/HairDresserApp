//
//  CheckInView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 06/03/23.
//

import SwiftUI

struct CheckInView: View {
    @State var searchText: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 30){
                    Text("Check Me In")
                        .font(.system(size: 22, weight: .semibold))
                    TextField("Zip code, city or State", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    HStack {
                        Spacer()
                        shareLocationButton
                    }
                    findSalonButton
                    browsSalonDirectoryButton
                    Spacer()
                    
                }.padding()
            }.background(Color.white)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .padding(30)
        }.background(Color(.systemGray6))
    }
    
    var shareLocationButton: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "location.fill")
                Text("Share your current location")
                    .font(.system(size: 12, weight: .regular))
            }
        }
    }
    
    var findSalonButton: some View {
        Button {
            
        } label: {
            Text("FIND A SALON")
                .frame(maxWidth: .infinity)
        }.buttonStyle(.borderedProminent)
    }
    
    var browsSalonDirectoryButton: some View {
        Button {
            
        } label: {
            Text("Brows salon directory")
                .frame(maxWidth: .infinity)
        }.buttonStyle(.automatic)
    }
    
    
    
    
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView(searchText: "")
    }
}
