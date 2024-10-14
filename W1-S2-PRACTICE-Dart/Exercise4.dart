String order(List<String> pizza_list) {
  const pizzaPrices = {
    'margherita': 5.5,
    'pepperoni': 7.5,
    'vegetarian': 6.5,
  };

  double total = 0;
  for (var pizza in pizza_list) {
    if (pizzaPrices.containsKey(pizza)) {
      total += pizzaPrices[pizza]!;
    } else {
      return ('$pizza is not on the menu');
    }
  }

  return 'Total: \$${total.toStringAsFixed(2)}';
}

void main() {
  const orderList = ['vegetarian', 'pepperoni'];

  print(order(orderList));
}
