//
//  OkashiData.swift
//  MyOkashi1
//
//  Created by MsMacM on 2025/03/09.
//

import SwiftUI
//identifiableプロトコルを利用してお菓子の情報をまとめる構造体
struct OkashiItem: Identifiable {
    var id = UUID()
    let name: String
    let link: URL
    let image: URL
}
@Observable class OkashiData {
//    JSONのデータ構造
    struct ResultJson: Codable {
        struct Item: Codable {
            let name: String?
            let url: URL?
            let image: URL?
        }
        let item: [Item]?
    }
//お菓子のリスト
    var okashiList: [OkashiItem] = []

    func searchOkashi(keyword: String) {
        print("searchOkashiメソッドで受け取った値は \(keyword)")
        Task {
            await search(keyword: keyword)
        }
    }
    @MainActor
    private func search(keyword: String) async {
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        }
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        print(req_url)
        do {
            //            リクエストURLからダウンロード
            let (data, _) = try await URLSession.shared.data(from: req_url)
            //            JsonDecoderのインスタンス取得
            let decoder = JSONDecoder()
            //            受け取ったJSONデータを格納
            let json = try decoder.decode(ResultJson.self, from: data)
            //            print(json)
            guard let items = json.item else { return }
            okashiList.removeAll()
            for item in items {
                if let name = item.name,
                   let link = item.url,
                   let image = item.image {
                    let  okashi = OkashiItem(name: name,  link: link,  image: image)
                    okashiList.append(okashi)
                }
            }
        } catch {
            print("エラーです。\(error)")
        }
    }
}
