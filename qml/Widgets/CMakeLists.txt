
qt6_add_library(Widgets STATIC)

qt6_add_qml_module(Widgets
    URI Widgets
    VERSION 1.0
    QML_FILES
        AppMenuBar.qml
        AppMenu.qml
        AppMenuSeparator.qml
    RESOURCES
        assets/toolbar/ToolbarBackground.png
)
