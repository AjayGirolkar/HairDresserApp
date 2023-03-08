//
//  ImageHelper.swift
//  HairDresserApp
//
//  Created by Ajay Girolkar on 07/03/23.
//

import SwiftUI

struct ImageHelper {
    
    static func getPlusCircleImageView(foreGroundColor: Color = .black) -> some View {
        ZStack {
            Circle()
                .strokeBorder(foreGroundColor,lineWidth: 2)
                .frame(width: 120, height: 120)
            VStack {
                Image(systemName: "plus")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .foregroundColor(foreGroundColor)
                Text("Photo")
                    .foregroundColor(foreGroundColor)
            }
        }
        
    }
}

extension UIView {
    // This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

