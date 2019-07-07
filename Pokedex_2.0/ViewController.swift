//
//  ViewController.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 04/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    let buttonCatch: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  Catch  ", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.alpha = 0.8
        button.layer.cornerRadius = 8
        button.addTarget(self, action:#selector(catchBtn), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("   Save   ", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.alpha = 0.8
        button.layer.cornerRadius = 8
        button.addTarget(self, action:#selector(saveBtn), for: .touchUpInside)
        return button
    }()
    
    let backgroundPokedex: UIImageView = {
        var pokedex = UIImageView(image: UIImage(named: "pokedex"))
        pokedex.translatesAutoresizingMaskIntoConstraints = false
        return pokedex
    }()

    
    let cameraPokedex: UIImageView = {
        var pokedex = UIImageView(image: UIImage(named: "camera"))
        pokedex.translatesAutoresizingMaskIntoConstraints = false
        
        return pokedex
    }()
    
    let previewPokedex: UIImageView = {
        var pokedex = UIImageView(image: UIImage(named: "fundo"))
        pokedex.translatesAutoresizingMaskIntoConstraints = false
        return pokedex
    }()
    
    let previewCameraPokedex: UIImageView = {
        var pokedex = UIImageView(image: UIImage(named: "fundo"))
        pokedex.translatesAutoresizingMaskIntoConstraints = false
        return pokedex
    }()
    
    let labelPokemonName: UIImageView = {
        let pokemon = UIImageView()
        pokemon.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pokemon.clipsToBounds = true
        pokemon.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        pokemon.layer.borderWidth = 1
        pokemon.layer.cornerRadius = 10
        pokemon.translatesAutoresizingMaskIntoConstraints = false
        return pokemon
    }()
    
    let labelPokemon: UILabel = {
        let pokemon = UILabel()
        pokemon.text = "Pokemon Name"
        pokemon.textAlignment = .center
        pokemon.translatesAutoresizingMaskIntoConstraints = false
        return pokemon
    }()
    
    let redLed: UIImageView = {
        let pokemon = UIImageView()
        pokemon.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        pokemon.clipsToBounds = true
        pokemon.layer.cornerRadius = 7
        pokemon.translatesAutoresizingMaskIntoConstraints = false
        return pokemon
    }()
    let greeLed: UIImageView = {
        let pokemon = UIImageView()
        pokemon.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        pokemon.clipsToBounds = true
        pokemon.layer.cornerRadius = 7
        pokemon.translatesAutoresizingMaskIntoConstraints = false
        return pokemon
    }()

    let yellowLed: UIImageView = {
        let pokemon = UIImageView()
        pokemon.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        pokemon.clipsToBounds = true
        pokemon.layer.cornerRadius = 7
        pokemon.translatesAutoresizingMaskIntoConstraints = false
        return pokemon
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigate))
        swipeGesture.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeGesture)
        self.navigationController?.isNavigationBarHidden = true
        setup()
        animationLeds()
        
    }
    
   
    
    @objc func navigate() {
        let newViewController = ViewControllerAllPoke()
        self.navigationController?.pushViewController(newViewController, animated: true)
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
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        
        
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
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
    
    func verifyPokemon(basedAt image: UIImage?) {
        guard let image = image else { return }
        let prediction = PokemonModelBase().predict(with: image)
        labelPokemon.text = prediction?.0
    }
    
    func animationLeds() {
        let imagesRed: [UIImage] = [#imageLiteral(resourceName: "red"), #imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "vazio")]
        let imagesYellow: [UIImage] = [#imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "yellow"), #imageLiteral(resourceName: "vazio")]
        let imagesGreen: [UIImage] = [#imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "green")]
        redLed.image = UIImage.animatedImage(with: imagesRed, duration: 1)
        yellowLed.image = UIImage.animatedImage(with: imagesYellow, duration: 1)
        greeLed.image = UIImage.animatedImage(with: imagesGreen, duration: 1)
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

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
}
}

