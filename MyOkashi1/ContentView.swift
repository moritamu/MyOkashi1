//
//  ContentView.swift
//  MyOkashi1
//
//  Created by MsMacM on 2025/03/09.
//

import SwiftUI

struct ContentView: View {
//    OkashiDataのインスタンス作成
    var okashiDataList = OkashiData()
    @State var inputText = ""
    
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
        }
    }
}

#Preview {
    ContentView()
}
