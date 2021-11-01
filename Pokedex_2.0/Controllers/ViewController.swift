//
//  ViewController.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 04/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//
import UIKit
import AVFoundation

final class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
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

    var myView = MyView()

    
    override func viewDidLoad() {
        view.addSubview(myView)
        super.viewDidLoad()
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigate))
        swipeGesture.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeGesture)
        self.navigationController?.isNavigationBarHidden = true
        setup()
        animationLeds()
        
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

}
