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
*/



import SwiftUI

struct ContentView: View {
    @State private var filmes: [Filme] = [] // Lista compartilhada entre Cadastro e Detalhes

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "film")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Text("Projeto CRUD feito em Swift")
                    .font(.headline)

                NavigationLink(destination: CadastroView(filmes: $filmes)) {
                    Text("Ir para Cadastro")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                NavigationLink(destination: DetalhesView(filmes: $filmes)) {
                    Text("Ver Detalhes dos Filmes")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle("Tela Principal")
        }
    }
}
