# EmojiPicker

`EmojiPicker` is a Swift Package that provides a customizable UI component for browsing and selecting emojis. This package includes access to emoji metadata and offers flexible presentation options for emoji pickers.

## 📦 Installation

You can add `EmojiPicker` to your project using [Swift Package Manager](https://swift.org/package-manager/).

### In Xcode:

1. Open your project.
2. Go to **File > Add Packages…**
3. Enter the package URL:
   ```
   https://github.com/StewartLynch/EmojiPicker
   ```
4. Select the version range you want to use (recommend "Up to Next Major").
5. Import `EmojiPicker` in the files where you need it:
   ```swift
   import EmojiPicker
   ```

---

## 🧩 Features

- ✅ Access hundres of emojis across multiple categories.
- ✅ Filter emojis by category or custom arrays of categories.
- ✅ Present the picker as a modal sheet or popover.
- ✅ Includes built-in search for emojis by name, search term or category.
- ✅ Customize behavior to match your UI needs.

---

## 🚀 Usage

Here's a quick example of how to use `EmojiPicker`:

### Presenting the Emoji Picker

```swift
import EmojiPicker

@State private var allCategoriesEmoji = "😀" // Emoji to update
@State private var showPicker = false

var body: some View {
    VStack {
        Button("Pick an Emoji") {
            showPicker = true
        }
    }
    .sheet(isPresented: $showPicker) {
        EmojiPicker(
            selectedEmoji: $allCategoriesEmoji
        )
    }
}
```

### Customizing Categories

You can restrict the emojis shown using  specific category filters:

```swift
EmojiPicker(
    selectedEmoji: $mixedCategoriesEmoji,
    limitedCategories: [.foodAndDrink, .smileyAndEmotion]
)
```

Or use just one specific category:

```swift
EmojiPicker(
    selectedEmoji: $singleCategoryEmoji,
    limitedCategories: [.activities]
)
```

### Search Terms

Or provide your own search term and pass that in as a String:

```swift
EmojiPicker(
    selectedEmoji: $searchTermEmoji,
    searchTerm: "love"
)
```

### Presenting as a Popover

Instead of a sheet presentation, you may wish to present the picker as a popover.

On iOS this requires the `.presentationCompactAdaptation(.popover)` modifier

```swift
.popover(isPresented: $showSingle) {
    EmojiPicker(
        selectedEmoji: $singleCategoryEmoji,
        limitedCategories: [.objects]
    )
    .frame(width: 300, height: 300)
    .presentationCompactAdaptation(.popover)
}
```

---

## 🔍 Requirements

- iOS 18+, iPadOS 18+, macOS 15+
- Xcode 16+
- Swift 5.10+

---

## 📁 Included Resources

This package includes the following resources:

- `Emoji.json`

These are decoded internally to provide metadata and search capability for all emojis.

---

## 📄 License

This project is licensed under the MIT License.

---


