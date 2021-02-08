// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_status_data.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceStatusData<T> on _ServiceStatusData<T>, Store {
  Computed<bool> _$isDoneComputed;

  @override
  bool get isDone => (_$isDoneComputed ??=
          Computed<bool>(() => super.isDone, name: '_ServiceStatusData.isDone'))
      .value;
  Computed<bool> _$isPendingComputed;

  @override
  bool get isPending =>
      (_$isPendingComputed ??= Computed<bool>(() => super.isPending,
              name: '_ServiceStatusData.isPending'))
          .value;
  Computed<bool> _$isFetchingComputed;

  @override
  bool get isFetching =>
      (_$isFetchingComputed ??= Computed<bool>(() => super.isFetching,
              name: '_ServiceStatusData.isFetching'))
          .value;
  Computed<bool> _$isErrorComputed;

  @override
  bool get isError => (_$isErrorComputed ??= Computed<bool>(() => super.isError,
          name: '_ServiceStatusData.isError'))
      .value;
  Computed<bool> _$isIdleComputed;

  @override
  bool get isIdle => (_$isIdleComputed ??=
          Computed<bool>(() => super.isIdle, name: '_ServiceStatusData.isIdle'))
      .value;
  Computed<bool> _$isEmptyComputed;

  @override
  bool get isEmpty => (_$isEmptyComputed ??= Computed<bool>(() => super.isEmpty,
          name: '_ServiceStatusData.isEmpty'))
      .value;
  Computed<ServiceStatusEnum> _$getStatusComputed;

  @override
  ServiceStatusEnum get getStatus => (_$getStatusComputed ??=
          Computed<ServiceStatusEnum>(() => super.getStatus,
              name: '_ServiceStatusData.getStatus'))
      .value;
  Computed<T> _$getDataComputed;

  @override
  T get getData => (_$getDataComputed ??=
          Computed<T>(() => super.getData, name: '_ServiceStatusData.getData'))
      .value;
  Computed<int> _$currentPageComputed;

  @override
  int get currentPage =>
      (_$currentPageComputed ??= Computed<int>(() => super.currentPage,
              name: '_ServiceStatusData.currentPage'))
          .value;
  Computed<bool> _$hasNextPageComputed;

  @override
  bool get hasNextPage =>
      (_$hasNextPageComputed ??= Computed<bool>(() => super.hasNextPage,
              name: '_ServiceStatusData.hasNextPage'))
          .value;
  Computed<dynamic> _$getErrorComputed;

  @override
  dynamic get getError =>
      (_$getErrorComputed ??= Computed<dynamic>(() => super.getError,
              name: '_ServiceStatusData.getError'))
          .value;

  final _$_statusAtom = Atom(name: '_ServiceStatusData._status');

  @override
  ServiceStatusEnum get _status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  set _status(ServiceStatusEnum value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  final _$_dataAtom = Atom(name: '_ServiceStatusData._data');

  @override
  T get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(T value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  final _$_errorAtom = Atom(name: '_ServiceStatusData._error');

  @override
  dynamic get _error {
    _$_errorAtom.reportRead();
    return super._error;
  }

  @override
  set _error(dynamic value) {
    _$_errorAtom.reportWrite(value, super._error, () {
      super._error = value;
    });
  }

  final _$_pageAtom = Atom(name: '_ServiceStatusData._page');

  @override
  int get _page {
    _$_pageAtom.reportRead();
    return super._page;
  }

  @override
  set _page(int value) {
    _$_pageAtom.reportWrite(value, super._page, () {
      super._page = value;
    });
  }

  final _$_ServiceStatusDataActionController =
      ActionController(name: '_ServiceStatusData');

  @override
  dynamic setPending() {
    final _$actionInfo = _$_ServiceStatusDataActionController.startAction(
        name: '_ServiceStatusData.setPending');
    try {
      return super.setPending();
    } finally {
      _$_ServiceStatusDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFetching() {
    final _$actionInfo = _$_ServiceStatusDataActionController.startAction(
        name: '_ServiceStatusData.setFetching');
    try {
      return super.setFetching();
    } finally {
      _$_ServiceStatusDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDone(T data, {int currentPage}) {
    final _$actionInfo = _$_ServiceStatusDataActionController.startAction(
        name: '_ServiceStatusData.setDone');
    try {
      return super.setDone(data, currentPage: currentPage);
    } finally {
      _$_ServiceStatusDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(dynamic error) {
    final _$actionInfo = _$_ServiceStatusDataActionController.startAction(
        name: '_ServiceStatusData.setError');
    try {
      return super.setError(error);
    } finally {
      _$_ServiceStatusDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIdle() {
    final _$actionInfo = _$_ServiceStatusDataActionController.startAction(
        name: '_ServiceStatusData.setIdle');
    try {
      return super.setIdle();
    } finally {
      _$_ServiceStatusDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDone: ${isDone},
isPending: ${isPending},
isFetching: ${isFetching},
isError: ${isError},
isIdle: ${isIdle},
isEmpty: ${isEmpty},
getStatus: ${getStatus},
getData: ${getData},
currentPage: ${currentPage},
hasNextPage: ${hasNextPage},
getError: ${getError}
    ''';
  }
}
