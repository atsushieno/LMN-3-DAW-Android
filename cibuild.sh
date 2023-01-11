#!/bin/bash

cd external/LMN-3-DAW && patch -i ../../lmn-3-daw-android.patch -p1 && cd ../..
cd external/LMN-3-DAW/tracktion_engine && patch -i ../../../tracktion-android.patch -p1 && cd ../../..
./gradlew build

