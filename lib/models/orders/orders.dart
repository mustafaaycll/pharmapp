class pharmappOrder {

  final String id;
  final String pharmid;
  final String pharmName;
  final List<dynamic> amounts;
  final List<dynamic> products;
  final List<dynamic> prices;
  final DateTime date;
  final double cost;
  final bool rated;

  pharmappOrder({required this.id, required this.pharmid, required this.pharmName, required this.amounts, required this.prices, required this.products, required this.date, required this.cost, required this.rated});
  
}