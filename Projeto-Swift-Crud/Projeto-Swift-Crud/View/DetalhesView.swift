//
//  DetalhesView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 18/11/24.
//


// Felipe Antônio de Oliveira Almeida
// 22130
import SwiftUI
import FirebaseFirestore

struct DetalhesView: View {
    @Binding var filmes: [Filme] // Lista compartilhada
    let db = Firestore.firestore() // Referência ao Firestore
    
    // pesquisa
    @State private var searchText: String = "" // Estado para o texto de busca
    
    var body: some View {
    
        NavigationView {
                VStack(spacing: 8) { // Reduza o espaçamento geral
                    // Título manual no lugar do `navigationTitle`
                    Text("Filmes Cadastrados")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 16) // Ajuste para controle do espaçamento superior
                    
                    // Campo de Busca
                    HStack {
                        Image(systemName: "magnifyingglass") // Ícone de lupa
                            .foregroundColor(.gray)
                        TextField("Buscar filmes", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                    }
                    .padding([.leading, .trailing], 16) // Margem horizontal
                    .padding(.bottom, 8) // Margem entre campo de busca e próximo elemento
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(filmes.filter { searchText.isEmpty || $0.nomeFilme.localizedCaseInsensitiveContains(searchText) }) { filme in
                                CardView(filme: filme, onDelete: {
                                    excluirFilme(filme)
                                })
                            }
                        }
                        .padding()
                    }
                    
                    // Botão Cadastrar
                    NavigationLink(destination: CadastroView(filmes: $filmes)) {
                        Text("Cadastrar")
                            .frame(width: 120, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.trailing, 16) // Espaçamento à direita
                            .padding(.bottom, 16)  // Espaçamento inferior
                    }
                }
                .toolbar(.hidden) // Remove o espaço extra da barra de navegação
            }
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
