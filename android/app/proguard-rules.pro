-dontwarn com.cardtek.**
-dontwarn com.google.android.play.core.integrity.**
-dontwarn com.google.firebase.firestore.**
-dontwarn dalvik.system.VMDebug
-dontwarn okhttp3.**
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.**
-dontwarn orion.acquila.**
-dontwarn software.amazon.**

-keepclasseswithmembernames class * {
    native <methods>;
}

-keep class com.cardtek.** { *; }

# Giữ generic type cho Retrofit
-keepattributes Signature
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Retrofit interface (chứa @GET, @POST...)
-keep interface * {
    @retrofit2.http.* <methods>;
}

# Retrofit core
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }

# OkHttp/Okio
-dontwarn okhttp3.**
-keep class okhttp3.** { *; }
-dontwarn okio.**
-keep class okio.** { *; }
