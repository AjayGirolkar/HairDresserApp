//
//  AsyncImageView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 06/04/23.
//

import SwiftUI

struct AsyncImageView: View {
    var url: URL?
    var placeHolderImageName = "profile"
    var width: Double
    var height: Double
    
    var body: some View {
        ZStack {
            AsyncImage(url: url, scale: 2) { image in
                image
                    .resizable()
                    .frame(width: width, height: height)
                    .padding()
            } placeholder: {
                Image(systemName: placeHolderImageName)
                    .resizable()
                    .frame(width: width, height: height)
                    .padding()
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            if let url = URL(string: "") {
                AsyncImageView(url: url, width: 100, height: 100)
            }
        }
    }
}
