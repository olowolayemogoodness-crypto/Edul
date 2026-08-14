# android/app/proguard-rules.pro
#
# R8 minification is being turned on for the first time (Play Console
# flagged it as a real, unaddressed optimization gap). Without keep
# rules, R8 commonly breaks reflection-based code in Firebase and
# Google Play Services SDKs silently -- the app builds fine, but auth
# or Firestore calls fail at runtime with no obvious error pointing
# back to R8. These rules cover Flutter itself plus every major SDK
# this app actually uses.

# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

# Firebase / Google Play Services (Auth, Firestore, Cloud Messaging)
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Google Sign-In
-keep class com.google.android.gms.auth.** { *; }

# AdMob
-keep class com.google.android.gms.ads.** { *; }
-dontwarn com.google.android.gms.ads.**

# Keep anything annotated with @Keep (common convention across these SDKs)
-keep class androidx.annotation.Keep
-keep @androidx.annotation.Keep class * { *; }
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <methods>;
}

# General Android
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable