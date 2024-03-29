plugins {
    kotlin("jvm") version "1.8.0"
    application
}

group = "me.ilian"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("io.github.palex65:CanvasLib-jvm:1.0.2")
    testImplementation(kotlin("test"))
}

kotlin {
    jvmToolchain(11)
}

application {
    mainClass.set("MainKt")
}