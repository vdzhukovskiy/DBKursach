cmake_minimum_required(VERSION 3.16)

project(DBKursach VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS
   Quick
   Sql
   QuickControls2
)

qt_standard_project_setup()

set(CMAKE_AUTORCC ON)

qt_add_executable(appDBKursach
    src/main.cpp
    assets.qrc
)

qt_add_qml_module(appDBKursach
    URI DBKursach
    VERSION 1.0
    QML_FILES
    qml/Main.qml
    qml/Constants.qml
    SOURCES src/dbconnector.h src/dbconnector.cpp
    RESOURCES qml/qmldir
    QML_FILES qml/MyButton.qml
    RESOURCES assets.qrc
    QML_FILES qml/LauncherScreen.qml
    SOURCES sqltablemodel.h sqltablemodel.cpp
    # QML_FILES Constants.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appDBKursach PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appDBKursach
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appDBKursach
    PRIVATE
    Qt6::Quick
    Qt6::Qml
    Qt6::Sql
    Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS appDBKursach
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
