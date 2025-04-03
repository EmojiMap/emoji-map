//
//  PlaceDetailsResponse.swift
//  emoji-map
//
//  Created by Enrique on 3/13/25.
//

import Foundation
import os.log

// Response structure for the place details API
struct PlaceDetailsResponse: Codable {
    let data: PlaceDetails
    let cacheHit: Bool
    let count: Int
    
    // Logger for debugging
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.emoji-map", category: "PlaceDetailsResponse")
    
    // Custom decoding to handle potential issues
    init(from decoder: Decoder) throws {
        Self.logger.notice("Starting to decode PlaceDetailsResponse")
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            data = try container.decode(PlaceDetails.self, forKey: .data)
            cacheHit = try container.decodeIfPresent(Bool.self, forKey: .cacheHit) ?? false
            count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        } catch {
            Self.logger.error("Error decoding PlaceDetailsResponse: \(error.localizedDescription)")
            throw error
        }
    }
}

// Structure for place details
struct PlaceDetails: Codable {
    let id: String
    let reviews: [Review]?
    let googleRating: Double?
    let priceLevel: Int?
    let userRatingCount: Int?
    let openNow: Bool?
    let name: String?
    let primaryTypeDisplayName: String?
    let takeout: Bool?
    let delivery: Bool?
    let dineIn: Bool?
    let editorialSummary: String?
    let outdoorSeating: Bool?
    let liveMusic: Bool?
    let menuForChildren: Bool?
    let servesDessert: Bool?
    let servesCoffee: Bool?
    let goodForChildren: Bool?
    let goodForGroups: Bool?
    let allowsDogs: Bool?
    let restroom: Bool?
    let acceptsCreditCards: Bool?
    let acceptsDebitCards: Bool?
    let acceptsCashOnly: Bool?
    let generativeSummary: String?
    let isFree: Bool?
    
    // Logger for debugging
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.emoji-map", category: "PlaceDetails")
    
    // Custom decoding to handle potential issues
    init(from decoder: Decoder) throws {
        Self.logger.notice("Starting to decode PlaceDetails")
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Required field with fallback
        id = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        
        // Optional fields
        do {
            reviews = try container.decodeIfPresent([Review].self, forKey: .reviews)
        } catch {
            Self.logger.error("Error decoding reviews: \(error.localizedDescription)")
            reviews = []
        }
        
        do {
            googleRating = try container.decodeIfPresent(Double.self, forKey: .googleRating)
        } catch {
            Self.logger.error("Error decoding rating: \(error.localizedDescription)")
            // Try to decode as Int and convert to Double if that works
            if let intRating = try? container.decodeIfPresent(Int.self, forKey: .googleRating) {
                googleRating = Double(intRating)
            } else {
                googleRating = nil
            }
        }
        
        do {
            priceLevel = try container.decodeIfPresent(Int.self, forKey: .priceLevel)
        } catch {
            Self.logger.error("Error decoding priceLevel: \(error.localizedDescription)")
            // Try to decode as String and convert to Int if that works
            if let stringPrice = try? container.decodeIfPresent(String.self, forKey: .priceLevel),
               let intPrice = Int(stringPrice) {
                priceLevel = intPrice
            } else {
                priceLevel = nil
            }
        }
        
        userRatingCount = try container.decodeIfPresent(Int.self, forKey: .userRatingCount)
        openNow = try container.decodeIfPresent(Bool.self, forKey: .openNow)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        primaryTypeDisplayName = try container.decodeIfPresent(String.self, forKey: .primaryTypeDisplayName)
        takeout = try container.decodeIfPresent(Bool.self, forKey: .takeout)
        delivery = try container.decodeIfPresent(Bool.self, forKey: .delivery)
        dineIn = try container.decodeIfPresent(Bool.self, forKey: .dineIn)
        editorialSummary = try container.decodeIfPresent(String.self, forKey: .editorialSummary)
        outdoorSeating = try container.decodeIfPresent(Bool.self, forKey: .outdoorSeating)
        liveMusic = try container.decodeIfPresent(Bool.self, forKey: .liveMusic)
        menuForChildren = try container.decodeIfPresent(Bool.self, forKey: .menuForChildren)
        servesDessert = try container.decodeIfPresent(Bool.self, forKey: .servesDessert)
        servesCoffee = try container.decodeIfPresent(Bool.self, forKey: .servesCoffee)
        goodForChildren = try container.decodeIfPresent(Bool.self, forKey: .goodForChildren)
        goodForGroups = try container.decodeIfPresent(Bool.self, forKey: .goodForGroups)
        allowsDogs = try container.decodeIfPresent(Bool.self, forKey: .allowsDogs)
        restroom = try container.decodeIfPresent(Bool.self, forKey: .restroom)
        acceptsCreditCards = try container.decodeIfPresent(Bool.self, forKey: .acceptsCreditCards)
        acceptsDebitCards = try container.decodeIfPresent(Bool.self, forKey: .acceptsDebitCards)
        acceptsCashOnly = try container.decodeIfPresent(Bool.self, forKey: .acceptsCashOnly)
        generativeSummary = try container.decodeIfPresent(String.self, forKey: .generativeSummary)
        isFree = try container.decodeIfPresent(Bool.self, forKey: .isFree)
    }
    
    // Review structure
    struct Review: Codable, Identifiable {
        let id: String
        let placeId: String
        let relativePublishTimeDescription: String
        let rating: Int
        let text: String
        
        // Logger for debugging
        private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.emoji-map", category: "Review")
        
        // Custom decoding to handle potential issues
        init(from decoder: Decoder) throws {
            Self.logger.notice("Starting to decode Review")
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Required fields
            id = try container.decode(String.self, forKey: .id)
            placeId = try container.decode(String.self, forKey: .placeId)
            relativePublishTimeDescription = try container.decode(String.self, forKey: .relativePublishTimeDescription)
            text = try container.decode(String.self, forKey: .text)
            
            // Handle rating with fallback
            do {
                rating = try container.decode(Int.self, forKey: .rating)
            } catch {
                Self.logger.error("Error decoding rating: \(error.localizedDescription)")
                // Try to decode as Double and convert to Int
                if let doubleRating = try? container.decode(Double.self, forKey: .rating) {
                    rating = Int(doubleRating)
                } else {
                    rating = 0
                }
            }
        }
        
        private enum CodingKeys: String, CodingKey {
            case id
            case placeId
            case relativePublishTimeDescription
            case rating
            case text
        }
        
        // Manual initializer for testing or creating reviews programmatically
        init(id: String, placeId: String, relativePublishTimeDescription: String, rating: Int, text: String) {
            self.id = id
            self.placeId = placeId
            self.relativePublishTimeDescription = relativePublishTimeDescription
            self.rating = rating
            self.text = text
        }
    }
} 
