class Property {
  final int id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final List<String> videoUrls;
  final int price;
  final int rooms;
  final int bathrooms;
  final double size;
  final String address;
  final String? latitude;
  final String? longitude;
  final bool isFavorited;
  final bool isRental;
  final List<String> features;
  final String type;
  final List<String> amenities;
  final List<String> nearbyPlaces;
  final List<String> virtualTourUrls;
  final DateTime datePosted;
  final DateTime dateModified;
  final String agentName;
  final String agentPhone;
  final String agentEmail;
  final bool isFeatured;
  final String? currency;
  final String? neighborhood;
  final String? city;
  final String? country;
  final double? longitudeDelta;
  final double? latitudeDelta;
  final List<String> tags;
  final List<PropertyReview> reviews;
  final List<PropertyImage> propertyImages;
  final List<PropertyVideo> propertyVideos;
  final List<PropertyFeature> propertyFeatures;
  final PropertyLocation location;
  final PropertyAgent agent;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.videoUrls,
    required this.price,
    required this.rooms,
    required this.bathrooms,
    required this.size,
    required this.address,
    this.latitude,
    this.longitude,
    required this.isFavorited,
    required this.isRental,
    required this.features,
    required this.type,
    required,
    required this.amenities,
    required this.nearbyPlaces,
    required this.virtualTourUrls,
    required this.datePosted,
    required this.dateModified,
    required this.agentName,
    required this.agentPhone,
    required this.agentEmail,
    required this.isFeatured,
    this.currency,
    this.neighborhood,
    this.city,
    this.country,
    this.longitudeDelta,
    this.latitudeDelta,
    required this.tags,
    required this.reviews,
    required this.propertyImages,
    required this.propertyVideos,
    required this.propertyFeatures,
    required this.location,
    required this.agent,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    List<String> imageUrls = [];
    for (var imageUrl in json['imageUrls']) {
      imageUrls.add(imageUrl.toString());
    }
    List<String> videoUrls = [];
    for (var videoUrl in json['videoUrls']) {
      videoUrls.add(videoUrl.toString());
    }
    List<String> features = [];
    for (var feature in json['features']) {
      features.add(feature.toString());
    }
    List<String> amenities = [];
    for (var amenity in json['amenities']) {
      amenities.add(amenity.toString());
    }
    List<String> nearbyPlaces = [];
    for (var nearbyPlace in json['nearbyPlaces']) {
      nearbyPlaces.add(nearbyPlace.toString());
    }
    List<String> virtualTourUrls = [];
    for (var virtualTourUrl in json['virtualTourUrls']) {
      virtualTourUrls.add(virtualTourUrl.toString());
    }
    List<String> tags = [];
    for (var tag in json['tags']) {
      tags.add(tag.toString());
    }
    List<PropertyReview> reviews = [];
    for (var review in json['reviews']) {
      reviews.add(PropertyReview.fromJson(review));
    }
    List<PropertyImage> propertyImages = [];
    for (var propertyImage in json['propertyImages']) {
      propertyImages.add(PropertyImage.fromJson(propertyImage));
    }
    List<PropertyVideo> propertyVideos = [];
    for (var propertyVideo in json['propertyVideos']) {
      propertyVideos.add(PropertyVideo.fromJson(propertyVideo));
    }
    List<PropertyFeature> propertyFeatures = [];
    for (var propertyFeature in json['propertyFeatures']) {
      propertyFeatures.add(PropertyFeature.fromJson(propertyFeature));
    }
    return Property(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrls: imageUrls,
      videoUrls: videoUrls,
      price: json['price'],
      rooms: json['rooms'],
      bathrooms: json['bathrooms'],
      size: json['size'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isFavorited: json['isFavorited'],
      isRental: json['isRental'],
      features: features,
      type: json['type'],
      amenities: amenities,
      nearbyPlaces: nearbyPlaces,
      virtualTourUrls: virtualTourUrls,
      datePosted: DateTime.parse(json['datePosted']),
      dateModified: DateTime.parse(json['dateModified']),
      agentName: json['agentName'],
      agentPhone: json['agentPhone'],
      agentEmail: json['agentEmail'],
      isFeatured: json['isFeatured'],
      currency: json['currency'],
      neighborhood: json['neighborhood'],
      city: json['city'],
      country: json['country'],
      longitudeDelta: json['longitudeDelta'],
      latitudeDelta: json['latitudeDelta'],
      tags: tags,
      reviews: reviews,
      propertyImages: propertyImages,
      propertyVideos: propertyVideos,
      propertyFeatures: propertyFeatures,
      location: PropertyLocation.fromJson(json['location']),
      agent: PropertyAgent.fromJson(json['agent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrls': imageUrls,
      'videoUrls': videoUrls,
      'price': price,
      'rooms': rooms,
      'bathrooms': bathrooms,
      'size': size,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'isFavorited': isFavorited,
      'isRental': isRental,
      'features': features,
      'type': type,
      'amenities': amenities,
      'nearbyPlaces': nearbyPlaces,
      'virtualTourUrls': virtualTourUrls,
      'datePosted': datePosted.toIso8601String(),
      'dateModified': dateModified.toIso8601String(),
      'agentName': agentName,
      'agentPhone': agentPhone,
      'agentEmail': agentEmail,
      'isFeatured': isFeatured,
      'currency': currency,
      'neighborhood': neighborhood,
      'city': city,
      'country': country,
      'longitudeDelta': longitudeDelta,
      'latitudeDelta': latitudeDelta,
      'tags': tags,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'propertyImages': propertyImages.map((image) => image.toJson()).toList(),
      'propertyVideos': propertyVideos.map((video) => video.toJson()).toList(),
      'propertyFeatures':
          propertyFeatures.map((feature) => feature.toJson()).toList(),
      'location': location.toJson(),
      'agent': agent.toJson(),
    };
  }

  toList() {}
}

class PropertyFeature {
  final String name;
  final String? value;

  PropertyFeature({required this.name, this.value});

  factory PropertyFeature.fromJson(Map json) {
    return PropertyFeature(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class PropertyLocation {
  final String address;
  final String? latitude;
  final String? longitude;

  PropertyLocation({required this.address, this.latitude, this.longitude});

  factory PropertyLocation.fromJson(Map json) {
    return PropertyLocation(
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map toJson() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PropertyAgent {
  final String name;
  final String phone;
  final String email;
  final String? bio;
  final String? photoUrl;

  PropertyAgent(
      {required this.name,
      required this.phone,
      required this.email,
      this.bio,
      this.photoUrl});

  factory PropertyAgent.fromJson(Map json) {
    return PropertyAgent(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      bio: json['bio'],
      photoUrl: json['photoUrl'],
    );
  }

  Map toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'bio': bio,
      'photoUrl': photoUrl,
    };
  }
}

class PropertyReview {
  final String author;
  final String? authorImageUrl;
  final String text;
  final DateTime date;
  final int rating;

  PropertyReview(
      {required this.author,
      this.authorImageUrl,
      required this.text,
      required this.date,
      required this.rating});

  factory PropertyReview.fromJson(Map json) {
    return PropertyReview(
      author: json['author'],
      authorImageUrl: json['authorImageUrl'],
      text: json['text'],
      date: DateTime.parse(json['date']),
      rating: json['rating'],
    );
  }

  Map toJson() {
    return {
      'author': author,
      'authorImageUrl': authorImageUrl,
      'text': text,
      'date': date.toIso8601String(),
      'rating': rating,
    };
  }
}

class PropertyImage {
  final String url;

  PropertyImage({required this.url});

  factory PropertyImage.fromJson(Map json) {
    return PropertyImage(
      url: json['url'],
    );
  }

  Map toJson() {
    return {
      'url': url,
    };
  }
}

class PropertyVideo {
  final String url;

  PropertyVideo({required this.url});

  factory PropertyVideo.fromJson(Map json) {
    return PropertyVideo(
      url: json['url'],
    );
  }

  Map toJson() {
    return {
      'url': url,
    };
  }
}
