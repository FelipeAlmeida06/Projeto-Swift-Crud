//
//  CadastroView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 05/11/24.
//

// Felipe Almeida 22130 05/11/24


import SwiftUI
import FirebaseFirestore

struct CadastroView: View {
    //var body: some View {
    //    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    //}
    
    @State private var nomeFilme: String = ""
    @State private var nomeDiretor: String = ""
    @State private var sinopseFilme: String = ""
    @State private var anoLancamento: String = ""
    @State private var urlImagem: String = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            Form {
                //Informaçoes do Filme
                Section(header: Text("Insira as Informacoes")) {
                    TextField("Nome", text: $nomeFilme)
                    TextField("Nome do Diretor", text: $nomeDiretor)
                    TextField("Sinopse", text: $sinopseFilme)
                    TextField("Ano de Lancamento", text: $anoLancamento)
                    TextField("Url da Imagem", text: $urlImagem)
                }
                
                Button(action: {
                    salvarNoFirebase()
                }) {
                    Text("Salvar Filme")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Cadastro de Filme")
            .padding()
        }
    }
    
    // salvarFilme()
    func salvarNoFirebase() {
            // Verifica se todos os campos estão preenchidos
            guard !nomeFilme.isEmpty, !nomeDiretor.isEmpty, !sinopseFilme.isEmpty, !anoLancamento.isEmpty, !urlImagem.isEmpty else {
                print("Por favor, preencha todos os campos.")
                return
            }
            
            // Cria um dicionário com os dados do filme
            let filmeData: [String: Any] = [
                "nomeFilme": nomeFilme,
                "nomeDiretor": nomeDiretor,
                "sinopse": sinopseFilme,
                "anoLancamento": anoLancamento,
                "urlImagem": urlImagem
            ]
            
            // Salva os dados no Firestore
            db.collection("filmes").addDocument(data: filmeData) { error in
                if let error = error {
                    print("Erro ao salvar filme: \(error)")
                } else {
                    print("Filme salvo com sucesso!")
                    // Limpa os campos após salvar
                    nomeFilme = ""
                    nomeDiretor = ""
                    sinopseFilme = ""
                    anoLancamento = ""
                    urlImagem = ""
                }
            }
        }
}

#Preview {
    CadastroView()
}
