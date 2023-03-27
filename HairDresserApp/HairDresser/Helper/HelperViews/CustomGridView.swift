//
//  CustomGridView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 23/03/23.
//

import SwiftUI

enum GridType {
    case calendar
    case stylish
    case checkInTime
    
    func getColumns(maxWidth: CGFloat) -> [GridItem] {
        let width = (maxWidth / 3  - 3 * 10)
        switch self {
        case .calendar:
            return [ GridItem(.fixed(width)),
                     GridItem(.fixed(width)),
                     GridItem(.fixed(width))]
        case .stylish:
            return [ GridItem(.fixed(width)),
                     GridItem(.fixed(width)),
                     GridItem(.fixed(width))]
        case .checkInTime:
            return [ GridItem(.fixed(width)),
                     GridItem(.fixed(width)),
                     GridItem(.fixed(width))]
        }
    }
}

struct CustomGridView: View {
    var gridDetailModel: GridDetailModel
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading) {
            getHeader(gridDetailModel: gridDetailModel)
                .background(Constants.backgroundColor)
            LazyVGrid(columns: gridDetailModel.gridType.getColumns(maxWidth: screenWidth), alignment: .leading, spacing: 20) {
                ForEach(0..<gridDetailModel.gridItems.count, id: \.self) { index in
                    let item = gridDetailModel.gridItems[index]
                    getRows(item: item).padding(3)
                }
            }
        }
    }
    
    func getHeader(gridDetailModel: GridDetailModel) -> some View {
        VStack {
            switch gridDetailModel.gridType {
            case .calendar :  calendarHeaderView
            case .stylish :  stylishHeaderView
            case .checkInTime:  checkInTimeHeaderView
            }
        }.padding(8)
    }
    
    func getRows(item: GridItemModel) -> some View {
        VStack {
            if item.isSelected {
                getSelectedButton(item: item)
            } else {
                getNonSelectedButton(item: item)
            }
        }
    }
    
    func getSelectedButton(item: GridItemModel) -> some View {
        Button {
            gridDetailModel.callBack(gridDetailModel.gridType, item.id)
        } label: {
            VStack {
                Text(item.title)
                if let description = item.description {
                    Text(description)
                }
            }.frame(width: (screenWidth / 3  - 3 * 20), height: 50)
        }.buttonStyle(.borderedProminent)
    }
    func getNonSelectedButton(item: GridItemModel) -> some View {
        Button {
            gridDetailModel.callBack(gridDetailModel.gridType, item.id)
        } label: {
            VStack {
                Text(item.title)
                if let description = item.description {
                    Text(description)
                }
            }.frame(width: (screenWidth / 3  - 3 * 20), height: 50)
        }.buttonStyle(.bordered)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.blue, lineWidth: 1)
            }
    }
}

var calendarHeaderView: some View {
    HStack(spacing: 20) {
        Image(systemName: "calendar")
            .resizable()
            .frame(width: 20, height: 20)
        Text("Date")
            .foregroundColor(.gray)
            .fontWeight(.semibold)
            .font(.system(size: 18))
        Spacer()
    }
}

var stylishHeaderView: some View {
    HStack(spacing: 20) {
        Image(systemName: "person.fill")
            .resizable()
            .frame(width: 20, height: 20)
        Text("Stylish")
            .foregroundColor(.gray)
            .fontWeight(.semibold)
            .font(.system(size: 18))
        Spacer()
    }
}

var checkInTimeHeaderView: some View {
    HStack(spacing: 20) {
        Image(systemName: "stopwatch.fill")
            .resizable()
            .frame(width: 20, height: 20)
        VStack(alignment: .leading, spacing: 10) {
            Text("Check-In Time")
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .font(.system(size: 18))
            Text("You will be added in queue at this time.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        Spacer()
    }
}

struct CustomGridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridView(gridDetailModel: GridDetailModel(header: "", gridType: .stylish, gridItems: [], callBack: { _, _ in }))
    }
}
