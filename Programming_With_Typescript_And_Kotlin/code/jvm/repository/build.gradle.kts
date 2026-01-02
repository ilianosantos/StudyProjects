plugins {
    kotlin("jvm") version "1.9.25"
}

group = "pt.isel.daw"
version = "unspecified"

repositories {
    mavenCentral()
}

dependencies {
    implementation(project(":domain"))

    api("org.jetbrains.kotlinx:kotlinx-datetime:0.4.1")
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")
}

tasks.test {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(21)
}