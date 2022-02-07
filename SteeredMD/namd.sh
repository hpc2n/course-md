#!/bin/bash
#SBATCH -A *FIXME*
#Asking for 10 min.
#SBATCH -t 30:10:00
#Number of nodes
#SBATCH -N 1
#Ask for processes
#SBATCH -n 28
#SBATCH --exclusive
###Ask for 2 GPU cards
###SBATCH --gres=gpu:k80:2
###Load modules necessary for running NAMD
##module add GCC/5.4.0-2.26  CUDA/8.0.61_375.26  OpenMPI/2.0.2
##module add NAMD/2.12-nompi
###Execute NAMD
##namd2 +p28 meta.inp > output_meta_gpu.dat

ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-mpi 
mpirun -np 28 namd2 smd.inp > output_smd.dat
