
qt6_add_library(Widgets STATIC)

qt6_add_qml_module(Widgets
    URI "Widgets"
    VERSION 1.0
    RESOURCE_PREFIX
        /
    QML_FILES
        ToolbarButton.ui.qml
)

target_link_libraries(Widgets PRIVATE
    Utilsplugin
)

