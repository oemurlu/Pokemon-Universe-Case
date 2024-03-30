//
//  MakeAlert.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 30.03.2024.
//

import UIKit

enum MakeAlert {
    static func alertMessage(title: String, message: String, style: UIAlertController.Style, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
}
