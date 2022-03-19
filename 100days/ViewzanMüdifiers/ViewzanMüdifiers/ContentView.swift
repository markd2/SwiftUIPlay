//
//  ContentView.swift
//  ViewzanMüdifiers
//
//  Created by markd on 3/11/22.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
            .font(.caption)
            .foregroundColor(.white)
            .padding(5)
            .background(.black)
        }
    }
}

extension View {
    func enya(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
          .font(.largeTitle)
          .foregroundColor(.white)
          .padding()
          .background(.blue)
          .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Snorgle")
                .titleStyle()
            Color.blue
                .frame(width: 300, height: 200)
                .enya(with: "Orinoco Flow")
            GridStack(rows: 4, columns: 4) { row, column in
                Image(systemName: "\(row * 4 + column).circle")
                Text("R\(row) C\(column)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
    }
}
