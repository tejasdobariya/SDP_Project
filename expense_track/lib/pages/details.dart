import 'package:cloud_firestore/cloud_firestore.dart';

class Details {
  late String id;
  late String category;
  late int amount;
  late String note;
  late String type;
  late DateTime selectedDate;
  late String emailid;
  late String txnid;

  Details(
      {required this.category,
      required this.amount,
      required this.note,
      required this.type,
      required this.selectedDate,
      required this.emailid,
      required this.txnid,
      required this.id});

  Map<String, dynamic> toJson() => {
        'categoty': category,
        'amount': amount,
        'note': note,
        'type': type,
        'date': selectedDate,
        'email': emailid,
        'txnid': txnid
      };

  static Details fromJson(Map<String, dynamic> json) => Details(
      category: json['category'],
      amount: int.parse(json['amount']),
      note: json['note'],
      type: json['type'],
      selectedDate: (json['date'] as Timestamp).toDate(),
      emailid: json['email'],
      txnid: json['txnid'],
      id: json['id']);
}
