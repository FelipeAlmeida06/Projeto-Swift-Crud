//
//  FirebaseManager.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 05/11/24.
//

import Foundation
import FirebaseAnalytics
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    private init() {}
    
    func logEvent(name: String, parameters: [String: NSObject]?) {
        Analytics.logEvent(name, parameters: parameters)
    }

    func saveData(collection: String, document: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection(collection).document(document).setData(data) { error in
            completion(error)
        }
    }
}
