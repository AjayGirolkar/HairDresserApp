//
//  SearchBar.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 11/03/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search..", text: $searchText)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                }.onTapGesture {
                    isEditing = true
                }
            if isEditing {
                Button {
                    isEditing = false
                    searchText = ""
                    UIApplication.shared.endEditing() //Dismiss keyboard
                } label: {
                    Text("Cancel")
                        .foregroundColor(.primary)
                        .padding(.trailing, 8)
                        .transition(.move(edge: .trailing))
                        .animation(.default, value: "")
                }
                
            }
        }.cornerRadius(5)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), isEditing: .constant(false))
    }
}
