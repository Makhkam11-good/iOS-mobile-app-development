//TASK 3

// void main(){
//   print("input your text");
//   String? text= stdin.readLineSync();
//   int a = 0;
//   for(int i = 0; i < text!.length; i++){
//     if(text[i]=='a' || text[i]=='e' || text[i]=='i' || text[i]=='o' || text[i]=='u'){
//       a++;
//     }
//   }
//   print("the number of vowels in the text is $a");
// }


// TASK 4 
// void main (){
//   List<int> numbers = [14,88,3,42,99,12,67];
//   int min = numbers[0];
//   int max = numbers[0];
//   for (int i = 0; i < numbers.length; i++){
//     if(numbers[i] < min){
//       min = numbers[i];
//     }
//     if(numbers[i] > max){
//       max = numbers[i];
//     }
//   }
//   print('min is $min');
//   print('max is $max');
// }

//Task 5
// void main(){
//   print("Enter a number:");
//   int number = int.parse(stdin.readLineSync()!);
//   bool isPrime = true;
//   if (number <= 1) {
//     isPrime = false;
//   } 
//   for (int i=2;i<=number/2;i++){
//     if (number % i == 0){
//       isPrime = false;
//       break;
//     }
//   }
//   if (isPrime){
//     print("$number is a prime number");
//   } else {
//     print("$number is not a prime number");
//   }
// }



//TASK 2
// void main() {
//   stdout.write("Enter date: ");
//   String? input = stdin.readLineSync();
//   List<String> date = input?.split('.') ?? [];

//   if (date.length < 3) {
//     print('invalid value');
//     return;
//   }

//   int day = int.parse(date[0]);
//   int month = int.parse(date[1]);
//   int year = int.parse(date[2]);
//   int leap = 1;

//   if (year % 100 == 0 && year % 400 != 0) {
//     leap = 0;
//   } else if (year % 400 == 0) {
//     leap = 1;
//   } else if (year % 4 == 0) {
//     leap = 1;
//   } else {
//     leap = 0;
//   }

//   if ((day > 28 && leap == 0 && month == 2) || month > 12) {
//     print('invalid value');
//   } 
//   else if (month == 1) {
//     if (day > 31) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 31) {
//         print("1.02.$year");
//       }
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 2) {
//     if (day > 29) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if ((leap == 1 && day > 29) || (leap == 0 && day > 28)) {
//         print("1.03.$year");
//       } 
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 3) {
//     if (day > 31) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 31) {
//         print("1.04.$year");
//       } 
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 4) {
//     if (day > 30) {
//       print('invalid value');
//     }
//     else {
//       day++;
//       if (day > 30) {
//         print("1.05.$year");
//       } 
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 5) {
//     if (day > 31) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 31) {
//         print("1.06.$year");
//       } 
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 6) {
//     if (day > 30) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 30) {
//         print("1.07.$year");
//       } 
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 7) {
//     if (day > 31) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 31) {
//         print("1.08.$year");
//       }
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 8) {
//     if (day > 31) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 31) {
//         print("1.09.$year");
//       }
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 9) {
//     if (day > 30) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 30) {
//         print("1.10.$year");
//       } 
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 10) {
//     if (day > 31) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 31) {
//         print("1.11.$year");
//       } 
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 11) {
//     if (day > 30) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 30) {
//         print("1.12.$year");
//       } 
//       else {
//         print("$day.$month.$year");
//       }
//     }
//   } 
//   else if (month == 12) {
//     if (day > 31) {
//       print('invalid value');
//     } 
//     else {
//       day++;
//       if (day > 31) {
//         year++;
//         print("1.01.$year");
//       } else {
//         print("$day.$month.$year");
//       }
//     }
//   }
// }
//class task
// void processOrder({
//   required int orderId,
//   required double itemPrice,
//   String? promoCode,
//   double? deliveryFee}
 
// ){
//   double price = itemPrice;
//   if (promoCode == 'SAVE10'){
//     price *= 0.9;
//   }
//   double Fee ;
//   if (  deliveryFee == null || deliveryFee! < 500) Fee = 500;
//   else Fee=deliveryFee!;
//   print('Order ID: $orderId');
//   print('Total Price: ${price + Fee}');

// }

// void main() {
//   processOrder(orderId: 123, itemPrice: 1000, promoCode: 'SAVE10', deliveryFee: 400);
//   processOrder(orderId: 456, itemPrice: 2000);
//   processOrder(orderId: 183, itemPrice: 1000, promoCode: 'SAVE10', deliveryFee: 670);
// }

// 📌 Homework 2: Safe ATM Banking Terminal Simulato
//Task 1
// void checkBalance({ required String name, required double balance}) => print ('$name your current balance is $balance');
// void main(){
//   checkBalance(name: 'John', balance: 1000.0);
//   checkBalance(name: 'Alice', balance: 2000.0);
// }

// Task 2
// double deposit({required double currentBalance,  double? amount}){
//   double amo = amount ?? 0.0;
//   currentBalance += amo;
//   return currentBalance;
// }
// void main(){
//   print(deposit(currentBalance:1000,amount:500));
//   print(deposit(currentBalance:1000));
// }

// Task 3
void withdraw({required String name,required double currentBalance,double? amount,int? pinCode}){
  int pin = pinCode ?? 0000;
  if (pin != 1234){
    print('ERROR');
    return;
  }

  double amo = amount ?? 0.0;
  if (amo >currentBalance){
    print('Error');
    return;
  }
  currentBalance -= amo;
  print('$name your current balance $currentBalance');

}
void main(){
  withdraw(name: 'John', currentBalance: 1000, amount: 500, pinCode: 1234);
  withdraw(name: 'Alice', currentBalance: 2000, amount: 2500, pinCode: 1234);
  withdraw(name: 'Bob', currentBalance: 1500, amount: 300, pinCode: 4321);
}