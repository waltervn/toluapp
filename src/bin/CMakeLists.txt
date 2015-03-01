add_executable(tolua++_bootstrap
	tolua.c
	toluabind_default.c
)

target_link_libraries(tolua++_bootstrap
	libtolua++
	"${LUA_LIBRARY}"
)

add_custom_command(OUTPUT
	"${CMAKE_CURRENT_BINARY_DIR}/toluabind.c"
	COMMAND tolua++_bootstrap -C -o "${CMAKE_CURRENT_BINARY_DIR}/toluabind.c" "${PROJECT_SOURCE_DIR}/src/bin/tolua.pkg"
	DEPENDS tolua++_bootstrap
	WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
)

add_executable(tolua++
	tolua.c
	toluabind.c
)

target_link_libraries(tolua++
	libtolua++
	"${LUA_LIBRARY}"
)
