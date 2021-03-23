class busRoute {
  String _companyId;
  String _companyName;
  String _companyTel;
  String _districtCd;
  String _downFirstTime;
  String _downLastTime;
  String _endMobileNo;
  String _endStationId;
  String _endStationName;
  String _peekAlloc;
  String _regionName;
  String _routeId;
  String _routeName;
  String _routeTypeCd;
  String _routeTypeName;
  String _startMobileNo;
  String _startStationId;
  String _startStationName;
  String _upFirstTime;
  String _upLastTime;
  String _nPeekAlloc;

  busRoute(
      this._companyId,
      this._companyName,
      this._companyTel,
      this._districtCd,
      this._downFirstTime,
      this._downLastTime,
      this._endMobileNo,
      this._endStationId,
      this._endStationName,
      this._peekAlloc,
      this._regionName,
      this._routeId,
      this._routeName,
      this._routeTypeCd,
      this._routeTypeName,
      this._startMobileNo,
      this._startStationId,
      this._startStationName,
      this._upFirstTime,
      this._upLastTime,
      this._nPeekAlloc);

  String get companyId => _companyId;
  String get companyName => _companyName;
  String get companyTel => _companyTel;
  String get districtCd => _districtCd;
  String get downFirstTime => _downFirstTime;
  String get downLastTime => _downLastTime;
  String get endMobileNo => _endMobileNo;
  String get endStationId => _endStationId;
  String get endStationName => _endStationName;
  String get peekAlloc => _peekAlloc;
  String get regionName => _regionName;
  String get routeId => _routeId;
  String get routeName => _routeName;
  String get routeTypeCd => _routeTypeCd;
  String get routeTypeName => _routeTypeName;
  String get startMobileNo => _startMobileNo;
  String get startStationId => _startStationId;
  String get startStationName => _startStationName;
  String get upFirstTime => _upFirstTime;
  String get upLastTime => _upLastTime;
  String get nPeekAlloc => _nPeekAlloc;
}
