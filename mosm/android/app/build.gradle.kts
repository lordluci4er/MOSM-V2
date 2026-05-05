import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// 🔐 Load key.properties
val keystoreProperties = Properties()
val keystoreFile = rootProject.file("key.properties")

if (!keystoreFile.exists()) {
    throw GradleException("❌ key.properties file missing in android/")
}

keystoreProperties.load(FileInputStream(keystoreFile))

android {
    namespace = "com.mosm"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.mosm"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
                ?: throw GradleException("❌ keyAlias missing")

            keyPassword = keystoreProperties.getProperty("keyPassword")
                ?: throw GradleException("❌ keyPassword missing")

            storePassword = keystoreProperties.getProperty("storePassword")
                ?: throw GradleException("❌ storePassword missing")

            storeFile = file(
                keystoreProperties.getProperty("storeFile")
                    ?: throw GradleException("❌ storeFile missing")
            )
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.12.0"))
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
}