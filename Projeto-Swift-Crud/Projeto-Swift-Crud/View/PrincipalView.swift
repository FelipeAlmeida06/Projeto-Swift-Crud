//
//  PrincipalView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 18/11/24.
//


import SwiftUI
import FirebaseFirestore

struct PrincipalView: View {
    
    @State private var filmes: [Filme] = []
    @State private var selecionarFilme: Filme? = nil
    @State private var isMostrarDetalhes = false
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            VStack {
                // Lista de filmes com imagem e dois textos
                if filmes.isEmpty {
                    Text("Nenhum filme foi cadastrado.")
                        .padding()
                } else {
                    List(filmes) { filme in HStack {
                        if let urlImagem = URL(string: filme.urlImagem) {
                            AsyncImage(url: urlImagem) {
                                image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(filme.nomeFilme)
                                .font(.headline)
                            Text(filme.nomeDiretor)
                                .font(.subheadline)
                        }
                    }
                    .onTapGesture {
                        selecionarFilme = filme
                        isMostrarDetalhes = true
                    }
                    }
                }
            }
            .navigationTitle("Filmes Cadastrados")
            .onAppear {
                carregarFilmes()
            }
        }
    }
    
    func carregarFilmes() {
        db.collection("filmes").getDocuments { snapshot, error in
                    if let error = error {
                        print("Erro ao buscar filmes: \(error.localizedDescription)")
                    } else {
                        filmes = snapshot?.documents.compactMap { document -> Filme? in
                            let data = document.data()
                            guard let nomeFilme = data["nomeFilme"] as? String,
                                  let nomeDiretor = data["nomeDiretor"] as? String,
                                  let sinopseFilme = data["sinopseFilme"] as? String,
                                  let anoLancamento = data["anoLancamento"] as? String,
                                  let urlImagem = data["urlImagem"] as? String else {
                                return nil
                            }
                            return Filme(id: document.documentID, nomeFilme: nomeFilme, nomeDiretor: nomeDiretor, sinopseFilme: sinopseFilme, anoLancamento: anoLancamento, urlImagem: urlImagem)
                        } ?? []
                    }
                }
    }
}


/*
struct PrincipalView: View {
    @State private var filmes: [Filme] = []
    @State private var filmeSelecionado: Filme? = nil
    @State private var isMostrarEdicao = false
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            VStack {
                // Lista de filmes com imagem e dois textos
                if filmes.isEmpty {
                    Text("Nenhum filme foi cadastrado.")
                        .padding()
                } else {
                    List(filmes) { filme in
                        HStack {
                            if let urlImagem = URL(string: filme.urlImagem) {
                                AsyncImage(url: urlImagem) {
                                    image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 150)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text(filme.nomeFilme)
                                    .font(.headline)
                                Text(filme.nomeDiretor)
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            // Botão para editar filme
                            NavigationLink(destination: EditarView(filme: filme, filmes: $filmes)) {
                                Text("Abrir Filme")
                                    .foregroundColor(.blue)
                                    .padding(.trailing)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filmes Cadastrados")
            .onAppear {
                carregarFilmes()
            }
        }
    }
    
    func carregarFilmes() {
        db.collection("filmes").getDocuments { snapshot, error in
            if let error = error {
                print("Erro ao buscar filmes: \(error.localizedDescription)")
            } else {
                filmes = snapshot?.documents.compactMap { document -> Filme? in
                    let data = document.data()
                    guard let nomeFilme = data["nomeFilme"] as? String,
                          let nomeDiretor = data["nomeDiretor"] as? String,
                          let sinopseFilme = data["sinopseFilme"] as? String,
                          let anoLancamento = data["anoLancamento"] as? String,
                          let urlImagem = data["urlImagem"] as? String else {
                        return nil
                    }
                    return Filme(id: document.documentID, nomeFilme: nomeFilme, nomeDiretor: nomeDiretor, sinopseFilme: sinopseFilme, anoLancamento: anoLancamento, urlImagem: urlImagem)
                } ?? []
            }
        }
    }
}
 */

struct Filme: Identifiable {
    var id: String
    var nomeFilme: String
    var nomeDiretor: String
    var sinopseFilme: String
    var anoLancamento: String
    var urlImagem: String
}

struct PrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalView()
    }
}

#Preview {
    PrincipalView()
}
