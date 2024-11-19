//
//  CadastroView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 05/11/24.
//

// Felipe Almeida 22130 05/11/24

/*
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
    @Environment(\.presentationMode) var presentationMode

    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
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
                Button(action: {
                    salvarFilme()
                }) {
                    Text("Salvar Filme")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Confirmação de cadastro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .padding(.top, 10)
                
                // Botão de Voltar
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Voltar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                }
                .padding(.top, 10)
                
            }
            .navigationTitle("Cadastro de Filmes/Séries")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Cadastro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func salvarFilme() {
        // Validação dos campos
        guard !nomeFilme.isEmpty,
              !nomeDiretor.isEmpty,
              !sinopseFilme.isEmpty,
              !anoLancamento.isEmpty,
              !urlImagem.isEmpty else {
            alertMessage = "Por favor, preencha todos os campos antes de salvar."
            showAlert = true
            return
        }
        
        let filmeData: [String: Any] = [
            "nomeFilme": nomeFilme,
            "nomeDiretor": nomeDiretor,
            "sinopse": sinopseFilme,
            "anoLancamento": anoLancamento,
            "urlImagem": urlImagem
        ]
        
        // Simulação de salvamento e exibição da mensagem
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alertMessage = "Filme cadastrado com sucesso!"
                showAlert = true
            }

        // 1. Salvar no Firebase
        db.collection("filmes").addDocument(data: filmeData) { error in
            if let error = error {
                alertMessage = "Erro ao salvar no Firebase: \(error.localizedDescription)"
                showAlert = true
                return
            }
            
            // 2. Salvar na API
            salvarNaAPI(filmeData: filmeData)
        }
    }
    
    func salvarNaAPI(filmeData: [String: Any]) {
        guard let url = URL(string: "https://sua-api.com/filmes") else {
            alertMessage = "URL inválida para a API."
            showAlert = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: filmeData)
            request.httpBody = jsonData
        } catch {
            alertMessage = "Erro ao criar os dados para a API: \(error.localizedDescription)"
            showAlert = true
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Erro ao salvar na API: \(error.localizedDescription)"
                    showAlert = true
                } else {
                    alertMessage = "Filme cadastrado com sucesso!"
                    showAlert = true
                    // Limpar os campos após salvar
                    limparCampos()
                }
            }
        }.resume()
    }

    func limparCampos() {
        nomeFilme = ""
        nomeDiretor = ""
        sinopseFilme = ""
        anoLancamento = ""
        urlImagem = ""
    }
}

#Preview {
    CadastroView()
}
*/






/*
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
    
    @State private var filmeCriado: Filme? = nil // Filme para passar à tela de detalhes
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
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
                Button(action: {
                    salvarFilme()
                }) {
                    Text("Salvar Filme")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Cadastro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                // Botão para Detalhes (só aparece se o filme for criado)
                if let filmeCriado = filmeCriado {
                    NavigationLink(destination: DetalhesView(filme: filmeCriado)) {
                        Text("Ver Detalhes do Filme")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Cadastro de Filmes/Séries")
        }
    }
    
    func salvarFilme() {
        
        /*
        // Validação dos campos
        guard !nomeFilme.isEmpty,
              !nomeDiretor.isEmpty,
              !sinopseFilme.isEmpty,
              !anoLancamento.isEmpty,
              !urlImagem.isEmpty else {
            alertMessage = "Por favor, preencha todos os campos antes de salvar."
            showAlert = true
            return
        }
        
        let filmeData: [String: Any] = [
            "nomeFilme": nomeFilme,
            "nomeDiretor": nomeDiretor,
            "sinopse": sinopseFilme,
            "anoLancamento": anoLancamento,
            "urlImagem": urlImagem
        ]
        
        db.collection("filmes").addDocument(data: filmeData) { error in
            if let error = error {
                alertMessage = "Erro ao salvar no Firebase: \(error.localizedDescription)"
                showAlert = true
                return
            }
            
            // Criar o objeto Filme após o salvamento
            filmeCriado = Filme(
                id: UUID().uuidString, // Você pode substituir por um ID do Firestore
                nomeFilme: nomeFilme,
                nomeDiretor: nomeDiretor,
                sinopseFilme: sinopseFilme,
                anoLancamento: anoLancamento,
                urlImagem: urlImagem
            )
            
            alertMessage = "Filme cadastrado com sucesso!"
            showAlert = true
            
            // Limpar campos
            limparCampos()
        }
         */
        
        
        guard !nomeFilme.isEmpty,
                  !nomeDiretor.isEmpty,
                  !sinopseFilme.isEmpty,
                  !anoLancamento.isEmpty,
                  !urlImagem.isEmpty else {
                alertMessage = "Por favor, preencha todos os campos antes de salvar."
                showAlert = true
                return
            }
        
        let filmeData: [String: Any] = [
                "nomeFilme": nomeFilme,
                "nomeDiretor": nomeDiretor,
                "sinopse": sinopseFilme,
                "anoLancamento": anoLancamento,
                "urlImagem": urlImagem
            ]
        
        FirebaseManager.shared.saveData(collection: "filmes", document: UUID().uuidString, data: filmeData) { error in
                if let error = error {
                    alertMessage = "Erro ao salvar no Firestore: \(error.localizedDescription)"
                    showAlert = true
                } else {
                    filmeCriado = Filme(
                        id: UUID().uuidString,
                        nomeFilme: nomeFilme,
                        nomeDiretor: nomeDiretor,
                        sinopseFilme: sinopseFilme,
                        anoLancamento: anoLancamento,
                        urlImagem: urlImagem
                    )
                    alertMessage = "Filme cadastrado com sucesso!"
                    showAlert = true
                    limparCampos()
                }
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
*/



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
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Cadastro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Cadastro de Filmes/Séries")
    }
    
    func salvarFilme() {
        guard !nomeFilme.isEmpty, !nomeDiretor.isEmpty, !sinopseFilme.isEmpty, !anoLancamento.isEmpty, !urlImagem.isEmpty else {
            alertMessage = "Por favor, preencha todos os campos antes de salvar."
            showAlert = true
            return
        }
        
        let novoFilme = Filme(
            id: UUID().uuidString,
            nomeFilme: nomeFilme,
            nomeDiretor: nomeDiretor,
            sinopseFilme: sinopseFilme,
            anoLancamento: anoLancamento,
            urlImagem: urlImagem
        )
        
        filmes.append(novoFilme)
        alertMessage = "Filme cadastrado com sucesso!"
        showAlert = true
        limparCampos()
    }
    
    func limparCampos() {
        nomeFilme = ""
        nomeDiretor = ""
        sinopseFilme = ""
        anoLancamento = ""
        urlImagem = ""
    }
}

