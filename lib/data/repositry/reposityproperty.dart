import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escan/data/model/propertymodel.dart';
import 'package:escan/data/provider/firebase.dart';

class PropertyRepository {
  final PropertyFiebaseProvider firebaseProvider;

  PropertyRepository(this.firebaseProvider);

  Future<List<Property>> getProperties(
      int pageSize, DocumentSnapshot? startAfter) {
    return firebaseProvider.getProperties(
        pageSize: pageSize, startAfter: startAfter);
  }

  Future<void> addProperty(Property property) {
    return firebaseProvider.addProperty(property);
  }

  Future<void> updateProperty(int id, Map<String, dynamic> fieldsToUpdate) {
    return firebaseProvider.updateProperty(id, fieldsToUpdate);
  }

  Future<void> deleteProperty(int id) {
    return firebaseProvider.deleteProperty(id);
  }

  Stream<List<Property>> propertiesStream(
      {int pageSize = 10, String? filterByTitle}) {
    return firebaseProvider.propertiesStream(
        pageSize: pageSize, filterByTitle: filterByTitle);
  }

  Future<List<Property>> searchProperties(String query) {
    return firebaseProvider.searchProperties(query);
  }

  Stream<List<Property>> propertiesStreamByUser(String userId) {
    return firebaseProvider.propertiesStreamByUser(userId);
  }

  Future<Property?> getPropertyById(int id) {
    return firebaseProvider.getPropertyById(id);
  }

  Future<int> getPropertiesCount() {
    return firebaseProvider.getPropertiesCount();
  }

  Stream<int> propertiesCountStream() {
    return firebaseProvider.propertiesCountStream();
  }

  Future<Property?> getLastProperty() {
    return firebaseProvider.getLastProperty();
  }

  Future<List<Property>> getPropertiesPaginated(int limit) async {
    final properties = await firebaseProvider.getPropertiesPaginated(limit);
    return properties;
  }

  Future<List<Property>> getFilteredProperties(
      {required String query, required String filterBy}) async {
    final properties = await firebaseProvider.getFilteredProperties(
        query: query, filterBy: filterBy);
    return properties;
  }

  Future<void> batchUpdateProperties(List<Property> properties) async {
    final batch = firebaseProvider.firestore.batch();
    for (final property in properties) {
      final docRef = firebaseProvider.firestore
          .collection('properties')
          .doc(property.id.toString());
      batch.update(docRef, property.toJson());
    }
    return batch.commit();
  }
}
