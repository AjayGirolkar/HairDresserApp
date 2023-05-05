//
//  NavigationLazyView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 28/04/23.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
