//
//  EditarView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 22/11/24.
//

/*                                      AQUI SERÁ EDITADO AS INFORMAÇOES DOS FILMES
import SwiftUI
import FirebaseFirestore

struct EditarView: View {
    @Binding var filmes: [Filme] // Lista compartilhada
    @State private var filme: Filme
    @State private var nomeFilme: String
    @State private var nomeDiretor: String
    @State private var sinopseFilme: String
    @State private var anoLancamento: String
    @State private var urlImagem: String
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    init(filme: Filme, filmes: Binding<[Filme]>) {
        _filmes = filmes
        _filme = State(initialValue: filme)
        _nomeFilme = State(initialValue: filme.nomeFilme)
        _nomeDiretor = State(initialValue: filme.nomeDiretor)
        _sinopseFilme = State(initialValue: filme.sinopseFilme)
        _anoLancamento = State(initialValue: filme.anoLancamento)
        _urlImagem = State(initialValue: filme.urlImagem)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Informações do Filme")) {
                TextField("Nome do Filme", text: $nomeFilme)
                TextField("Nome do Diretor", text: $nomeDiretor)
                TextField("Sinopse", text: $sinopseFilme)
                TextField("Ano de Lançamento", text: $anoLancamento)
                    .keyboardType(.numberPad)
                TextField("URL da Imagem", text: $urlImagem)
                    .keyboardType(.URL)
            }
            
            // Botão de Atualizar
            Button(action: atualizarFilme) {
                Text("Atualizar Dados")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Atualização"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Editar Filme")
    }
    
    func atualizarFilme() {
        guard !nomeFilme.isEmpty, !nomeDiretor.isEmpty, !sinopseFilme.isEmpty, !anoLancamento.isEmpty, !urlImagem.isEmpty else {
            alertMessage = "Por favor, preencha todos os campos antes de salvar."
            showAlert = true
            return
        }
        
        let dadosAtualizados: [String: Any] = [
            "nomeFilme": nomeFilme,
            "nomeDiretor": nomeDiretor,
            "sinopseFilme": sinopseFilme,
            "anoLancamento": anoLancamento,
            "urlImagem": urlImagem
        ]
        
        // Atualizando no Firebase Firestore
        db.collection("filmes").document(filme.id).updateData(dadosAtualizados) { error in
            if let error = error {
                alertMessage = "Erro ao atualizar: \(error.localizedDescription)"
            } else {
                // Atualizando a lista local de filmes
                if let index = filmes.firstIndex(where: { $0.id == filme.id }) {
                    filmes[index] = Filme(id: filme.id, nomeFilme: nomeFilme, nomeDiretor: nomeDiretor, sinopseFilme: sinopseFilme, anoLancamento: anoLancamento, urlImagem: urlImagem)
                }
                alertMessage = "Filme atualizado com sucesso!"
            }
            showAlert = true
        }
    }
}
*/
