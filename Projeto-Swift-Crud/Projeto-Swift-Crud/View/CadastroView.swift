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
                Section(header: Text("Informaçoes do Filme")) {
                    TextField("Nome", text: $nomeFilme)
                    TextField("Nome do Diretor", text: $nomeDiretor)
                    TextField("Sinopse", text: $sinopseFilme)
                    TextField("Ano de Lancamento", text: $anoLancamento)
                    TextField("Url da Imagem", text: $urlImagem)
                }
            }
        }
    }
}

#Preview {
    CadastroView()
}
