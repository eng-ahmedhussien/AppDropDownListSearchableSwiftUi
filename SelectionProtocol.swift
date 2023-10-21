//
//  SelectionProtocol.swift
//  NetworkLayer
//
//  Created by Mohammed Hamdi on 13/10/2022.
//

import Foundation

protocol IdentifiableHashableCodable: Identifiable, Hashable, Codable {}


protocol SelectionProtocol:  IdentifiableHashableCodable {
    var id: String? { get }
    var name: String? { get }
    var imageType: DropDownImageType? { get }
    var imageName: String? { get }
}

extension SelectionProtocol {
    var imageType: DropDownImageType? {
        get {
            return nil
        }
    }
    
    var imageName: String? {
        get {
            return nil
        }
    }
}

enum DropDownImageType {
    case systemImage
    case assetImage
}
