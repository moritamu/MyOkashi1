//
//  ContentView.swift
//  MyOkashi1
//
//  Created by MsMacM on 2025/03/09.
//

import SwiftUI

struct ContentView: View {
    //    OkashiDataのインスタンス作成　OkashiDataを参照する変数
    var okashiDataList = OkashiData()
    @State var inputText = ""
    @State var isShowSafari: Bool = false

    var body: some View {
        VStack {
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    //                    入力が確定した時に実行される
                    okashiDataList.searchOkashi(keyword: inputText)
                }
                .submitLabel(.search)
            //            キーボードに検索ボタンが表示される
                .padding()
            //            リスト表示する
            List(okashiDataList.okashiList) { okashi in
                Button{
                    okashiDataList.okashiLink = okashi.link
                    isShowSafari.toggle()
                } label: {
                    HStack {
                        AsyncImage(url: okashi.image) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    }
                }
            }
            .sheet(isPresented: $isShowSafari, content: {
                SafariView(url: okashiDataList.okashiLink!)
                    .ignoresSafeArea(edges:[.bottom])
            })
        }
    }
}


#Preview {
    ContentView()
}
