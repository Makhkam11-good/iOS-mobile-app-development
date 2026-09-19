abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({
    required this.id,
    required this.title,
    required this.price,
  });

  String getDetails();
}

class AudioBook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  AudioBook({
    required String id,
    required String title,
    required double price,
    required this.durationHours,
    required this.narrator,

  }) :super(id: id, title: title, price: price);

  @override
  String getDetails(){
    return 'AudioBook: $title, Narrator: $narrator, Duration: $durationHours hours, Price: \$$price';
  }
}

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required String id,
    required String title,
    required double price,
    required this.fileSizeMB,
    required this.author,
  }) : super(id: id, title: title, price: price);

  @override
  String getDetails(){
    return 'EBook : $title, Author: $author, File Size: $fileSizeMB MB, Price: \$$price';
  }
}

mixin Downloadable{
  void download(String title){
    print('downloading $title');
  }
}

class ShoppingCart{
  List<MediaItem> _items = [];

  void addItem(MediaItem item) => _items.add(item);

  double  calculateTotalWithTax({double taxRate = 0.12}) => _items.fold(0.0,(total,item) => total + item.price * (1 + taxRate));
  

  List<MediaItem> filterByMaxPrice(double maxPrice) => _items.where((item) => item.price <=maxPrice).toList();


  void printReceipt(){
    for (var item in _items){
      print(item.getDetails());
      if (item is Downloadable){
        (item as Downloadable).download(item.title);
      }
    }
  }
}

void main() {
  var cart = ShoppingCart();

  cart.addItem(AudioBook(
    id: 'A1',
    title: 'Atomic Habits',
    price: 15.0,
    durationHours: 5.5,
    narrator: 'James Clear',
  ));

 
  cart.addItem(EBook(
    id: 'E1',
    title: 'Clean Code',
    price: 25.0,
    fileSizeMB: 4.2,
    author: 'Robert Martin',
  ));

  
  cart.printReceipt();

  print('\nItems cheaper than \$20:');
  var cheapItems = cart.filterByMaxPrice(20.0);
  for (var item in cheapItems) {
    print('- ${item.title} (\$${item.price})');
  }
}