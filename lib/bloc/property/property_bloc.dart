import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:escan/bloc/property/property_event.dart';
import 'package:escan/bloc/property/property_state.dart';
import 'package:escan/data/repositry/reposityproperty.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository propertyRepository;

  PropertyBloc({required this.propertyRepository})
      : super(LoadingPropertiesState());

  Stream<PropertyState> mapEventToState(PropertyEvent event) async* {
    if (event is LoadPropertiesEvent) {
      yield PropertiesLoadingState();

      try {
        final properties =
            await propertyRepository.getProperties(event.pageSize, null);
        if (properties.isEmpty) {
          yield PropertyEmptyState();
        } else {
          yield PropertiesLoadedState(properties);
        }
      } catch (e) {
        yield PropertiesLoadingErrorState(e.toString());
      }
    } else if (event is AddPropertyEvent) {
      try {
        await propertyRepository.addProperty(event.property);
        yield PropertyAddedState();
      } catch (e) {
        yield PropertyUpdateErrorState(e.toString());
      }
    } else if (event is UpdatePropertyEvent) {
      yield UpdatingPropertyState();

      try {
        await propertyRepository.updateProperty(event.id, event.fieldsToUpdate);
        yield PropertyUpdatedSuccessState();
      } catch (e) {
        yield PropertyUpdateErrorState(e.toString());
      }
    } else if (event is DeletePropertyEvent) {
      try {
        await propertyRepository.deleteProperty(event.id);
        yield PropertyDeletedSuccessState();
      } catch (e) {
        yield PropertyDeleteErrorState(e.toString());
      }
    } else if (event is SearchPropertiesEvent) {
      yield SearchingPropertiesState();
      if (event.query.isEmpty) {
        yield ClearSearchState();
      } else {
        try {
          final properties =
              await propertyRepository.searchProperties(event.query);
          if (properties.isEmpty) {
            yield PropertyEmptyState();
          } else {
            yield PropertiesSearchedState(properties);
          }
        } catch (e) {
          yield PropertiesLoadingErrorState(e.toString());
        }
      }
    }

    //  else if (event is FilterPropertiesEvent) {
    //   yield FilteringPropertiesState();

    //   if (event.filters.isEmpty) {
    //     yield ClearFilterState();
    //   } else {
    //     try {
    //       final properties =
    //           await propertyRepository.filterProperties(event.filters);
    //       if (properties.isEmpty) {
    //         yield PropertiesFilteredEmptyState();
    //       } else {
    //         yield PropertiesFilteredState(properties);
    //       }
    //     } catch (e) {
    //       yield PropertiesLoadingErrorState(e.toString());
    //     }
    //   }

    // }
    else if (event is GetPropertyByIdEvent) {
      try {
        final property = await propertyRepository.getPropertyById(event.id);
        yield GetPropertyByIdState(property);
      } catch (e) {
        yield PropertiesLoadingErrorState(e.toString());
      }
    } else if (event is BatchUpdatePropertiesEvent) {
      yield PropertiesLoadingState();

      try {
        await propertyRepository.batchUpdateProperties(event.properties);
        yield BatchUpdatePropertiesState();
      } catch (e) {
        yield PropertiesLoadingErrorState(e.toString());
      }
    } else if (event is LoadMorePropertiesEvent) {
      yield LoadingMorePropertiesState();

      try {
        final properties = await propertyRepository.getProperties(
            event.pageSize, event.startAfter);
        if (properties.isEmpty) {
          yield PropertiesNotEmptyState();
        } else {
          yield MorePropertiesLoadedState(properties);
        }
      } catch (e) {
        yield PropertiesLoadingErrorState(e.toString());
      }
    } else if (event is ClearSearchEvent) {
      yield ClearSearchState();
    } else if (event is ClearFilterEvent) {
      yield ClearFilterState();
    }
  }
}
