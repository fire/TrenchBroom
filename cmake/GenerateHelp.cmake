# Generate help documents
SET(DOC_DIR "${CMAKE_SOURCE_DIR}/app/resources/documentation")
SET(DOC_HELP_SOURCE_DIR "${DOC_DIR}/help")
SET(DOC_HELP_TARGET_DIR "${CMAKE_CURRENT_BINARY_DIR}/gen-help")

SET(PANDOC_TEMPLATE_PATH "${DOC_HELP_SOURCE_DIR}/template.html")
SET(PANDOC_INPUT_PATH    "${DOC_HELP_SOURCE_DIR}/index.md")
SET(PANDOC_OUTPUT_PATH   "${DOC_HELP_TARGET_DIR}/index.html")

FIX_WIN32_PATH(PANDOC_TEMPLATE_PATH)
FIX_WIN32_PATH(PANDOC_INPUT_PATH)
FIX_WIN32_PATH(PANDOC_OUTPUT_PATH)

ADD_CUSTOM_COMMAND(OUTPUT "${DOC_HELP_TARGET_DIR}"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${DOC_HELP_TARGET_DIR}"
)

ADD_CUSTOM_COMMAND(OUTPUT "${DOC_HELP_TARGET_DIR}/index.html"
    COMMAND pandoc -s --toc --toc-depth=2 --template "${PANDOC_TEMPLATE_PATH}" -o "${PANDOC_OUTPUT_PATH}" "${PANDOC_INPUT_PATH}"
    COMMAND ${CMAKE_COMMAND} -DINPUT="${DOC_HELP_TARGET_DIR}/index.html" -DOUTPUT="${DOC_HELP_TARGET_DIR}/index.html" -P "${CMAKE_SOURCE_DIR}/cmake/TransformKeyboardShortcuts.cmake"
    DEPENDS "${DOC_HELP_TARGET_DIR}"
)

SET(DOC_HELP_TARGET_FILES "${DOC_HELP_TARGET_DIR}/index.html")

FILE(GLOB_RECURSE DOC_HELP_SOURCE_FILES
    "${DOC_HELP_SOURCE_DIR}/images/*.png"
    "${DOC_HELP_SOURCE_DIR}/*.css"
    "${DOC_HELP_SOURCE_DIR}/*.js"
)

FOREACH(HELP_FILE ${DOC_HELP_SOURCE_FILES})
	GET_FILENAME_COMPONENT(HELP_FILE_NAME "${HELP_FILE}" NAME)
	SET(DOC_HELP_TARGET_FILES 
		${DOC_HELP_TARGET_FILES}
		"${DOC_HELP_TARGET_DIR}/${HELP_FILE_NAME}"
	)

	ADD_CUSTOM_COMMAND(OUTPUT "${DOC_HELP_TARGET_DIR}/${HELP_FILE_NAME}"
		COMMAND ${CMAKE_COMMAND} -E copy ${HELP_FILE} "${DOC_HELP_TARGET_DIR}"
	)
ENDFOREACH(HELP_FILE)

ADD_CUSTOM_TARGET(GenerateHelp DEPENDS ${DOC_HELP_TARGET_FILES})
