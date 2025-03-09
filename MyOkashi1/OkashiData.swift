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
        print("searchメソッドで受け取った値は \(keyword)")
    }
}
