add_subdirectory(modules)

qt6_add_executable(${CMAKE_PROJECT_NAME}
    main.cpp
)

qt6_add_resources(${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

qt_add_resources(${CMAKE_PROJECT_NAME} "assets"
    PREFIX "/"
    FILES
        assets/logo.ico
)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Gui
    animboom-toolkit
)
