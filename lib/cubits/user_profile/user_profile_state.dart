import 'package:equatable/equatable.dart';

class UserProfileState extends Equatable {
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final int bookingsCount;
  final int reviewsCount;
  final bool isLoading;

  const UserProfileState({
    this.displayName,
    this.email,
    this.photoUrl,
    this.bookingsCount = 0,
    this.reviewsCount = 0,
    this.isLoading = false,
  });

  UserProfileState copyWith({
    String? displayName,
    String? email,
    String? photoUrl,
    int? bookingsCount,
    int? reviewsCount,
    bool? isLoading,
  }) {
    return UserProfileState(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bookingsCount: bookingsCount ?? this.bookingsCount,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        displayName,
        email,
        photoUrl,
        bookingsCount,
        reviewsCount,
        isLoading,
      ];

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'bookingsCount': bookingsCount,
      'reviewsCount': reviewsCount,
    };
  }

  factory UserProfileState.fromJson(Map<String, dynamic> json) {
    return UserProfileState(
      displayName: json['displayName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      bookingsCount: json['bookingsCount'] ?? 0,
      reviewsCount: json['reviewsCount'] ?? 0,
    );
  }
}
