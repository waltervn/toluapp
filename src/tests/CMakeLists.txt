include_directories(
	"${CMAKE_CURRENT_SOURCE_DIR}"
)

function(build_test FILE)
	get_filename_component(BASE "${FILE}" NAME_WE)
	get_filename_component(EXT "${FILE}" EXT)

	if("${EXT}" STREQUAL ".pkg")
		set(BIND_EXT ".c")
	else()
		set(BIND_EXT "${EXT}")
	endif()

	add_custom_command(OUTPUT
		"${CMAKE_CURRENT_BINARY_DIR}/${BASE}bind${BIND_EXT}"
		COMMAND tolua++ -1 -o "${CMAKE_CURRENT_BINARY_DIR}/${BASE}bind${BIND_EXT}" "${BASE}.pkg"
		DEPENDS tolua++ "${BASE}.pkg"
		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
	)

	set(SRCS "${BASE}bind${BIND_EXT}")

	if (NOT "${EXT}" STREQUAL "pkg")
		list(APPEND SRCS "${FILE}")
	endif()

	add_executable("${BASE}"
		${SRCS}
	)

	target_link_libraries("${BASE}"
		libtolua++
		${LUA_LIBRARY}
	)

	add_test(NAME "${BASE}"
		COMMAND "${CMAKE_BINARY_DIR}/bin/${BASE}"
		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
	)
endfunction()

if(BUILD_TESTING)
	build_test("tvariable.c")
	build_test("tconstant.cpp")
	build_test("tfunction.cpp")
	build_test("tmodule.c")
	build_test("tdirective.pkg")
endif()
