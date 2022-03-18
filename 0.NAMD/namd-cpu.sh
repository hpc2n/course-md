#!/bin/bash
#SBATCH -A *FIXME*
#Asking for 10 min.
#SBATCH -t 00:10:00
#Number of nodes
#SBATCH -N 1
#Ask for processes
#SBATCH -n 28

ml purge > /dev/null 2>&1
ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-mpi 
mpirun -np 28 namd2 config-file.inp > output_cpu.dat
