//
//  CategoryMappings.swift
//  emoji-map
//
//  Created by Enrique on 3/10/25.
//

import Foundation

/// Category mapping for places
///
/// This map defines categories for places with associated emojis and keys.
/// Used for categorizing and displaying places on the map and in search results.
///
/// Each category has:
/// @property {Int} key - Unique identifier for the category
/// @property {String} emoji - Emoji representation of the category
struct CategoryMappings {
    // Mapping from emoji to key
    static let emojiToKey: [String: Int] = [
        "🍕": 1,
        "🍺": 2,
        "🍣": 3,
        "☕️": 4,
        "🍔": 5,
        "🌮": 6,
        "🍜": 7,
        "🥗": 8,
        "🍦": 9,
        "🍷": 10,
        "🍲": 11,
        "🥪": 12,
        "🍝": 13,
        "🥩": 14,
        "🍗": 15,
        "🍤": 16,
        "🍛": 17,
        "🥘": 18,
        "🍱": 19,
        "🥟": 20,
        "🧆": 21,
        "🥐": 22,
        "🍨": 23,
        "🍹": 24,
        "🍽️": 25
    ]
    
    // Mapping from key to emoji
    static let keyToEmoji: [Int: String] = [
        1: "🍕",
        2: "🍺",
        3: "🍣",
        4: "☕️",
        5: "🍔",
        6: "🌮",
        7: "🍜",
        8: "🥗",
        9: "🍦",
        10: "🍷",
        11: "🍲",
        12: "🥪",
        13: "🍝",
        14: "🥩",
        15: "🍗",
        16: "🍤",
        17: "🍛",
        18: "🥘",
        19: "🍱",
        20: "🥟",
        21: "🧆",
        22: "🥐",
        23: "🍨",
        24: "🍹",
        25: "🍽️"
    ]
    
    /// Get all available emoji keys
    static var allEmojis: [String] {
        return Array(emojiToKey.keys)
    }
    
    /// Get the key for a given emoji
    static func getKeyForEmoji(_ emoji: String) -> Int? {
        return emojiToKey[emoji]
    }
    
    /// Get the emoji for a given key
    static func getEmojiForKey(_ key: Int) -> String? {
        return keyToEmoji[key]
    }
} 