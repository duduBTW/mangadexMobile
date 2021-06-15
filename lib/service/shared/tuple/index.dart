import 'dart:core';

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple({
    required this.item1,
    required this.item2,
  });

  factory Tuple.fromJson(Map<String, dynamic> json) {
    return Tuple(
      item1: json['item1'],
      item2: json['item2'],
    );
  }
}
