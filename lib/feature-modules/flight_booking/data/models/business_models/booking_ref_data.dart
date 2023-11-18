class BookingRefData {

  final String bookingRef;
  final bool isSeatSelection;
  final bool isMealSelection;
  final bool isExtraBaggageSelection;

  BookingRefData({
    required this.bookingRef,
    required this.isSeatSelection,
    required this.isMealSelection,
    required this.isExtraBaggageSelection,
  });

  Map toJson() => {
    'bookingRef': bookingRef,
    'isSeatSelection': isSeatSelection,
    'isMealSelection': isMealSelection,
    'isExtraBaggageSelection': isExtraBaggageSelection,
  };

}

