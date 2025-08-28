cmake_minimum_required(VERSION 3.16)

project(Taskspace VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Charts WebEngineQuick)

qt_standard_project_setup(REQUIRES 6.5)
set(CMAKE_WIN32_EXECUTABLE TRUE)
set(app_icon_resource_windows "${CMAKE_CURRENT_SOURCE_DIR}/icons/taskspace.rc")

#--------------------------------------------------
# 1. Define the executable and QML module
#--------------------------------------------------
qt_add_executable(TaskSpace
  main.cpp
  ${app_icon_resource_windows}
)

qt_add_qml_module(TaskSpace
  URI Taskspace
  VERSION 1.0
  QML_FILES
  Main.qml
    qml/SideMenu.qml
    qml/SideBarButton.qml
    qml/Tasks/Tasks.qml
    qml/Habits/Habits.qml
    qml/qmldir
    qml/AppData.qml
    qml/Habits/HabitPart.qml
    qml/Habits/HabitDialog.qml
    qml/Habits/HabitCategory.qml
    qml/Habits/HabitButton.qml
    qml/Weather/Weather.qml
    qml/Weather/WeatherForecastC.qml
    qml/Weather/WeatherChart.qml
    qml/Weather/WeatherDailySummartyC.qml
    qml/Weather/WeatherAirConditionC.qml
    qml/Tasks/DatePick.qml
  SOURCES
    weatherapi.h
    weatherapi.cpp
    localstorage.h
    localstorage.cpp
  RESOURCES
    icons/accept.png
    icons/add.png
    icons/arrow_back.png
    icons/arrow_next.png
    icons/close.png
    icons/cooking.png
    icons/creativity.png
    icons/detoxdigital.png
    icons/edit.png
    icons/exercise.png
    icons/exit.png
    icons/financialplanning.png
    icons/habit.png
    icons/health.png
    icons/mediation.png
    icons/menu.png
    icons/news.png
    icons/nutrition.png
    icons/organization.png
    icons/quitbadhabit.png
    icons/reading.png
    icons/remove.png
    icons/selfcare.png
    icons/social.png
    icons/sports.png
    icons/studying.png
    icons/tasks.png
    icons/timemanagement.png
    icons/timer.png
    icons/today.png
    icons/volotrring.png
    icons/weather.png
    icons/right_side.png
    icons/star_empty.png
    icons/star_full.png
    icons/bin.png
    icons/music_player.png
    icons/finance.png
    icons/youtube.png
    icons/music.png
    font/ProtestGuerrilla-Regular.ttf
    font/PoorStory-Regular.ttf
    font/RobotoMono-Regular.ttf
    font/IntelOneMono-VariableFont_wght.ttf
    icons/weatherImages/weatherIcons/day/113.png
    icons/weatherImages/weatherIcons/day/116.png
    icons/weatherImages/weatherIcons/day/119.png
    icons/weatherImages/weatherIcons/day/122.png
    icons/weatherImages/weatherIcons/day/143.png
    icons/weatherImages/weatherIcons/day/176.png
    icons/weatherImages/weatherIcons/day/179.png
    icons/weatherImages/weatherIcons/day/182.png
    icons/weatherImages/weatherIcons/day/185.png
    icons/weatherImages/weatherIcons/day/200.png
    icons/weatherImages/weatherIcons/day/227.png
    icons/weatherImages/weatherIcons/day/230.png
    icons/weatherImages/weatherIcons/day/248.png
    icons/weatherImages/weatherIcons/day/260.png
    icons/weatherImages/weatherIcons/day/263.png
    icons/weatherImages/weatherIcons/day/266.png
    icons/weatherImages/weatherIcons/day/281.png
    icons/weatherImages/weatherIcons/day/284.png
    icons/weatherImages/weatherIcons/day/293.png
    icons/weatherImages/weatherIcons/day/296.png
    icons/weatherImages/weatherIcons/day/299.png
    icons/weatherImages/weatherIcons/day/302.png
    icons/weatherImages/weatherIcons/day/305.png
    icons/weatherImages/weatherIcons/day/308.png
    icons/weatherImages/weatherIcons/day/311.png
    icons/weatherImages/weatherIcons/day/314.png
    icons/weatherImages/weatherIcons/day/317.png
    icons/weatherImages/weatherIcons/day/320.png
    icons/weatherImages/weatherIcons/day/323.png
    icons/weatherImages/weatherIcons/day/326.png
    icons/weatherImages/weatherIcons/day/329.png
    icons/weatherImages/weatherIcons/day/332.png
    icons/weatherImages/weatherIcons/day/335.png
    icons/weatherImages/weatherIcons/day/338.png
    icons/weatherImages/weatherIcons/day/350.png
    icons/weatherImages/weatherIcons/day/353.png
    icons/weatherImages/weatherIcons/day/356.png
    icons/weatherImages/weatherIcons/day/359.png
    icons/weatherImages/weatherIcons/day/362.png
    icons/weatherImages/weatherIcons/day/365.png
    icons/weatherImages/weatherIcons/day/368.png
    icons/weatherImages/weatherIcons/day/371.png
    icons/weatherImages/weatherIcons/day/374.png
    icons/weatherImages/weatherIcons/day/377.png
    icons/weatherImages/weatherIcons/day/386.png
    icons/weatherImages/weatherIcons/day/389.png
    icons/weatherImages/weatherIcons/day/392.png
    icons/weatherImages/weatherIcons/day/395.png
    icons/weatherImages/weatherIcons/night/113.png
    icons/weatherImages/weatherIcons/night/116.png
    icons/weatherImages/weatherIcons/night/119.png
    icons/weatherImages/weatherIcons/night/122.png
    icons/weatherImages/weatherIcons/night/143.png
    icons/weatherImages/weatherIcons/night/176.png
    icons/weatherImages/weatherIcons/night/179.png
    icons/weatherImages/weatherIcons/night/182.png
    icons/weatherImages/weatherIcons/night/185.png
    icons/weatherImages/weatherIcons/night/200.png
    icons/weatherImages/weatherIcons/night/227.png
    icons/weatherImages/weatherIcons/night/230.png
    icons/weatherImages/weatherIcons/night/248.png
    icons/weatherImages/weatherIcons/night/260.png
    icons/weatherImages/weatherIcons/night/263.png
    icons/weatherImages/weatherIcons/night/266.png
    icons/weatherImages/weatherIcons/night/281.png
    icons/weatherImages/weatherIcons/night/284.png
    icons/weatherImages/weatherIcons/night/293.png
    icons/weatherImages/weatherIcons/night/296.png
    icons/weatherImages/weatherIcons/night/299.png
    icons/weatherImages/weatherIcons/night/302.png
    icons/weatherImages/weatherIcons/night/305.png
    icons/weatherImages/weatherIcons/night/308.png
    icons/weatherImages/weatherIcons/night/311.png
    icons/weatherImages/weatherIcons/night/314.png
    icons/weatherImages/weatherIcons/night/317.png
    icons/weatherImages/weatherIcons/night/320.png
    icons/weatherImages/weatherIcons/night/323.png
    icons/weatherImages/weatherIcons/night/326.png
    icons/weatherImages/weatherIcons/night/329.png
    icons/weatherImages/weatherIcons/night/332.png
    icons/weatherImages/weatherIcons/night/335.png
    icons/weatherImages/weatherIcons/night/338.png
    icons/weatherImages/weatherIcons/night/350.png
    icons/weatherImages/weatherIcons/night/353.png
    icons/weatherImages/weatherIcons/night/356.png
    icons/weatherImages/weatherIcons/night/359.png
    icons/weatherImages/weatherIcons/night/362.png
    icons/weatherImages/weatherIcons/night/365.png
    icons/weatherImages/weatherIcons/night/368.png
    icons/weatherImages/weatherIcons/night/371.png
    icons/weatherImages/weatherIcons/night/374.png
    icons/weatherImages/weatherIcons/night/377.png
    icons/weatherImages/weatherIcons/night/386.png
    icons/weatherImages/weatherIcons/night/389.png
    icons/weatherImages/weatherIcons/night/392.png
    icons/weatherImages/weatherIcons/night/395.png
    icons/weatherImages/cloudcover.png
    icons/weatherImages/humidity.png
    icons/weatherImages/pressure.png
    icons/weatherImages/wind.png
    icons/calendar.png
    icons/chain.png
    icons/iconI.ico
)

