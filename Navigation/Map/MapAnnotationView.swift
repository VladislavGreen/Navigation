//
//  MapAnnotetionView.swift
//  Navigation
//
//  Created by Vladislav Green on 2/20/23.
//  https://blog.kulman.sk/using-custom-annotation-views-in-mkmapview/

import MapKit


final class MapAnnotationView: MKAnnotationView {
    
    private lazy var userPic: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cat")
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        canShowCallout = true
        
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(annotationViewButtonTapped), for: .touchUpInside)
        rightCalloutAccessoryView = button
        
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(userPic)
        userPic.frame = bounds
    }
    
    @objc
    private func annotationViewButtonTapped() {
        print("annotationViewButtonTapped")
        userPic.layer.borderColor = UIColor.green.cgColor
    }
}
