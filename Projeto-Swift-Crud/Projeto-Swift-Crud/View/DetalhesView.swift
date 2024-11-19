//
//  DetalhesView.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 18/11/24.
//

import SwiftUI

struct DetalhesView: View {
    var filme: Filme?
    
    var body: some View {
        VStack {
            if let filme = filme {
                // 5 atributos do filme
                AsyncImage(url: URL(string: filme.urlImagem)) {
                    image in
                    image.resizable()
                        .scaledToFill()
                        .frame( height: 250)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                
                Text(filme.nomeFilme)   // nome filme
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                
                Text(filme.nomeDiretor)  // nome diretor
                    .font(.title2)
                    .padding(.top)
                
                Text(filme.anoLancamento)  // ano filme
                    .font(.title3)
                    .padding(.top)
                
                Spacer()
                
                // botão para voltar para a tela principal
                NavigationLink(destination: PrincipalView(), label: {
                    Text("Voltar para a Tela Principal")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .padding(.bottom)
            } else {
                Text("Erro ao carregar os detalhes.")
            }
            
            NavigationLink(destination: CadastroView(), label: {
                Text("Voltar para a tela Cadastro")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            .padding(.bottom)
            /*
            else {
                Text("Erro ao carregar os detalhes.")
            }
             */
        }
        .padding()
        .navigationTitle("Detalhes do Filme")
        
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetalhesView_Previews: PreviewProvider {
    static var previews: some View {
        DetalhesView(filme: Filme(id: "1", nomeFilme: "Filme Exemplo", nomeDiretor: "Diretor Exemplo", sinopseFilme: "Sinopse Exemplo", anoLancamento: "2024", urlImagem: ""))
    }
}

#Preview {
    DetalhesView()
}
