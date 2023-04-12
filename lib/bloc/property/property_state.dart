import 'package:escan/data/model/propertymodel.dart';

abstract class PropertyState {}

class LoadingPropertiesState extends PropertyState {}

class PropertiesLoadedState extends PropertyState {
  final List<Property> properties;
  PropertiesLoadedState(this.properties);
}

class PropertyAddedState extends PropertyState {}

class PropertyUpdatedState extends PropertyState {}

class PropertyDeletedState extends PropertyState {}

class SearchingPropertiesState extends PropertyState {}

class PropertiesSearchedState extends PropertyState {
  final List<Property> properties;
  PropertiesSearchedState(this.properties);
}

class FilteringPropertiesState extends PropertyState {}

class PropertiesFilteredState extends PropertyState {
  final List<Property> properties;
  PropertiesFilteredState(this.properties);
}

class GetPropertyByIdState extends PropertyState {
  final Property? property;
  GetPropertyByIdState(this.property);
}

class BatchUpdatePropertiesState extends PropertyState {}

class MorePropertiesLoadedState extends PropertyState {
  final List<Property> properties;
  MorePropertiesLoadedState(this.properties);
}

class LoadingMorePropertiesState extends PropertyState {}

class ErrorLoadingPropertiesState extends PropertyState {
  final String error;
  ErrorLoadingPropertiesState(this.error);
}

class PropertyEmptyState extends PropertyState {}

class PropertyNotEmptyState extends PropertyState {}

class PropertiesLoadingState extends PropertyState {}

class PropertiesNotLoadingState extends PropertyState {}

class SearchClearedState extends PropertyState {}

class FilterClearedState extends PropertyState {}

class PropertiesFilteredEmptyState extends PropertyState {}

class PropertiesFilteredNotEmptyState extends PropertyState {}

class PropertiesLoadingErrorState extends PropertyState {
  final String error;
  PropertiesLoadingErrorState(this.error);
}

class UpdatingPropertyState extends PropertyState {}

class PropertyUpdatedSuccessState extends PropertyState {}

class PropertyUpdateErrorState extends PropertyState {
  final String error;
  PropertyUpdateErrorState(this.error);
}

class DeletingPropertyState extends PropertyState {}

class PropertyDeletedSuccessState extends PropertyState {}

class PropertyDeleteErrorState extends PropertyState {
  final String error;
  PropertyDeleteErrorState(this.error);
}

class ClearSearchState extends PropertyState {}

class PropertiesNotEmptyState extends PropertyState {}

class ClearFilterState extends PropertyState {}
