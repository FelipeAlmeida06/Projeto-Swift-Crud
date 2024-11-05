//
//  ContentView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 05/11/24.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseFirestore

struct ContentView: View {
    
    // Firestore instance
        let db = Firestore.firestore()
        
        var body: some View {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                Button(action: {
                    FirebaseManager.shared.logEvent(name: "test_event", parameters: [
                            "name": "test_name" as NSObject,
                            "full_text": "Hello Firebase!" as NSObject
                        ])
                    
                    FirebaseManager.shared.saveData(collection: "test", document: "testDoc", data: ["message": "Hello Firestore!"]) { error in
                            if let error = error {
                                print("Erro ao escrever no Firestore: \(error)")
                            } else {
                                print("Documento salvo com sucesso!")
                            }
                        }
                }) {
                    Text("Registrar eventos e salvar dados")   // Log Event and Save Data
                }
                .padding()
            }
            .padding()
        }
    
    func logEventAndSaveData() {
            // Register event in Firebase Analytics
            Analytics.logEvent("test_event", parameters: [
                "name": "test_name" as NSObject,
                "full_text": "Hello Firebase!" as NSObject
            ])
            
            // Save data in Firestore
            db.collection("test").document("testDoc").setData(["message": "Hello Firestore!"]) { error in
                if let error = error {
                    print("Erro ao escrever no Firestore: \(error)")
                } else {
                    print("Documento salvo com sucesso!")
                }
            }
        }
}

#Preview {
    ContentView()
}
