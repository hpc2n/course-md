# Setting up a Steered MD simulation (SMD) 

- Visualize the structure in the PDB file **box_water_nacl_eq.pdb**. This is a water box
  with one Na+ and one Cl- ions. They are approximately aligned in the X-direction.

- The goal of this exercise is that you generate a trajectory path that contains the
  Na-Cl ions at different separation distances. We will use this trajectory in the next
  section.

- The configuration file for running SMD is called **smd.inp**. The specific part for SMD
  within this file starts on line 130 with the "SMD on" instruction. SMD uses a reference file
  **smd.ref** in this case, to especify the atoms to which a steering force will be applied.

  **smd.ref** can be a copy of the initial PDB structure, the only thing that needs to be
  modified is the occupancy column of the steered atoms which needs to be labeled with a
  non-zero value. In the present case, because we will apply a force on the Na+ atom, you
  need to change its occupancy to 1.00, for instance.

  The force constant, the velocity, and the direction of the steering force can be set in the
  SMD section as well.

  If we steere only the Na+ ion, the Cl- ion will tend to move along and we will not observe
  Na-Cl at different separation distances. Because of this, we can use "constraints on"
  in the configuration file. This uses a reference file called **rest.ref** where the atoms
  that need to be constraint at their initial positions are especified in the occupancy 
  column as we did in **smd.ref**. Notice that here, the Cl- is the one that needs to change
  its occupancy (use 1.00).

  Run the script **smd.inp** for 50,000 steps in the direction 1 0 0 and the same amount of
  steps in the -1 0 0 direction. This will allow you to get Na-Cl separations longer and 
  shorter than the initial 5.3A separation of Na-Cl. The direction can be changed with the
  SMDDir option.
   
  Note: change the value of **outputName** for both simulations otherwise the outputs will be
  overwritten.


- Load the VMD modules on Kebnekaise:

```
```
