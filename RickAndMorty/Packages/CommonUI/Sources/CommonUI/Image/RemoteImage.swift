//
//  RemoteImage.swift
//  CommonUI
//
//  Created by Shorouk Mohamed on 13/01/2025.
//


import SwiftUI
import Utilities

public struct RemoteImage: View {
    @State private var image: UIImage? = nil
    @State private var isLoading = true
    @State private var hasError = false
    public let urlString: String
    public let placeholderImage: UIImage? = nil
    
    public init(urlString: String) {
        self.urlString = urlString
    }
    
    public var body: some View {
        Group {
            if isLoading {
                ProgressView()
            }
            else if hasError {
                Image(uiImage: placeholderImage ?? UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFit()
            } else if let image = image {
                Image(uiImage: image) 
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {
            UIImage.download(from: urlString) { downloadedImage in
                if downloadedImage != nil {
                    self.image = downloadedImage
                } else {
                    self.hasError = true
                }
                self.isLoading = false
            }
        }
    }
}
