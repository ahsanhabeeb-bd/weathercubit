sealed class DataState {}

final class DataInitial extends DataState {}

final class DataLoaded extends DataState {
  Map<String, dynamic>? weatherdata;

  List? citys;
  String city;
  DataLoaded(this.weatherdata, this.city, {this.citys});
}

final class DataError extends DataState {
  String error;
  DataError(this.error);
}
