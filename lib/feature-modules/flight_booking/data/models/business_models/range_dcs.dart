class RangeDcs {

  final double min;
  final double max;
  RangeDcs({
    required this.min, 
    required this.max
  });



}

RangeDcs mapRangeDcs(dynamic payload){
  return RangeDcs(
    min :payload["min"]??0.0,
    max :payload["max"]??100000.0,
  );
}
