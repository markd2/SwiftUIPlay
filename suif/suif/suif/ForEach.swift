import SwiftUI

struct Book: Identifiable {
    var title: String
    var author: String
    var isbn: Int
    var id: Int { isbn }
}

struct ForEachView: View {
    var books: [Book] = [ Book(title: "Zen and Bork", author: "Snarnge", isbn: 2345),
                          Book(title: "Hoover Greeble Bork", author: "Oop Ack", isbn: 6789)
    ]

    var body: some View {
        VStack {
            ForEach(books) { book in
                Text(book.title)
            }
        }
    }
}

#Preview {
    ForEachView()
}
