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
    @State private var nomeFilme: String = ""
    @State private var nomeDiretor: String = ""
    @State private var sinopseFilme: String = ""
    @State private var anoLancamento: String = ""
    @State private var urlImagem: String = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var filmes: [Filme] // Lista compartilhada entre as telas

    let db = Firestore.firestore()
    
    var body: some View {
        Form {
            // Informações do Filme
            Section(header: Text("Insira as Informações")) {
                TextField("Nome do Filme/Série", text: $nomeFilme)
                TextField("Nome do Diretor", text: $nomeDiretor)
                TextField("Sinopse", text: $sinopseFilme)
                TextField("Ano de Lançamento", text: $anoLancamento)
                    .keyboardType(.numberPad)
                TextField("URL da Imagem", text: $urlImagem)
                    .keyboardType(.URL)
            }
            
            // Botão de Salvar
            Button(action: salvarFilme) {
                Text("Salvar Filme")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)   // blue
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Cadastro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            // Botão de Detalhes
                        NavigationLink(destination: DetalhesView(filmes: $filmes)) {
                            Text("Detalhes")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
        }
        .navigationTitle("Cadastro de Filmes")
    }
    
    func salvarFilme() {
        guard !nomeFilme.isEmpty, !nomeDiretor.isEmpty, !sinopseFilme.isEmpty, !anoLancamento.isEmpty, !urlImagem.isEmpty else {
            alertMessage = "Por favor, preencha todos os campos antes de salvar."
            showAlert = true
            return
        }
        
        let novoFilme: [String: Any] = [
            "nomeFilme": nomeFilme,
            "nomeDiretor": nomeDiretor,
            "sinopseFilme": sinopseFilme,
            "anoLancamento": anoLancamento,
            "urlImagem": urlImagem,
            "criadoEm": Timestamp()
        ]
        
        db.collection("filmes").addDocument(data: novoFilme) { error in
            if let error = error {
                alertMessage = "Erro ao salvar: \(error.localizedDescription)"
            } else {
                alertMessage = "Filme cadastrado com sucesso!"
                // O Firebase Firestore não retorna o documentId através do erro
                // Em vez disso, usamos a referência ao documento retornada
                let documentId = db.collection("filmes").document().documentID  // Capturando o ID correto
                
                filmes.append(Filme(
                    id: documentId,  // Usando o ID gerado pelo Firebase
                    nomeFilme: nomeFilme,
                    nomeDiretor: nomeDiretor,
                    sinopseFilme: sinopseFilme,
                    anoLancamento: anoLancamento,
                    urlImagem: urlImagem
                ))
                
                limparCampos()
            }
            showAlert = true
        }
    }

    func limparCampos() {
        nomeFilme = ""
        nomeDiretor = ""
        sinopseFilme = ""
        anoLancamento = ""
        urlImagem = ""
    }
}
