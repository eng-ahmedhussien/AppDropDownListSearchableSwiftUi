//
//  DropDownData.swift
//  NetworkLayer
//
//  Created by Mohammed Hamdi on 13/10/2022.
//

import Foundation

struct DropDownData<T: SelectionProtocol> {
    var dataArray: [T]
    var selection: T?
    var isValid: Bool = false
    var state: PickerState = .normal
    
    mutating func selectItem(id: String) {
        guard let selectedItem = dataArray.first(where: { $0.id == id }) else { return }
        self.selection = selectedItem
    }
    
  
}
