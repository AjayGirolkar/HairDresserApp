//
//  LoadingView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 15/03/23.
//

import SwiftUI

enum LoadingViewType {
    case activityIndicator
    case progressView
}

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var message: String = "Please wait..."
    var loadingViewType: LoadingViewType = .activityIndicator
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
            
                switch loadingViewType {
                case .activityIndicator:
                    getActivityIndicatorView(geometry: geometry)
                case .progressView:
                    getProgressView()
                }
                
            }
        }
    }
    
    func getActivityIndicatorView(geometry: GeometryProxy) -> some View {
        VStack {
            Text(message)
            ActivityIndicator(isAnimating: .constant(true), style: .large)
        }
        .frame(width: geometry.size.width / 2,
               height: geometry.size.height / 5)
        .background(Color.secondary.colorInvert())
        .foregroundColor(Color.primary)
        .cornerRadius(20)
        .opacity(self.isShowing ? 1 : 0)
    }
    
    func getProgressView() -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .primary))
            .scaleEffect(2)
            .opacity(self.isShowing ? 1 : 0)
    }
    
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoadingView(isShowing: .constant(true)) {
                VStack {
                    
                }.frame(width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height)
            }
        }
    }
}
