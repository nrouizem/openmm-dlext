# Helper functions for FindOpenMM.cmake

function(find_openmm_with_python)
    find_package(Python QUIET COMPONENTS Interpreter)
    if(NOT Python_EXECUTABLE)
        return()
    endif()
    set(FIND_OpenMM_SCRIPT "
from __future__ import print_function;
import os
try:
    from simtk.openmm.version import openmm_library_path
    print(os.path.normpath(os.path.join(openmm_library_path, os.pardir)), end='')
except:
    print('', end='')"
    )
    execute_process(
        COMMAND ${Python_EXECUTABLE} -c "${FIND_OpenMM_SCRIPT}"
        OUTPUT_VARIABLE OpenMM_PATH
    )
    if(OpenMM_PATH)
        if(NOT OpenMM_ROOT)
            set(OpenMM_ROOT ${OpenMM_PATH} PARENT_SCOPE)
        endif()
        set(OpenMM_Python_EXECUTABLE ${Python_EXECUTABLE} PARENT_SCOPE)
    endif()
endfunction()

function(check_python_and_openmm)
    if(OpenMM_ROOT AND NOT OpenMM_Python_EXECUTABLE)
        if(NOT Python_EXECUTABLE)
            set(Python_EXECUTABLE "${OpenMM_ROOT}/bin/python")
        endif()
        find_openmm_with_python()
    endif()
    if(OpenMM_Python_EXECUTABLE AND (
        "${OpenMM_Python_EXECUTABLE}" STREQUAL "${Python_EXECUTABLE}"
    ))
        set(Python_EXECUTABLE ${OpenMM_Python_EXECUTABLE} PARENT_SCOPE)
        return()
    endif()
    message(FATAL_ERROR "Couldn't find a matching python installation for OpenMM")
endfunction()
