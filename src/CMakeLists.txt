add_subdirectory(modules)

qt6_add_executable(${CMAKE_PROJECT_NAME}
    main.cpp
)

qt6_add_resources(${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

qt6_add_resources(${CMAKE_PROJECT_NAME} "assets"
    PREFIX "/"
    FILES
        assets/icons/logo.ico
)

qt6_add_qml_module(${CMAKE_PROJECT_NAME}
    URI Main
    VERSION 1.0
    NO_PLUGIN
    RESOURCE_PREFIX
        /
    IMPORT_PATH
        ${CMAKE_BINARY_DIR}
    QML_FILES
        main.qml
)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    animboom-toolkit
    Assetsplugin
    QmlContentplugin
    Utilsplugin
    Logicplugin
)
