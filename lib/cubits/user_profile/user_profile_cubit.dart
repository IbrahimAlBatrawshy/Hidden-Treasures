import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_profile_state.dart';

class UserProfileCubit extends HydratedCubit<UserProfileState> {
  final FirebaseAuth _auth;

  UserProfileCubit({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance,
        super(const UserProfileState()) {
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final user = _auth.currentUser;
    if (user != null) {
      emit(UserProfileState(
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
        bookingsCount: state.bookingsCount,
        reviewsCount: state.reviewsCount,
      ));
    }
  }

  Future<void> updateDisplayName(String name) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _auth.currentUser?.updateDisplayName(name);
      emit(state.copyWith(displayName: name, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future<void> updatePhotoUrl(String url) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _auth.currentUser?.updatePhotoURL(url);
      emit(state.copyWith(photoUrl: url, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  void incrementBookings() {
    emit(state.copyWith(bookingsCount: state.bookingsCount + 1));
  }

  void incrementReviews() {
    emit(state.copyWith(reviewsCount: state.reviewsCount + 1));
  }

  void updateProfile({
    String? displayName,
    String? email,
    String? photoUrl,
  }) {
    emit(state.copyWith(
      displayName: displayName,
      email: email,
      photoUrl: photoUrl,
    ));
  }

  void clearProfile() {
    emit(const UserProfileState());
  }

  void refreshFromFirebase() {
    _loadUserProfile();
  }

  @override
  UserProfileState? fromJson(Map<String, dynamic> json) {
    try {
      return UserProfileState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserProfileState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
