import 'dart:io' as io;
List orderSummary = [];
Map<String, int> itemsPrices = { // resturant menue "as map order:price"
  "sandwich": 3,
  "chiken burger": 6,
  "chiken burger with cheas": 7,
  "melt burger": 7,
  "melt burger with chease": 8,
  "pizza": 23,
  "pizza with piprony": 28,
  "chiken brosted": 22,
  "fride rice": 24,
};

void main(){
  
  bool run = true;
  while(run){
    print("1 - view menue");      
    print("2 - place order");
    print("3 - order summery");
    print("0 - exit");

    int choise = -1;
        while(choise < 0 || choise > 3){ 
        print('\x1B[34m please choose serve of list \x1B[0m'); // as blue color

      try{
        String? input = io.stdin.readLineSync();
        if(input == null || input.trim().isEmpty){ // here will check if input empty or no, not important any thing else
          throw FormatException(); // if empty will go to catch 
        }
        choise = int.parse(input);
        if(choise < 0 || choise > 3){ // if not empty or null, will check if it in range 0-3, if yes will skip if statement
           // if no will print this and go to cach
            print('\x1B[31m ============== please number shuold be beyween 0-3 ============== \x1B[0m');

        }
      }
      catch(e){
        // print("============== invalid input - please enter number between 0-3 ================");
          print('\x1B[31m ========== invalid input - please enter number between 0-3 ============ \x1B[0m');

        choise = -1; //this to isure you cant out untill enter valid value
      }
    }

    switch(choise){
      case(1):
        viewMenu();
        break;
      case(2):
         placeOrder();
        break;
      case(3):
        displayingOrderSummary(orderSummary);
        break;
      case(0):
        print("thank you for visit, good bey👋");
        run = false; // when enter 0 "run" will be false so program will stop
        break;
    }
  }
}


void displayingOrderSummary(List order) {
  if (order.isEmpty) { //check if thre is any item in order
    print("--- your order is empty ---");
  } else {
    print("--- your order summary: ---");

    int total = 0;

    order.forEach((item) {
      int price = itemsPrices[item] ?? 0;  // fallback in case item not found
      print('- $item: \x1B[32m \$${price} \x1B[0m'); // all these inside else{ ... }
      total += price; // <-- Arithmetic Operator used here
    });

    print("--------------------------");
    print('Total: \x1B[32m\$${total} \x1B[0m'); // will print total as green color
  }
}


void viewMenu() { // this function will display menue in map "map in top"
  print(" --- MENU ---");
  itemsPrices.forEach((item, price) {
    print("- $item: --> \$${price}");
  });
}

void placeOrder() {
  viewMenu();
  bool isItemInMenu(String itemName) { // this small function will take item name to check if it found or no
  return itemsPrices.containsKey(itemName);
}
  print(" Type  name of the item or 'done' to finish:");
  while (true) {
    String? input = io.stdin.readLineSync();
    if (input == null || input.trim().isEmpty) { //if null will return you to enter valid item
      print('\x1B[31m enter valid orde or "done" if you fenish \x1B[0m');
      continue;
    }

    input = input.trim().toLowerCase(); // lower case all thing to match

    if (input == 'done') { // while loop will not finish untill type 'done'
      break;
    }

    if (isItemInMenu(input)) { // after checking ths item foun, will add it to orderSammery
      orderSummary.add(input); 
      print('\x1B[32m✅ "$input" done add to your order.\x1B[0m');
      
    } else {
      print('\x1B[31m❌ Sorry, "$input" is not on the menu.\x1B[0m'); // if not found will print this
    }
  }
}


//this