//
//  ContentView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 05/11/24.
//

/*
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
*/

import SwiftUI
import FirebaseAnalytics
import FirebaseFirestore

struct ContentView: View {
    // Firestore instance
    let db = Firestore.firestore()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Ícone e texto de boas-vindas
                Image(systemName: "film")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                //Text("Bem-vindo ao Projeto CRUD feito em Swift")
                Text("Projeto CRUD feito em Swift")
                    .font(.headline)

                // Botão para logar evento e salvar dados no Firebase
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
                    /*
                    Text("Registrar eventos e salvar dados")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                     */
                }
                

                // Botão para ir para a tela de cadastro
                NavigationLink(destination: CadastroView()) {
                    Text("Ir para Cadastro")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle("Tela Principal")
        }
    }
}

#Preview {
    ContentView()
}

