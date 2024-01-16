# System config
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_PROCESSOR amd64)

# Prevent compiler test from failing due to linker (not sure if we still need this tbh)
SET(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Compiler config
SET(CLANG_TARGET_TRIPLE x86_64-linux-gnu)

SET(CMAKE_C_COMPILER clang)
SET(CMAKE_C_COMPILER_TARGET ${CLANG_TARGET_TRIPLE})
SET(CMAKE_CXX_COMPILER clang++)
SET(CMAKE_CXX_COMPILER_TARGET ${CLANG_TARGET_TRIPLE})

# Package config
SET(CMAKE_LIBRARY_ARCHITECTURE x86_64-linux-gnu)

# Some misc stuff
SET(CPACK_DEBIAN_PACKAGE_ARCHITECTURE amd64)
