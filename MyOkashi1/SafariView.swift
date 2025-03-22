//
//  SafariView.swift
//  MyOkashi1
//
//  Created by MsMacM on 2025/03/22.
//

import SwiftUI
import SafariServices

//SFSafariViewControllerを起動する構造体
struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }

}

