import 'package:mobx/mobx.dart';

part 'service_status_data.g.dart';

enum ServiceStatusEnum { IDLE, DONE, PENDING, FETCHING, ERROR }

class ServiceStatusData<T> = _ServiceStatusData<T> with _$ServiceStatusData<T>;

abstract class _ServiceStatusData<T> with Store {
  @observable
  ServiceStatusEnum _status = ServiceStatusEnum.IDLE;

  @observable
  T _data;

  @observable
  dynamic _error;

  @observable
  int _page;

  @computed
  bool get isDone => this._status == ServiceStatusEnum.DONE;

  @computed
  bool get isPending => this._status == ServiceStatusEnum.PENDING;

  @computed
  bool get isFetching => this._status == ServiceStatusEnum.FETCHING;

  @computed
  bool get isError => this._status == ServiceStatusEnum.ERROR;

  @computed
  bool get isIdle => this._status == ServiceStatusEnum.IDLE;

  @computed
  bool get isEmpty {
    if (this._status == ServiceStatusEnum.DONE) {
      if (this._data == null)
        return true;
      else if (this._data is List) {
        var tempList = this._data as List;
        if (tempList.isEmpty)
          return true;
        else
          return false;
      } else
        return false;
    } else
      return false;
  }

  @computed
  ServiceStatusEnum get getStatus => this._status;

  @computed
  T get getData => this._data;

  @computed
  int get currentPage => this._page ?? 0;

  @computed
  bool get hasNextPage {
    if (this._page != null && this._page >= 0)
      return true;
    else
      return false;
  }

  @computed
  dynamic get getError => this._error;

  @action
  setPending() {
    this._error = null;
    this._status = ServiceStatusEnum.PENDING;
    return this;
  }

  @action
  setFetching() {
    this._error = null;
    this._status = ServiceStatusEnum.FETCHING;
    return this;
  }

  @action
  setDone(T data, {int currentPage}) {
    this._error = null;
    this._data = data;
    if (currentPage != null) this._page = currentPage;
    this._status = ServiceStatusEnum.DONE;
    return this;
  }

  @action
  setError(dynamic error) {
    if (_page == null) this._data = null;
    this._error = error;
    this._status = ServiceStatusEnum.ERROR;
    this._page = -1;
    return this;
  }

  @action
  setIdle() {
    this._data = null;
    this._error = null;
    this._status = ServiceStatusEnum.IDLE;
    this._page = 0;
    return this;
  }
}
