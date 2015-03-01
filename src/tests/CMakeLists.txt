include_directories(
	"${CMAKE_CURRENT_SOURCE_DIR}"
)

function(build_test NAME FILE)
	get_filename_component(BASE "${FILE}" NAME_WE)
	get_filename_component(EXT "${FILE}" EXT)

	add_custom_command(OUTPUT
		"${CMAKE_CURRENT_BINARY_DIR}/${BASE}bind${EXT}"
		COMMAND tolua++ -1 -o "${CMAKE_CURRENT_BINARY_DIR}/${BASE}bind${EXT}" "${BASE}.pkg"
		DEPENDS tolua++ "${BASE}.pkg"
		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
	)

	add_executable("${BASE}"
		"${FILE}"
		"${BASE}bind${EXT}"
	)

	target_link_libraries("${BASE}"
		libtolua++
		${LUA_LIBRARY}
	)

	add_test(NAME "${NAME}"
		COMMAND "${CMAKE_BINARY_DIR}/bin/${BASE}"
		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
	)
endfunction()

if(BUILD_TESTING)
	build_test("Variable" "tvariable.c")
	build_test("Constant" "tconstant.cpp")
	build_test("Function" "tfunction.cpp")
endif()
