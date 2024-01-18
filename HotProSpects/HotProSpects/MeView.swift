//
//  MeView.swift
//  HotProSpects
//
//  Created by M Sapphire on 2024/1/15.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Sapphire"
    @State private var email = "sapphire@gmail.com"
    @State private var qrcode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("enter your name", text: $name)
                    .textContentType(.name)
                
                TextField("email address", text: $email)
                    .textContentType(.emailAddress)
                
                Image(uiImage: qrcode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 320, height: 320)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrcode)
                        } label: {
                            Label("Save", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .onAppear { updateQrcode() }
            .onChange(of: name, updateQrcode)
            .onChange(of: email, updateQrcode)
        }
    }
    
    func updateQrcode() {
        qrcode = generateQrcode("\(name)\n\(email)")
    }
    func generateQrcode(_ str: String) -> UIImage {
        filter.message = Data(str.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
