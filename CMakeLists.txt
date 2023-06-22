cmake_minimum_required(VERSION 3.16)

project(AnimBoom VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# TODO: Change it to target_compile_options
if(MSVC)
    add_compile_options(/W3 /WX)
else()
    add_compile_options(-Wall -Wextra -Werror)
endif()

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(AnimBoomDesigner
    main.cpp
)

qt_add_qml_module(AnimBoomDesigner
    URI AnimBoom
    VERSION 1.0
    QML_FILES Main.qml
)

set_target_properties(AnimBoomDesigner PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER animboom.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(AnimBoomDesigner
    PRIVATE Qt6::Quick
)

install(TARGETS AnimBoomDesigner
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
