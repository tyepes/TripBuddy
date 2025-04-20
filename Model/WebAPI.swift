//
//  WebAPI.swift
//  Phase1
//
//  Created by Tommy Yepes on 4/19/25.
//
import Foundation

struct PlacesResponse: Decodable {
    let htmlAttributions: [String]
    let results: [Place]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case htmlAttributions = "html_attributions"
        case results
        case status
    }
}

struct Place: Decodable, Identifiable {
    let id = UUID()
    let businessStatus: String?
    let geometry: Geometry
    let icon: String?
    let iconBackgroundColor: String?
    let iconMaskBaseUri: String?
    let name: String
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let placeId: String
    let plusCode: PlusCode?
    let priceLevel: Int?
    let rating: Double?
    let reference: String
    let scope: String?
    let types: [String]
    let userRatingsTotal: Int?
    let vicinity: String?
    
    enum CodingKeys: String, CodingKey {
        case businessStatus = "business_status"
        case geometry
        case icon
        case iconBackgroundColor = "icon_background_color"
        case iconMaskBaseUri = "icon_mask_base_uri"
        case name
        case openingHours = "opening_hours"
        case photos
        case placeId = "place_id"
        case plusCode = "plus_code"
        case priceLevel = "price_level"
        case rating
        case reference
        case scope
        case types
        case userRatingsTotal = "user_ratings_total"
        case vicinity
    }
}

struct Geometry: Decodable {
    let location: Location
    let viewport: Viewport
}

struct Location: Decodable {
    let lat: Double
    let lng: Double
}

struct Viewport: Decodable {
    let northeast: Location
    let southwest: Location
}

struct OpeningHours: Decodable {
    let openNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

struct Photo: Decodable {
    let height: Int
    let htmlAttributions: [String]
    let photoReference: String
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
        case width
    }
}

struct PlusCode: Decodable {
    let compoundCode: String
    let globalCode: String
    
    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}
