//
//  StoreModel.swift
//  PruebaLiverpool
//
//  Created by Osvaldo Salas Palomo on 10/02/23.
//

import Foundation

// MARK: - StoreModel
struct StoreModel: Codable {
    let status: Status
    let pageType: String
    let plpResults: PlpResults
}

// MARK: - PlpResults
struct PlpResults: Codable {
    let label: String
    let plpState: PlpState
    let sortOptions: [SortOption]
    let refinementGroups: [RefinementGroup]
    let records: [Record]
    let navigation: Navigation
    let customURLParam: CustomURLParam

    enum CodingKeys: String, CodingKey {
        case label, plpState, sortOptions, refinementGroups, records, navigation
        case customURLParam = "customUrlParam"
    }
}

// MARK: - CustomURLParam
struct CustomURLParam: Codable {
}

// MARK: - Navigation
struct Navigation: Codable {
    let ancester, current: [Ancester]
    let childs: [String]?
}

// MARK: - Ancester
struct Ancester: Codable {
    let label, categoryID: String

    enum CodingKeys: String, CodingKey {
        case label
        case categoryID = "categoryId"
    }
}

// MARK: - PlpState
struct PlpState: Codable {
    let categoryID, currentSortOption, currentFilters: String
    let firstRecNum, lastRecNum, recsPerPage, totalNumRecs: Int
    let plpSellerName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case currentSortOption, currentFilters, firstRecNum, lastRecNum, recsPerPage, totalNumRecs, plpSellerName
    }
}

// MARK: - Record
struct Record: Codable {
    let productID, skuRepositoryID, productDisplayName: String
    let productType: ProductType
    let productRatingCount: Int?
    let productAvgRating: Double
    let promotionalGiftMessage: PromotionalGiftMessage
    let listPrice, minimumListPrice, maximumListPrice: Int
    let promoPrice, minimumPromoPrice, maximumPromoPrice: Double
    let isHybrid, isMarketPlace, isImportationProduct: Bool
    let brand, seller: String
    let category: String
    let dwPromotionInfo: DWPromotionInfo
    let isExpressFavoriteStore, isExpressNearByStore: Bool
    let smImage, lgImage, xlImage: String
    let groupType: GroupType
    let plpFlags: [String]?
    let variantsColor: [VariantsColor]

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case skuRepositoryID = "skuRepositoryId"
        case productDisplayName, productType, productRatingCount, productAvgRating, promotionalGiftMessage, listPrice, minimumListPrice, maximumListPrice, promoPrice, minimumPromoPrice, maximumPromoPrice, isHybrid, isMarketPlace, isImportationProduct, brand, seller, category, dwPromotionInfo, isExpressFavoriteStore, isExpressNearByStore, smImage, lgImage, xlImage, groupType, plpFlags, variantsColor
    }
}

// MARK: - DWPromotionInfo
struct DWPromotionInfo: Codable {
    let dwToolTipInfo, dWPromoDescription: String
}

enum GroupType: String, Codable {
    case notSpecified = "Not Specified"
}

enum ProductType: String, Codable {
    case bigTicket = "Big Ticket"
    case softLine = "Soft Line"
}

enum PromotionalGiftMessage: String, Codable {
    case na = "NA"
}

// MARK: - VariantsColor
struct VariantsColor: Codable {
    let colorName, colorHex, colorImageURL: String
    let colorMainURL, skuID: String?

    enum CodingKeys: String, CodingKey {
        case colorName, colorHex, colorImageURL, colorMainURL
        case skuID = "skuId"
    }
}

// MARK: - RefinementGroup
struct RefinementGroup: Codable {
    let name: String
    let refinement: [Refinement]
    let multiSelect: Bool
    let dimensionName: String
}

// MARK: - Refinement
struct Refinement: Codable {
    let count: Int
    let label, refinementID: String
    let selected: Bool
    let type: TypeEnum
    let searchName: SearchName?
    let colorHex, high, low: String?

    enum CodingKeys: String, CodingKey {
        case count, label
        case refinementID = "refinementId"
        case selected, type, searchName, colorHex, high, low
    }
}

enum SearchName: String, Codable {
    case categories1 = "categories.1"
}

enum TypeEnum: String, Codable {
    case range = "Range"
    case value = "Value"
}

// MARK: - SortOption
struct SortOption: Codable {
    let sortBy, label: String
}

// MARK: - Status
struct Status: Codable {
    let status: String
    let statusCode: Int
}
