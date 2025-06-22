//
//----------------------------------------------
// Original project: EmojiPicker
// by  Stewart Lynch on 2025-06-18
//
// Follow me on Mastodon: https://iosdev.space/@StewartLynch
// Follow me on Threads: https://www.threads.net/@stewartlynch
// Follow me on Bluesky: https://bsky.app/profile/stewartlynch.bsky.social
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Email: slynch@createchsol.com
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2025 CreaTECH Solutions. All rights reserved.

import SwiftUI



@Observable
public class EmojiManager {
    var emojis: [Emoji] = []
    
   public init() {
        loadEmojis()
    }
    
    private func loadEmojis() {
        guard let url = Bundle.module.url(forResource: "Emoji", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Emoji].self, from: data) else {
            print("Failed to load emojis.")
            return
        }
        emojis = decoded
    }
    func availableCategories(limitedCategories: [CategoryEnum]) -> [String] {
        let allCategories = CategoryEnum.allCases.map { $0.rawValue}
        let allowedCategories = Set(limitedCategories.map { $0.rawValue })
        return limitedCategories.isEmpty ? allCategories : allCategories.filter({allowedCategories.contains($0)})
    }
}
