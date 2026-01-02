plugins {
    kotlin("jvm") version "1.9.25"
}

group = "pt.isel.daw"
version = "unspecified"

repositories {
    mavenCentral()
}

dependencies {
    // To use Named annotation for Dependency Injection
    implementation("jakarta.inject:jakarta.inject-api:2.0.1")

    // To get password encode
    api("org.springframework.security:spring-security-core:6.3.0")

    // To use Kotlin specific date and time functions
    implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.4.1")

    testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")
}

tasks.test {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(21)
}