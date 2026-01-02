plugins {
    kotlin("jvm") version "1.9.25"
}

group = "pt.isel.daw"
version = "unspecified"

repositories {
    mavenCentral()
}

dependencies {
    api(project(":domain"))
    api(project(":repository"))

    implementation("jakarta.inject:jakarta.inject-api:2.0.1")
    implementation("jakarta.annotation:jakarta.annotation-api:2.1.1")
    implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.4.1")
    // for JDBI
    testImplementation("org.postgresql:postgresql:42.7.2")
    // for logging
    implementation("org.slf4j:slf4j-api:2.0.16")

    testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")
    testImplementation("org.junit.jupiter:junit-jupiter-api:5.10.0")
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:5.10.0")
}

tasks.test {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(21)
}