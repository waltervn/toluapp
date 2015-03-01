if(BUILD_TESTING)
	add_custom_command(OUTPUT
		"${CMAKE_CURRENT_BINARY_DIR}/tvariablebind.c"
		COMMAND tolua++ -o "${CMAKE_CURRENT_BINARY_DIR}/tvariablebind.c" tvariable.pkg
		DEPENDS tolua++
		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
	)

	include_directories(
		"${CMAKE_CURRENT_SOURCE_DIR}"
	)

	add_executable(tvariable
		tvariable.c
		tvariablebind.c
	)

	target_link_libraries(tvariable
		libtolua++
		${LUA_LIBRARY}
	)

	add_test(NAME Variable
		COMMAND "${CMAKE_BINARY_DIR}/bin/tvariable"
		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
	)
endif()
