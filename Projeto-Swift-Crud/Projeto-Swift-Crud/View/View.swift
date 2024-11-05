//
//  View.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 05/11/24.
//

// Felipe Almeida 22130

import Foundation

import UIKit

import Firebase

import FirebaseFirestore

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registrar evento no Firebase Analytics
        Analytics.logEvent("test_event", parameters: [
            "name": "test_name" as NSObject,
            "full_text" : "Hello Firebase!" as NSObject
        ])
        
        // salvar dados no Firestore
        let db = Firestore.firestore()
        db.collection("test").document("testDoc").setData(["message": "Hello Firestore!"]) {
            error in
            if let error = error {
                print("Erro ao escrever no Firestore: \(error)")
            } else {
                print("Documento salvo!")
            }
        }
    }
}
