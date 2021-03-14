class busArrival {
  String _flag;
  String _locationNo1;
  String _locationNo2;
  String _lowPlate1;
  String _lowPlate2;
  String _plateNo1;
  String _plateNo2;
  String _predictTime1;
  String _predictTime2;
  String _remainSeatCnt1;
  String _remainSeatCnt2;
  String _routeId;
  String _staOrder;
  String _stationId;
  String _routeName;

  busArrival(
      this._flag,
      this._locationNo1,
      this._locationNo2,
      this._lowPlate1,
      this._lowPlate2,
      this._plateNo1,
      this._plateNo2,
      this._predictTime1,
      this._predictTime2,
      this._remainSeatCnt1,
      this._remainSeatCnt2,
      this._routeId,
      this._staOrder,
      this._stationId,
      this._routeName);

  String get flag => _flag;
  String get locationNo1 => _locationNo1;
  String get locationNo2 => _locationNo2;
  String get lowPlate1 => _lowPlate1;
  String get lowPlate2 => _lowPlate2;
  String get plateNo1 => _plateNo1;
  String get plateNo2 => _plateNo2;
  String get predictTime1 => _predictTime1;
  String get predictTime2 => _predictTime2;
  String get remainSeatCnt1 => _remainSeatCnt1;
  String get remainSeatCnt2 => _remainSeatCnt2;
  String get routeId => _routeId;
  String get staOrder => _staOrder;
  String get stationId => _stationId;
  String get routeName => _routeName;

  set routeName(String routeNmae) => _routeName = routeName;
}
