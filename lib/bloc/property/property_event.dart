import 'package:escan/data/model/propertymodel.dart';

abstract class PropertyEvent {}

class LoadPropertiesEvent extends PropertyEvent {
  final int pageSize;
  final dynamic startAfter;
  LoadPropertiesEvent({this.pageSize = 10, this.startAfter});
}

class AddPropertyEvent extends PropertyEvent {
  final Property property;
  AddPropertyEvent(this.property);
}

class UpdatePropertyEvent extends PropertyEvent {
  final int id;
  final Map<String, dynamic> fieldsToUpdate;
  UpdatePropertyEvent(this.id, this.fieldsToUpdate);
}

class DeletePropertyEvent extends PropertyEvent {
  final int id;
  DeletePropertyEvent(this.id);
}

class SearchPropertiesEvent extends PropertyEvent {
  final String query;
  SearchPropertiesEvent(this.query);
}

// class FilterPropertiesEvent extends PropertyEvent {
//   final List<FilterModel> filters;
//   FilterPropertiesEvent(this.filters);
// }

class GetPropertyByIdEvent extends PropertyEvent {
  final int id;
  GetPropertyByIdEvent(this.id);
}

class BatchUpdatePropertiesEvent extends PropertyEvent {
  final List<Property> properties;
  BatchUpdatePropertiesEvent(this.properties);
}

class LoadMorePropertiesEvent extends PropertyEvent {
  final int pageSize;
  final dynamic startAfter;
  LoadMorePropertiesEvent({this.pageSize = 10, this.startAfter});
}

class PropertiesLoadedEvent extends PropertyEvent {
  final List<Property> properties;
  PropertiesLoadedEvent(this.properties);
}

class PropertiesLoadingErrorEvent extends PropertyEvent {
  final String error;
  PropertiesLoadingErrorEvent(this.error);
}

class PropertyAddedEvent extends PropertyEvent {
  final Property property;
  PropertyAddedEvent(this.property);
}

class PropertyUpdatedEvent extends PropertyEvent {}

class PropertyDeletedEvent extends PropertyEvent {}

class PropertiesFilteredEvent extends PropertyEvent {
  final List<Property> properties;
  PropertiesFilteredEvent(this.properties);
}

class ClearSearchEvent extends PropertyEvent {}

class ClearFilterEvent extends PropertyEvent {}

class PropertiesEmptyEvent extends PropertyEvent {}

class PropertiesNotEmptyEvent extends PropertyEvent {}

class PropertiesLoadingEvent extends PropertyEvent {}

class PropertiesNotLoadingEvent extends PropertyEvent {}
