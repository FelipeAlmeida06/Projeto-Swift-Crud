//
//  DetalhesView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 18/11/24.
//

/*
import SwiftUI

struct DetalhesView: View {
    @Binding var filmes: [Filme] // Lista compartilhada
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(filmes) { filme in
                    CardView(filme: filme, onDelete: {
                        excluirFilme(filme)
                    })
                }
            }
            .padding()
        }
        .navigationTitle("Filmes Cadastrados")
    }
    
    func excluirFilme(_ filme: Filme) {
        filmes.removeAll { $0.id == filme.id }
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
*/






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
    
    let db = Firestore.firestore()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(filmes) { filme in
                    CardView(filme: filme, onDelete: {
                        excluirFilme(filme)
                    })
                }
            }
            .padding()
        }
        .navigationTitle("Filmes Cadastrados")
    }
    
    func excluirFilme(_ filme: Filme) {
        // Excluir do Firebase
        db.collection("filmes").document(filme.id).delete { error in
            if let error = error {
                print("Erro ao excluir o filme do Firebase: \(error.localizedDescription)")
            } else {
                // Excluir da lista local
                filmes.removeAll { $0.id == filme.id }
            }
        }
    }
}

struct CardView: View {
    let filme: Filme
    let onDelete: () -> Void
    
    @State private var showAlert = false
    
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
                    .frame(maxWidth: .infinity)
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
*/
