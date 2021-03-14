class stationRoutes {
  String _districtCd;
  String _regionName;
  String _routeId;
  String _routeName;
  String _routeTypeCd;
  String _routeTypeName;
  String _staOrder;

  stationRoutes(
    this._districtCd,
    this._regionName,
    this._routeId,
    this._routeName,
    this._routeTypeCd,
    this._routeTypeName,
    this._staOrder,
  );

  String get districtCd => _districtCd;
  String get regionName => _regionName;
  String get routeId => _routeId;
  String get routeName => _routeName;
  String get routeTypeCd => _routeTypeCd;
  String get routeTypeName => _routeTypeName;
  String get staOrder => _staOrder;
}
