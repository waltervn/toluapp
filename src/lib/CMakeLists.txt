add_library(libtolua++
	tolua_event.c
	tolua_is.c
	tolua_map.c
	tolua_push.c
	tolua_to.c
)

target_link_libraries(libtolua++
	"${LUA_LIBRARY}"
)

set_target_properties(libtolua++ PROPERTIES OUTPUT_NAME "tolua++")
