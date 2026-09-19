class Book{
  String title;
  String author;
  double price;
  bool isBorrowed ;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  });

}

class Library{
  List<Book> _books = [];


  void addBook(Book book) =>_books.add(book);
  
  List<Book> getAvailableBooks() => _books.where((book) => !book.isBorrowed).toList();

  double getTotalValue() => _books.fold(0.0,(total,book) => total + book.price);


} 
void main(){
  Library library = Library();
  library.addBook(Book(title: 'Book 1', author: 'Author 1', price: 10.0, isBorrowed: true));
  library.addBook(Book(title: 'Book 2', author: 'Author 2', price: 15.0));
  library.addBook(Book(title: 'Book 3', author: 'Author 3', price: 20.0));

  for (var book in library.getAvailableBooks()) {
    print('Title: ${book.title}, Author: ${book.author}, Price: ${book.price}');
  }


  print('Total value: ${library.getTotalValue()}');

}