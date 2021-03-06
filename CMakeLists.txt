cmake_minimum_required(VERSION 2.8)

PROJECT(distcc)

LIST(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

IF (WIN32)
    MESSAGE(STATUS "Now is windows")

    SET(DMOS_NAME "win")

    SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" )
    IF(MSVC)
        ADD_DEFINITIONS(/bigobj)
        ADD_COMPILE_OPTIONS(/W3 /wd4005 /wd4068 /wd4244 /wd4267 /wd4800)
        ADD_DEFINITIONS(/DNOMINMAX /DWIN32_LEAN_AND_MEAN=1 /D_CRT_SECURE_NO_WARNINGS /D_SCL_SECURE_NO_WARNINGS)
        IF (MSVC_VERSION GREATER_EQUAL 1900)
            INCLUDE(CheckCXXCompilerFlag)
            CHECK_CXX_COMPILER_FLAG("/std:c++latest" _cpp_latest_flag_supported)
            IF (_cpp_latest_flag_supported)
                ADD_COMPILE_OPTIONS("/std:c++latest")
            ENDIF()
    	ENDIF()
    ENDIF()
ELSEIF (APPLE)
    MESSAGE(STATUS "Now is Apple systems")  

    SET(DMOS_NAME "mac") 

    SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -pthread" )
ELSEIF (UNIX)
    MESSAGE(STATUS "Now is UNIX-like OS")  
 
    SET(DMOS_NAME "lin") 
    
    SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -pthread" )    
ENDIF ()

ADD_DEFINITIONS(-DUSE_DISTCC)

ADD_SUBDIRECTORY(thirdparty/dmlog)

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/dmlog/include)
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/dmlog/src)
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/dmlog/test)

IF (WIN32)
    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/src/windows)
ENDIF(WIN32)

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/)
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/include)
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/src)
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/test)

LINK_DIRECTORIES(${CMAKE_SOURCE_DIR}/lib)

SET(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)
SET(LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib)

FILE(GLOB_RECURSE DISTCC_SOURCES
${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp
${CMAKE_CURRENT_SOURCE_DIR}/include/*.h

${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
${CMAKE_CURRENT_SOURCE_DIR}/src/*.cc
${CMAKE_CURRENT_SOURCE_DIR}/src/*.c
${CMAKE_CURRENT_SOURCE_DIR}/src/*.hpp
${CMAKE_CURRENT_SOURCE_DIR}/src/*.h
)

IF (WIN32)
    LIST(APPEND DISTCC_SOURCES)
ENDIF(WIN32)

FILE(GLOB_RECURSE DISTCCTEST_SOURCES
${CMAKE_CURRENT_SOURCE_DIR}/test/*.cpp
${CMAKE_CURRENT_SOURCE_DIR}/test/*.cc
${CMAKE_CURRENT_SOURCE_DIR}/test/*.c
${CMAKE_CURRENT_SOURCE_DIR}/test/*.hpp
${CMAKE_CURRENT_SOURCE_DIR}/test/*.h)

IF (WIN32)
    ADD_LIBRARY(distcc STATIC ${DISTCC_SOURCES})
    ADD_EXECUTABLE(distcctest ${DISTCCTEST_SOURCES})
    TARGET_LINK_LIBRARIES(distcctest distcc)
ELSEIF (APPLE)
    ADD_LIBRARY(distcc STATIC ${DISTCC_SOURCES})
    ADD_EXECUTABLE(distcctest ${DISTCCTEST_SOURCES})
    TARGET_LINK_LIBRARIES(distcctest distcc)
ELSEIF (UNIX)
    ADD_LIBRARY(distcc STATIC ${DISTCC_SOURCES})
    ADD_EXECUTABLE(distcctest ${DISTCCTEST_SOURCES})
    TARGET_LINK_LIBRARIES(distcctest distcc)
ENDIF ()

#ADD_CUSTOM_COMMAND(
#TARGET distcctest
#PRE_BUILD
#COMMAND ${CMAKE_COMMAND} -E copy_if_different
#${CMAKE_CURRENT_SOURCE_DIR}/config/test.csv
#$<TARGET_FILE_DIR:distcctest>
#)

#INSTALL(DIRECTORY include/ DESTINATION include)
#INSTALL(TARGETS distcc
#        RUNTIME DESTINATION bin
#        LIBRARY DESTINATION lib
#        ARCHIVE DESTINATION lib)

#SET(DISTCC_LIBS "distcc")
#MARK_AS_ADVANCED(${DISTCC_LIBS})