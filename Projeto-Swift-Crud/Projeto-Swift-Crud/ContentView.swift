//
//  ContentView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 05/11/24.
//


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
