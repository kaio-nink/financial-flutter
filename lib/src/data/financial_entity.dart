class FinancialEntity {
  final int id;
  final DateTime date;
  final String description;
  final double value;
  final bool receivement;
  static final columns = ["name", "description", "price", "image"];

  FinancialEntity(this.id, this.date, this.description, this.value, this.receivement);
  
  // FinancialEntity fromMap(Map<String, dynamic> data) {
  //     return FinancialEntity( 
  //        data['id'], 
  //        data['date'], 
  //        data['description'], 
  //        data['value'], 
  //        data['receivement'], 
  //     ); 
  //  } 

    FinancialEntity.fromMap(Map<String, dynamic> data) :
         id = data['id'] as int, 
         date = DateTime.fromMillisecondsSinceEpoch(data['dateCreated'] as int), 
         description = data['description'] as String, 
         value = data['value'] as double, 
         receivement = data['receivement'] as bool;
      
  
   Map<String, dynamic> toMap() => {
      "date": date.millisecondsSinceEpoch, 
      "description": description, 
      "value": value, 
      "receivement": receivement 
   }; 


}