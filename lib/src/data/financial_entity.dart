class FinancialEntity {
  final int id;
  final String date;
  final String description;
  final double value;
  final bool receivement;
  static final columns = ["name", "description", "price", "image"];

  FinancialEntity(this.id, this.date, this.description, this.value, this.receivement);
  
  factory FinancialEntity.fromMap(Map<String, dynamic> data) {
      var fin = FinancialEntity( 
         data['id'], 
         data['date'], 
         data['description'], 
         data['value'], 
         data['receivement'], 
      ); 
      print(fin);
      return fin;
   } 
   Map<String, dynamic> toMap() => {
      "date": date, 
      "description": description, 
      "value": value, 
      "receivement": receivement 
   }; 


}