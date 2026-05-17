plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

dependencies {
    implementation(
        platform(
            "com.google.firebase:firebase-bom:34.13.0"
        )
    )

    implementation(
        "com.google.firebase:firebase-analytics"
    )
}

android {
    namespace =
        "com.example.pennywise"

    compileSdk =
        flutter.compileSdkVersion

    ndkVersion =
        flutter.ndkVersion

    compileOptions {
        sourceCompatibility =
            JavaVersion.VERSION_17

        targetCompatibility =
            JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget =
            JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId =
            "com.example.pennywise"

        minSdk = flutter.minSdkVersion

        targetSdk =
            flutter.targetSdkVersion

        versionCode =
            flutter.versionCode

        versionName =
            flutter.versionName
    }

    buildTypes {
        release {
            signingConfig =
                signingConfigs
                    .getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
