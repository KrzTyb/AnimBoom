
qt6_add_library(QmlContent STATIC)
qt6_add_qml_module(QmlContent
    URI "QmlContent"
    VERSION 1.0
    IMPORT_PATH
        ${CMAKE_BINARY_DIR}/QmlImports
    QML_FILES
        App.qml
        MainView.ui.qml

        # Widgets
        Widgets/AppMenu.ui.qml
        Widgets/AppMenuBar.qml
        Widgets/AppMenuBarForm.ui.qml
        Widgets/AppMenuSeparator.ui.qml

        # Delegates
        Delegates/MenuBarDelegate.ui.qml
        Delegates/MenuDelegate.ui.qml
)