target_link_libraries(TaskSpace
  PRIVATE Qt6::Quick
  PRIVATE Qt6::Charts
  PRIVATE Qt6::WebEngineQuick
)

#--------------------------------------------------
# 2. Install rules for the executable and runtimes
#--------------------------------------------------
install(TARGETS TaskSpace
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

include(InstallRequiredSystemLibraries)
if(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS)
  install(
    PROGRAMS ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS}
    DESTINATION ${CMAKE_INSTALL_BINDIR}
  )
endif()
# Make sure GNUInstallDirs is in scope (so CMAKE_INSTALL_BINDIR is set)
include(GNUInstallDirs)

# Figure out where Qt shipped its WebEngineProcess.exe
get_target_property(_webengine_core_dll Qt6::WebEngineCore LOCATION)
get_filename_component(_qt_bin_dir "${_webengine_core_dll}" DIRECTORY)

# Copy it into your package's bin/ folder
install(
  PROGRAMS "${_qt_bin_dir}/QtWebEngineProcess.exe"
  DESTINATION "${CMAKE_INSTALL_BINDIR}"
)

#--------------------------------------------------
# 3. Deploy QML and platform-specific files
#--------------------------------------------------
qt_generate_deploy_app_script(
  TARGET TaskSpace
  OUTPUT_SCRIPT deploy_script
  NO_UNSUPPORTED_PLATFORM_ERROR
)
install(SCRIPT ${deploy_script})

qt_generate_deploy_qml_app_script(
  TARGET TaskSpace
  OUTPUT_SCRIPT deploy_script_qml
  NO_TRANSLATIONS
)
install(SCRIPT ${deploy_script_qml})

#--------------------------------------------------
# 4. CPack configuration
#--------------------------------------------------
set(CPACK_PACKAGE_NAME             "Taskspace")
set(CPACK_PACKAGE_VENDOR           "Taskspace")
set(CPACK_PACKAGE_VERSION_MAJOR    1)
set(CPACK_PACKAGE_VERSION_MINOR    0)
set(CPACK_PACKAGE_VERSION_PATCH    0)

# Installer icons
set(CPACK_NSIS_MUI_ICON            "${CMAKE_CURRENT_SOURCE_DIR}/icons/iconI.ico")
set(CPACK_NSIS_MUI_UNIICON         "${CMAKE_CURRENT_SOURCE_DIR}/icons/iconI.ico")
set(CPACK_NSIS_DISPLAY_NAME        "Taskspace")
set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "Taskspace")

# Create Start‑Menu and Desktop shortcuts
set(CPACK_PACKAGE_EXECUTABLES      "TaskSpace" "Taskspace")
set(CPACK_CREATE_DESKTOP_LINKS     "TaskSpace")
set(CPACK_NSIS_MODIFY_PATH         ON)

include(CPack)
