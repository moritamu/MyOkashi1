//
//  OkashiData.swift
//  MyOkashi1
//
//  Created by MsMacM on 2025/03/09.
//

import SwiftUI

@Observable class OkashiData {
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
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=quest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
    }
}
