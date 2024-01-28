//
//  DropDownListSearchable.swift
//
//  Created by ahmed hussien on 19/10/2023.
//

import SwiftUI
import MijickPopupView




struct AppDropDownListSearchable<T: SelectionProtocol>: View  {
    
    @Binding var data: DropDownData<T>
    var placeholderText : String
    
    init(data: Binding<DropDownData<T>>, placeholderText: String) {
        self._data = data
        self.placeholderText = placeholderText
    }
    
    var body: some View {
            HStack{
                Text(data.selection == nil ? placeholderText : data.selection?.name ?? "")
                    .appFont(.headline)
                    .foregroundColor(.theme.primary)
                    .padding(.horizontal)
                Spacer()
                Image("dropdownArrow")
                    .padding(.horizontal)
            }
            .padding(8)
            .background(Color.theme.bgDropdown)
            .cornerRadius(25)
            .onTapGesture {
                DropDownListSerchablePopup(data: $data)
                    .showAndStack()
            }
    }
    
}

struct DropDownListSearchable_Previews: PreviewProvider {

    @State static  var normalDropDownData = DropDownData(dataArray: [
        TestSelectionModel(id: "1", name: "One"),
        TestSelectionModel(id: "2", name: "Two"),
        TestSelectionModel(id: "3", name: "Three"),
        TestSelectionModel(id: "4", name: "Four"),
    ], state: .normal
    )

    static var previews: some View {
        AppDropDownListSearchable(data: $normalDropDownData, placeholderText: "Select City")
        
    }

}



struct DropDownListSerchablePopup <T: SelectionProtocol>: CentrePopup {
    
    @Binding var data: DropDownData<T>
    @State var searchText :TextFieldData = TextFieldData()
    
    
   
    
    var filteredData: [T] {
        if searchText.text.isEmpty {
            return data.dataArray
        } else {
            return data.dataArray.filter {
                $0.name?.contains(searchText.text) ?? false
            }
        }
    }
    
    func createContent() -> some View {
        VStack {
            
            searchField
            
            List {
                ForEach(filteredData, id: \.self) { item in
                    Text(item.name ?? "")
                        .padding(5)
                        .onTapGesture {
                            data.selection = item
                            dismiss()
                        }
                }
            }
            .listStyle(.plain)
            .frame(height: 300)
        }
        .cornerRadius(25)
        
    }
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup.tapOutsideToDismiss(true)
    }
    
    var searchField: some View {
            AppTextField(data: $searchText, placeholderText: "Search".localized(), leadingView: {Image("searchGray")})
            .appFont(.subheadline)
            .dismissKeyboard(on: [.tap])
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))

    }
}

struct TestSelectionModel: SelectionProtocol {
    var id: String?
    var name: String?
}
