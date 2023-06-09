//
//  InstafilterView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 15.05.2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct InstafilterView: View {
    @State private var image: Image?
    @State private var filterInensity = 0.5
    @State private var filterScale = 0.5
    @State private var filterRadius = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.secondary)
                
                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)
                
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onTapGesture {
                showingImagePicker = true
            }
            
            filterSliderIntensity
                
            //New slider for scale and radius
            filterSliderScale
                
            filterSliderRadius
            
            HStack {
                Button("Change Filter") {
                    showingFilterSheet = true
                }
                
                Spacer()
                
                Button("Save", action: save)
                    .disabled(image == nil)     //Add disabled button if there is no image in the image view
            }
        }
        .padding([.horizontal, .bottom])
        .navigationTitle("Instafilter")
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
            Group {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
            }
            
            //New filter
            Group {
                Button("Edge Work") { setFilter(CIFilter.edgeWork()) }
                Button("Bloom") { setFilter(CIFilter.bloom()) }
                Button("Gloom") { setFilter(CIFilter.gloom()) }
            }
            Button("Cancel", role: .cancel) {  }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterInensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

extension InstafilterView {
    var filterSliderIntensity: some View {
        HStack {
            Text("Intensity")
            Slider(value: $filterInensity)
                .onChange(of: filterInensity) { _ in applyProcessing() }
        }
        .padding(.vertical)
    }
    
    var filterSliderScale: some View {
        HStack {
            Text("Scale")
            Slider(value: $filterScale)
                .onChange(of: filterScale) { _ in applyProcessing() }
        }
        .padding(.vertical)
    }
    
    var filterSliderRadius: some View {
        HStack {
            Text("Radius")
            Slider(value: $filterRadius)
                .onChange(of: filterRadius) { _ in applyProcessing() }
        }
        .padding(.vertical)
    }
}

struct InstafilterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InstafilterView()
        }
    }
}
