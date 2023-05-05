//
//  ImageHelper.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 07/03/23.
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
    
    static func getImageFromURL(url: URL) -> UIImage? {
        if let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            return image
        }
        return nil
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


