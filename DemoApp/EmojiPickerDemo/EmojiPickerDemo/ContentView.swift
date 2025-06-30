//
//----------------------------------------------
// Original project: EmojiPickerDemo
// by  Stewart Lynch on 2025-06-22
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
import EmojiPicker

struct ContentView: View {
    @State private var allCategories = "😀"
    @State private var singleCategory = "🇨🇦"
    @State private var mixedCategories = "👓"
    @State private var searchTerm = "❤️"
    // Presentation Triggers
    @State private var showAll = false
    @State private var showSingle = false
    @State private var showMixed = false
    @State private var showSearchTerm = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text(
"""
EmojiPickerView(
   selectedEmoji: $allCategories
)
"""
                        )
                        .font(.system(size: 12))
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundStyle(.secondary)
                        Button {
                            showAll = true
                        } label: {
                            Text(allCategories)
                        }
                        .font(.largeTitle)
                        .buttonStyle(.plain)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .sheet(isPresented: $showAll) {
                            EmojiPickerView(
                               selectedEmoji: $allCategories
                            )
                        }
                    }
                } header: {
                    Text("All Categories Available")
                }
                Section {
                    HStack{
                        Text(
"""
EmojiPickerView(
    selectedEmoji: $singleCategory,
    limitedCategories: [.flags]
)
""")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                        Button {
                            showSingle = true
                        } label: {
                            Text(singleCategory)
                        }
                        .font(.largeTitle)
                        .buttonStyle(.plain)
                        .popover(isPresented: $showSingle) {
                            EmojiPickerView(
                                selectedEmoji: $singleCategory,
                                limitedCategories: [.flags]
                            )
                            .frame(width: 300, height: 300)
                            .presentationCompactAdaptation(.popover)
                        }
                    }
                } header: {
                    Text("Single Category Available")
                }
                Section {
                    HStack{
                        Text(
"""
EmojiPickerView(
    selectedEmoji: $mixedCategories,
    limitedCategories: [.symbols, .objects]
)
""")
                        .font(.system(size: 10))
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                        Button {
                            showMixed = true
                        } label: {
                            Text(mixedCategories)
                        }
                        .font(.largeTitle)
                        .buttonStyle(.plain)
                        .sheet(isPresented: $showMixed) {
                            EmojiPickerView(
                                selectedEmoji: $mixedCategories,
                                limitedCategories: [.symbols, .objects]
                            )
                            .presentationDetents([.medium])
                        }
                    }
                } header: {
                    Text("Multiple Categories Only")
                }
                Section {
                    HStack{
                        Text(
"""
EmojiPickerView(
    selectedEmoji: $searchTerm,
    searchTerm: "love"
)
""")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                        Button {
                            showSearchTerm = true
                        } label: {
                            Text(searchTerm)
                        }
                        .font(.largeTitle)
                        .buttonStyle(.plain)
                        .popover(isPresented: $showSearchTerm) {
                            EmojiPickerView(
                                selectedEmoji: $searchTerm,
                                searchTerm: "love"
                            )
                            .frame(width: 300, height: 300)
                            .presentationCompactAdaptation(.popover)
                        }
                    }
                } header: {
                    Text("Search Term only")
                }
            }
            .navigationTitle("Emoji Picker")
        }
    }
}

#Preview {
    ContentView()
}
