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

public struct EmojiPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var manager = EmojiManager()
    
    @Binding var selectedEmoji: String
    let limitedCategories: [CategoryEnum]
    let searchTerm: String
    let withDismiss: Bool
    @State private var selectedCategory: String
    @State private var searchText: String = ""
    
    public init(
    selectedEmoji: Binding<String>,
    limitedCategories: [CategoryEnum] = [],
    searchTerm: String = "",
    withDismiss: Bool = true
    ) {
        self._selectedEmoji = selectedEmoji
        self.limitedCategories = limitedCategories
        self.searchTerm = searchTerm
        let initialCategory = limitedCategories.count == 1 ? limitedCategories.first!.rawValue : "All Categories"
        self._selectedCategory = State(initialValue: initialCategory)
        self._searchText = State(initialValue: searchTerm)
        self.withDismiss = withDismiss
    }
    
    var availableCategories: [String] {
        manager.availableCategories(limitedCategories: limitedCategories)
    }
    public var body: some View {
        var filteredEmoji: [Emoji] {
            manager.emojis
                .filter { emoji in
                    if !limitedCategories.isEmpty {
                        let allowedCategories = Set(limitedCategories.map { $0.rawValue })
                        return allowedCategories.contains(emoji.category)
                    }
                    return true
                }
                .filter { emoji in
                    selectedCategory == "All Categories" ||
                    emoji.category == selectedCategory
                }
                .filter { emoji in
                    searchText.isEmpty ||
                    emoji.description.localizedCaseInsensitiveContains(searchText) ||
                    emoji.tags.contains {
                        $0.localizedStandardContains(searchText)
                    }
                }
        }
        let columns = [GridItem(.adaptive(minimum: 50))]
            VStack(alignment: .leading) {
                if !(limitedCategories.count == 1 || !searchTerm.isEmpty) {
                    Picker("Category", selection: $selectedCategory) {
                        Text("All Categories").tag("All Categories")
                        ForEach(availableCategories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    .buttonStyle(.bordered)
                }
                if searchTerm.isEmpty {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        TextField("Search...", text: $searchText)
                        #if os(iOS)
                            .autocapitalization(.none)
                            .textFieldStyle(.plain)
                        #endif
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(6)
                    .background {
                        #if os(iOS)
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(.secondarySystemBackground))
                        #else
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(.quaternaryLabelColor))
                        #endif
                    }
                }
            }
            .padding()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredEmoji) { emoji in
                        Button {
                            selectedEmoji = emoji.emoji
                            if withDismiss {
                                dismiss()
                            }
                        } label: {
                            Text(emoji.emoji)
                                .font(.largeTitle)
                        }
                        .buttonStyle(.plain)
                        .padding(8)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(emoji.emoji == selectedEmoji ? Color(.secondarySystemFill) : .clear)
                        }
                    }
                }
                .padding()
            }
            .padding(.horizontal)
    }
}

#Preview("All Categories") {
    @Previewable @State var selectedEmoji = "😀"
    EmojiPickerView(selectedEmoji: $selectedEmoji)
}
#Preview("Single Category") {
    @Previewable @State var selectedEmoji = "🇨🇦"
    EmojiPickerView(selectedEmoji: $selectedEmoji, limitedCategories: [.flags])
}

#Preview("Mixed Categories") {
    @Previewable @State var selectedEmoji = "👓"
    EmojiPickerView(selectedEmoji: $selectedEmoji, limitedCategories: [.symbols, .objects])
}

#Preview("Search Term") {
    @Previewable @State var selectedEmoji = "❤️"
    EmojiPickerView(selectedEmoji: $selectedEmoji, searchTerm: "love")
}

