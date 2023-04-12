import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escan/data/model/propertymodel.dart';

class PropertyFiebaseProvider {
  final FirebaseFirestore firestore;
  PropertyFiebaseProvider({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;
  Future<List<Property>> getProperties(
      {int pageSize = 10, DocumentSnapshot? startAfter}) async {
    Query query = firestore.collection('properties').orderBy('createdAt');
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    QuerySnapshot snapshot = await query.limit(pageSize).get();
    final List<Property> properties = snapshot.docs
        .map((doc) => Property.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return properties;
  }

  Future<void> addProperty(Property property) async {
    await firestore.collection('properties').add(property.toJson());
  }

  Future<void> updateProperty(
      int id, Map<String, dynamic> fieldsToUpdate) async {
    await firestore
        .collection('properties')
        .doc(id.toString())
        .update(fieldsToUpdate);
  }

  Future<void> deleteProperty(int id) async {
    await firestore.collection('properties').doc(id.toString()).delete();
  }

  Stream<List<Property>> propertiesStream(
      {int pageSize = 10, String? filterByTitle}) {
    Query query = firestore.collection('properties').orderBy('createdAt');
    if (filterByTitle != null && filterByTitle.isNotEmpty) {
      query = query
          .where('title', isGreaterThanOrEqualTo: filterByTitle)
          .limit(pageSize);
    }
    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Property.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<List<Property>> searchProperties(String query) async {
    final snapshot = await firestore
        .collection('properties')
        .where('title', isGreaterThanOrEqualTo: query)
        .get();
    final List<Property> results =
        snapshot.docs.map((doc) => Property.fromJson(doc.data())).toList();
    return results;
  }

  Stream<List<Property>> propertiesStreamByUser(String userId) {
    final query = firestore
        .collection('properties')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true);
    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Property.fromJson(doc.data())).toList());
  }

  Future<Property?> getPropertyById(int id) async {
    final snapshot =
        await firestore.collection('properties').doc(id.toString()).get();
    if (snapshot.exists) {
      return Property.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<int> getPropertiesCount() async {
    final snapshot = await firestore.collection('properties').get();
    return snapshot.docs.length;
  }

  Stream<int> propertiesCountStream() {
    return firestore
        .collection('properties')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<Property?> getLastProperty() async {
    final snapshot = await firestore
        .collection('properties')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return Property.fromJson(snapshot.docs.first.data());
    } else {
      return null;
    }
  }

  Future<List<Property>> getPropertiesPaginated(int limit) async {
    final snapshot = await firestore
        .collection('properties')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    final List<Property> results =
        snapshot.docs.map((doc) => Property.fromJson(doc.data())).toList();
    return results;
  }

  Future<List<Property>> getFilteredProperties(
      {required String query, required String filterBy}) async {
    final snapshot = await firestore
        .collection('properties')
        .where(filterBy, isGreaterThanOrEqualTo: query)
        .get();
    final List<Property> results =
        snapshot.docs.map((doc) => Property.fromJson(doc.data())).toList();
    return results;
  }

  Future<void> batchUpdateProperties(
      List<Map<String, dynamic>> properties) async {
    WriteBatch batch = firestore.batch();
    for (final property in properties) {
      batch.update(
          firestore.collection('properties').doc(property['id'].toString()),
          property);
    }
    await batch.commit();
  }
}

/*
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escan/data/model/propertymodel.dart';
import 'package:flutter/material.dart';

class FirebasePropertyProvider with ChangeNotifier {
  final CollectionReference _propertiesCollection =
      FirebaseFirestore.instance.collection('properties');

  late StreamSubscription<List<Property>> _propertiesStream;
  late StreamSubscription<Property?> _propertyStream;

  // Get all properties, with offline caching
  Future<Iterable> getProperties() async {
    try {
      final QuerySnapshot querySnapshot = await _propertiesCollection
          .get(const GetOptions(source: Source.cache)); // offline caching

      return querySnapshot.docs.map((doc) =>
          Property.fromJson(doc.data() as Map<String, dynamic>).toList());
    } catch (e) {
      throw ('Failed to get properties: $e');
    }
  }

  // Get a property by ID, with offline caching
  Future<Property?> getPropertyById(int id) async {
    try {
      final QuerySnapshot querySnapshot = await _propertiesCollection
          .where('id', isEqualTo: id)
          .limit(1)
          .get(const GetOptions(source: Source.cache)); // offline caching

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return Property.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
      throw ('Failed to get property: $e');
    }
  }

  // Add a new property
  Future<void> addProperty(Property property) {
    return _propertiesCollection
        .add(property.toJson())
        .then((value) => print('Property added'))
        .catchError((error) => throw ('Failed to add property: $error'));
  }

  // Update a property with a map of fields to update
  Future<void> updateProperty(int id, Map<String, dynamic> fieldsToUpdate) {
    return _propertiesCollection
        .doc(id.toString())
        .update(fieldsToUpdate)
        .then((value) => print('Property updated'))
        .catchError((error) => throw ('Failed to update property: $error'));
  }

// Delete a property
  Future deleteProperty(int id) {
    return _propertiesCollection
        .doc(id.toString())
        .delete()
        .then((value) => print('Property deleted'))
        .catchError((error) => throw ('Failed to delete property: $error'));
  }
  
  // Stream all properties, with offline caching
  Stream<List<Property>> propertiesStream() {
    return _propertiesCollection.snapshots(includeMetadataChanges: true).map(
      (querySnapshot) {
        if (querySnapshot.metadata.isFromCache) {
          print('Properties loaded from cache');
        }
        return querySnapshot.docs
            .map((doc) => Property.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      }
    );
  }


// Stream all properties, with offline caching
  void streamProperties() {
    _propertiesStream = _propertiesCollection
        .snapshots(includeMetadataChanges: true)
        .map((querySnapshot) {
      if (querySnapshot.metadata.isFromCache) {
        // offline caching
        print('Properties loaded from cache');
      }
      return querySnapshot.docs;
    }).listen((docs) {
      List<Property> properties = docs
          .map((doc) => Property.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }) as StreamSubscription<List<Property>>;
  }

// Stream a single property by ID
  void streamPropertyById(int id) {
    _propertyStream = _propertiesCollection
        .where('id', isEqualTo: id)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return Property.fromJson(querySnapshot.docs.first.data() as Map);
      } else {
        return null;
      }
    }).listen((property) => notifyListeners());
  }

// Detach all listeners
  void dispose() {
    _propertiesStream.cancel();
    _propertyStream.cancel();
    super.dispose();
  }
}
*/
