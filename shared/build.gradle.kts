plugins {
    kotlin("multiplatform")
    kotlin("plugin.serialization")
    id("com.android.library")
}

kotlin {
    android()

    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
        }
    }

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.0-native-mt")
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-core:1.3.2")
                implementation("io.ktor:ktor-client-core:1.6.8")
                implementation("io.ktor:ktor-client-serialization:1.6.8")
                implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.3.2")
                implementation("io.github.aakira:napier:2.4.0")
            }
        }
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test-common"))
                implementation(kotlin("test-annotations-common"))
            }
        }
        val androidMain by getting {
            dependencies {
                implementation("io.ktor:ktor-client-android:1.6.8")
                implementation("io.ktor:ktor-client-serialization:1.6.8")
                implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.3.2")
                implementation("io.github.aakira:napier:2.4.0")
            }
        }
        val androidTest by getting {
            dependencies {
                implementation(kotlin("test-junit"))
                implementation("junit:junit:4.13.2")
            }
        }
        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)

            dependencies {
                implementation("io.ktor:ktor-client-ios:1.6.8")
                implementation("io.ktor:ktor-client-serialization:1.6.8")
                implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.3.2")
                implementation("io.github.aakira:napier:2.4.0")
            }
        }
        val iosX64Test by getting
        val iosArm64Test by getting
        val iosSimulatorArm64Test by getting
        val iosTest by creating {
            dependsOn(commonTest)
            iosX64Test.dependsOn(this)
            iosArm64Test.dependsOn(this)
            iosSimulatorArm64Test.dependsOn(this)
        }
    }
}

android {
    compileSdk = 31
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    defaultConfig {
        minSdk = 21
        targetSdk = 31
    }
}