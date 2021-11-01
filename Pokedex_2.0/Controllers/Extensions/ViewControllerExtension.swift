//
//  ViewControllerConstrains.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 07/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//

import UIKit
import AVFoundation

extension ViewController {
    
    @objc func navigate() {
        let newViewController = ViewControllerAllPoke()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func verifyPokemon(basedAt image: UIImage?) {
        guard let image = image else { return }
        let prediction = PokemonModelBase().predict(with: image)
        labelPokemon.text = prediction?.0
    }
    
    @objc func catchBtn(_ sender: UIButton)  {
        sender.pulsate()
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func saveBtn(_ sender: UIButton)  {
        sender.pulsate()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        previewPokedex.image = image
        verifyPokemon(basedAt: image)
    }
    
    func animationLeds() {
        let imagesRed: [UIImage] = [#imageLiteral(resourceName: "red"), #imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "vazio")]
        let imagesYellow: [UIImage] = [#imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "yellow"), #imageLiteral(resourceName: "vazio")]
        let imagesGreen: [UIImage] = [#imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "green")]
        redLed.image = UIImage.animatedImage(with: imagesRed, duration: 1)
        yellowLed.image = UIImage.animatedImage(with: imagesYellow, duration: 1)
        greeLed.image = UIImage.animatedImage(with: imagesGreen, duration: 1)
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        videoPreviewLayer.cornerRadius = 15
        previewCameraPokedex.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewCameraPokedex.bounds
            }
        }
    }

    func setup()  {
        view.addSubview(backgroundPokedex)
        view.addSubview(redLed)
        view.addSubview(yellowLed)
        view.addSubview(greeLed)
        view.addSubview(cameraPokedex)
        view.addSubview(previewPokedex)
        view.addSubview(labelPokemonName)
        view.addSubview(labelPokemon)
        view.addSubview(buttonCatch)
        view.addSubview(saveButton)
        view.addSubview(previewCameraPokedex)
        
        NSLayoutConstraint.activate([
            
            backgroundPokedex.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundPokedex.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundPokedex.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundPokedex.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            cameraPokedex.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            cameraPokedex.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            previewCameraPokedex.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0),
            previewCameraPokedex.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:-96),
            
            redLed.widthAnchor.constraint(equalToConstant: 11),
            redLed.heightAnchor.constraint(equalToConstant: 11),
            redLed.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 57),
            redLed.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -314),
            
            yellowLed.widthAnchor.constraint(equalToConstant: 11),
            yellowLed.heightAnchor.constraint(equalToConstant: 11),
            yellowLed.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 76),
            yellowLed.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -314),
            
            greeLed.widthAnchor.constraint(equalToConstant: 11),
            greeLed.heightAnchor.constraint(equalToConstant: 11),
            greeLed.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 96),
            greeLed.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -314),
            
            previewPokedex.widthAnchor.constraint(equalToConstant: 150),
            previewPokedex.heightAnchor.constraint(equalToConstant: 150),
            previewPokedex.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 240),
            previewPokedex.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 84),
            
            labelPokemonName.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120),
            labelPokemonName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            labelPokemonName.widthAnchor.constraint(equalToConstant: 320),
            labelPokemonName.heightAnchor.constraint(equalToConstant: 70),
            
            labelPokemon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120),
            labelPokemon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            buttonCatch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:-80),
            buttonCatch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:274),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:-80),
            saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:200),
            ])
    }
}
