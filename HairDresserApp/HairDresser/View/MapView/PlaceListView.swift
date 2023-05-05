//
//  PlaceListView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 28/03/23.
//

import SwiftUI

struct PlaceListView: View {
    
    let landmarks: [Landmark]
    let callBack: (Landmark) -> Void
    
    var body: some View {
        List(landmarks) { landmark in
            VStack(alignment: .leading, spacing: 10) {
                Text(landmark.name)
                    .fontWeight(.bold)
                Text(landmark.title)
                    .fontWeight(.semibold)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    callBack(landmark)
                }
        }.animation(nil, value: landmarks)
            .background(Color.clear)
        
           // .frame(maxHeight: UIScreen.main.bounds.height * 0.8)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmarks: [], callBack: { _ in })
    }
}

