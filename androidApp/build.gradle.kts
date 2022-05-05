plugins {
    id("com.android.application")
    id("kotlin-android-extensions")
    kotlin("android")
    //kotlin("plugin.serialization")
}

android {
    compileSdk = 31
    defaultConfig {
        applicationId = "com.jetbrains.androidApp"
        minSdk = 21
        targetSdk = 31
        versionCode = 1
        versionName = "1.0"
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
}

dependencies {
    implementation(project(":shared"))
    implementation("com.google.android.material:material:1.5.0")
    implementation("androidx.appcompat:appcompat:1.4.1")
    implementation("androidx.constraintlayout:constraintlayout:2.1.3")
    implementation("androidx.recyclerview:recyclerview:1.2.1")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.6.0-native-mt")
    implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.3.2")
}