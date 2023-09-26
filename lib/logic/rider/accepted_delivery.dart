import 'dart:async';

class AcceptedDeliveryBloc {
  final _acceptedDeliveryController = StreamController<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get acceptedDeliveryStream =>
      _acceptedDeliveryController.stream;

  void setAcceptedDelivery(Map<String, dynamic> delivery) {
    _acceptedDeliveryController.sink.add(delivery);
  }

  void dispose() {
    _acceptedDeliveryController.close();
  }
}

final acceptedDeliveryBloc = AcceptedDeliveryBloc();
