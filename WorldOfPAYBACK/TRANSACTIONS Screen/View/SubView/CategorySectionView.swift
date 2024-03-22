//
//  CategorySectionView.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 22/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import SwiftUI

fileprivate typealias TEXT = Constants_TEXT.TransactionsViewText
fileprivate typealias IMAGE = Constants_IMAGE.SystemImage

struct CategorySectionView: View {
    
    @EnvironmentObject private var vm: TransactionViewModel
    
    var body: some View {
        HStack {
            //MARK: TITLE
            Text(TEXT.chooseCategory.name)
                .font(.headline)
                .bold()
            
            //MARK: RESET BUTTON
            Button(action: {
                withAnimation(.snappy) {
                    vm.resetSelectedCategories()
                }
            }, label: {
                Image(systemName: IMAGE.square_slash_fill.name)
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, .green)
                    .frame(width: 20, height: 20)
                    .opacity(vm.selectedCategories.isEmpty ? 0 : 1.0)
            })
            
            Spacer()
            
            //MARK: CATEGORIES
            ForEach(vm.categories, id: \.self) { value in
                Button(action: {
                    withAnimation(.snappy) {
                        /// Deselect the button if it's already selected ⚙️
                        if vm.selectedCategories.contains(value) {
                            vm.selectedCategories.remove(value)
                        }
                        /// Select the button if it's not selected ⚙️
                        else {
                            vm.selectedCategories.insert(value)
                        }
                    }
                }, label: {
                    Text("\(value)")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .fill(vm.selectedCategories.contains(value) ? Color.green : Color.gray)
                                .frame(width: 30, height: 30)
                        )
                        .opacity(vm.selectedCategories.contains(value) ? 1.0 : 0.5)
                })
                .padding(.horizontal, 6)
            }
        }
        .opacity(vm.showAlert ? 0 : 1.0)
        .padding()
    }
    
}

//#Preview { CategorySectionView() }
