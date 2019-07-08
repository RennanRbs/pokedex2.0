//
//  PokemonModelBase.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 07/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//


import UIKit


class PokemonModelBase {
    
    func predict(with image: UIImage) -> (String, Double)? {
        guard let imageResized = imageWithImage(image: image, scaledToSize: CGSize(width: 299, height: 299)),
            let pixelBuffer = toCVPixelBuffer(image: imageResized) else { return nil }
        do {
            let pokemonModel = PokemonMlModel()
            let output = try pokemonModel.prediction(image: pixelBuffer)
            return (output.classLabel, output.classLabelProbs[output.classLabel] ?? 50)
        } catch let err {
            print(err)
            return nil
        }
    }
    
    private func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    private func toCVPixelBuffer(image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard status == kCVReturnSuccess else {
            return nil
        }
        
        if let pixelBuffer = pixelBuffer {
            CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
            let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
            
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            
            context?.translateBy(x: 0, y: image.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            
            UIGraphicsPushContext(context!)
            image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            UIGraphicsPopContext()
            CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
            
            return pixelBuffer
        }
        
        return nil
    }
    
}

