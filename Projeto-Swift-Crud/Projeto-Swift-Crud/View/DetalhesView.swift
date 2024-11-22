//
//  DetalhesView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 18/11/24.
//


import SwiftUI
import FirebaseFirestore

struct DetalhesView: View {
    @Binding var filmes: [Filme] // Lista compartilhada
    let db = Firestore.firestore() // Referência ao Firestore
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(filmes) { filme in
                    CardView(filme: filme, onDelete: {
                        excluirFilme(filme) // Chama a função de exclusão
                    })
                }
            }
            .padding()
        }
        .navigationTitle("Filmes Cadastrados")
    }
    
    func excluirFilme(_ filme: Filme) {
        // Exclui o filme do Firestore
        db.collection("filmes").document(filme.id).delete { error in
            if let error = error {
                print("Erro ao excluir o filme do Firebase: \(error.localizedDescription)")
            } else {
                // Se a exclusão no Firebase for bem-sucedida, remove o filme da lista local
                filmes.removeAll { $0.id == filme.id }
            }
        }
    }
     
}

struct CardView: View {
    let filme: Filme
    let onDelete: () -> Void
    
    // botao excluir
    @State private var showAlert = false
    @State private var isDeleted = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: filme.urlImagem)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            
            Text(filme.nomeFilme)
                .font(.headline)
            
            Text("Ano: \(filme.anoLancamento)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {
                showAlert = true
            }) {
                Text("Excluir")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Excluir Filme"),
            message: Text("Tem certeza que deseja excluir este filme?"),
            primaryButton: .destructive(Text("Excluir")) {
                onDelete()
            },
            secondaryButton: .cancel()
              )
            }
            
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}




/*
import SwiftUI
import FirebaseFirestore

struct DetalhesView: View {
    @Binding var filmes: [Filme] // Lista compartilhada
    let db = Firestore.firestore() // Referência ao Firestore
    @State private var filmeSelecionado: Filme? // Filme selecionado para exibir os detalhes
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(filmes) { filme in
                    CardView(filme: filme, onOpen: {
                        filmeSelecionado = filme // Quando clicar, seleciona o filme
                    })
                }
                
                if let filme = filmeSelecionado {
                    // Exibe os detalhes do filme selecionado
                    VStack(alignment: .leading, spacing: 16) {
                        Text(filme.nomeFilme)
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Diretor: \(filme.nomeDiretor)")
                            .font(.title3)
                        
                        Text("Ano de Lançamento: \(filme.anoLancamento)")
                            .font(.title3)
                        
                        Text("Sinopse: \(filme.sinopseFilme)")
                            .font(.body)
                        
                        AsyncImage(url: URL(string: filme.urlImagem)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Button(action: {
                            excluirFilme(filme) // Exclui o filme
                        }) {
                            Text("Excluir Filme")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Filmes Cadastrados")
    }
    
    // Função para excluir filme
    func excluirFilme(_ filme: Filme) {
        db.collection("filmes").document(filme.id).delete { error in
            if let error = error {
                print("Erro ao excluir o filme do Firebase: \(error.localizedDescription)")
            } else {
                // Se a exclusão no Firebase for bem-sucedida, remove o filme da lista local
                filmes.removeAll { $0.id == filme.id }
                filmeSelecionado = nil // Reseta a seleção do filme
            }
        }
    }
}

import SwiftUI

struct CardView: View {
    let filme: Filme
    let onOpen: () -> Void // Callback para abrir os detalhes
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: filme.urlImagem)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            
            Text(filme.nomeFilme)
                .font(.headline)
            
            Text("Ano: \(filme.anoLancamento)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {
                onOpen() // Chama a função para abrir os detalhes do filme
            }) {
                Text("Abrir Filme")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}
*/
