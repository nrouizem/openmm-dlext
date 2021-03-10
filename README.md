OpenMM-dlext
------------

The plugin is intended to provide a `OpenMM::Force` derived class that does no direct
computation, but instead uses [DLPack](https://github.com/dmlc/dlpack) wrappers around CPU
or GPU `OpenMM::Platform` data for an initialized instance of `OpenMM::Contex`, and a
callback interface to perform computations on such data outside the plugin.

## Usage

The wrappers around the simulation data are intended to be instantiated after the
`OpenMM::ContextImpl` for a particular simulation has been created.

Given that forces are instantiated after `OpenMM::ContextImpl` creation, if any
`DLExtForce` is added to a `OpenMM::System` after a simulation has been set, the original
`OpenMM::Context` needs to be reintialized before perfoming any computation that is
intended to make use of the plugin.
