# RiderLinkPH User App — ProGuard Rules
# Flutter + Firebase + manual fromJson model classes
#
# Conservative baseline — expand only when specific packages break at runtime.

# ── Flutter ──────────────────────────────────────────────────────────────────
# FlutterEngine, Widgets, Services, etc.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**    { *; }
-keep class io.flutter.view.**    { *; }
-keep class io.flutter.**         { *; }
-keep class io.flutter.plugins.** { *; }

# ── Firebase / Google Play Services ──────────────────────────────────────────
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# ── GetX (DI / routing) ──────────────────────────────────────────────────────
-keep class com.google.okhttp.** { *; }
-keep class dev.fluttercommunity.** { *; }

# ── JSON / model classes ─────────────────────────────────────────────────────
# The app uses manual fromJson(Map) / toJson() on plain Dart classes.
# ProGuard strips class members by name when minifying. Because fromJson is
# a named constructor, it is preserved by default. However, if any model
# class is only referenced via its interface (e.g. stored as Object or
# dynamic), the entire class may be tree-shaken. To prevent that, add a
# -keep for each model class you define here, e.g.:
#
#   -keep class ride_sharing_user_app.features.ride.domain.models.** { *; }
#
# When a deserialization crash appears in a release build, uncomment the
# relevant domain group above or add the specific class name.

# ── Google Maps ──────────────────────────────────────────────────────────────
-keep class com.google.android.gms.maps.** { *; }
-keep class com.google.android.gms.location.** { *; }

# ── HTTP / networking ────────────────────────────────────────────────────────
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# ── Flutter local notifications ──────────────────────────────────────────────
-keep class com.dexterous.** { *; }

# ── General ──────────────────────────────────────────────────────────────────
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.**
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses