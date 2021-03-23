// SPDX-License-Identifier: MIT
// This file is part of `openmm-dlext`, see LICENSE.md

#ifndef OPENMM_DLEXT_FORCE_H_
#define OPENMM_DLEXT_FORCE_H_


#include "cxx11utils.h"

#include "openmm/Force.h"


namespace DLExt
{


using namespace cxx11utils;

//
//  This class is meant to provide DLPack wrappers around the particle data of an OpenMM
//  Simulation, but not to perform any direct computation. Instead, it provides a callback
//  interface to access and modify the simulation externally.
//
class DEFAULT_VISIBILITY Force : public OpenMM::Force {
public:
    bool usesPeriodicBoundaryConditions() const;
    void addTo(OpenMM::Context& context, OpenMM::System& system);
    void setCallbackIn(OpenMM::Context& context, Function<void>& callback);
protected:
    OpenMM::ForceImpl* createImpl() const;
private:
    bool uses_periodic_bc = true;
};


}  // namespace DLExt


#endif  // OPENMM_DLEXT_FORCE_H_
