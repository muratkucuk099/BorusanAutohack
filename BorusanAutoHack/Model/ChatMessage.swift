//
//  ChatMessage.swift
//  BorusanAutoHack
//
//  Created by Mac on 10.12.2023.
//

import Foundation

struct ChatMessage: Identifiable {
    var id = UUID()
    var message: String
    var isUser: Bool
}
