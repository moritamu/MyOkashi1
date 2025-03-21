//
//  OkashiData.swift
//  MyOkashi1
//
//  Created by MsMacM on 2025/03/09.
//

import SwiftUI

@Observable class OkashiData {
//    JSONのデータ構造
    struct ResultJson: Codable {
        struct Item: Codable {
            let name: String?
            let url: URL?
            let image: URL?
        }
        let items: [Item]?
    }
    func searchOkashi(keyword: String) {
        print("searchOkashiメソッドで受け取った値は \(keyword)")
        Task {
            await search(keyword: keyword)
        }
    }
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
            print(json)
        } catch {
            print("エラーです。\(error)")
        }
    }
}
