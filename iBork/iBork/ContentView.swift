//
//  ContentView.swift
//  iBork
//
//  Created by Mark Dalrymple on 3/28/21.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: ItemDetail(item: item)) {
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
              .navigationTitle("Snorgle")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ItemRow: View {
    let item: MenuItem
    let colors: [String: Color] = [
        "D": .purple,
        "G": .black,
        "N": .red,
        "S": .blue,
        "V": .green
    ]

    var body: some View {
        HStack {
            Image(item.thumbnailImage).clipShape(Circle())
              .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            VStack(alignment: .leading) {
                Text(item.name).font(.headline)
                Text("$\(item.price)")
            }
            Spacer()
            ForEach(item.restrictions, id: \.self) { restriction in
                Text(restriction)
                .font(.caption)
                .fontWeight(.black)
                .padding(5)
                .background(colors[restriction, default: .black])
                .clipShape(Circle())
                .foregroundColor(.white)
            }
        }
    }
}

struct ItemDetail: View {
    let item: MenuItem

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                  .resizable()
                  .scaledToFit()
                Text("Photo: \(item.photoCredit)")
                  .padding(4)
                  .background(Color.black)
                  .font(.caption)
                  .foregroundColor(.white)
                  .offset(x: -5, y: -5)
            }
            Text(item.description).padding()
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
