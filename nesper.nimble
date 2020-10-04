# Package

version       = "0.1.0"
author        = "Jaremy Creechley"
description   = "Nim wrappers for ESP-IDF (ESP32)"
license       = "Apache-2.0"
srcDir        = "src"


# Dependencies

requires "nim >= 1.2.0"


# Tasks
task test, "Runs the test suite":
  exec "nim c --os:freertos tests/tnvs.nim"

