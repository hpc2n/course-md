#!/bin/bash
#SBATCH -A *FIXME*
#Asking for 10 min.
#SBATCH -t 00:10:00
#Number of nodes
#SBATCH -N 1
#Ask for processes
#SBATCH -n 28
#SBATCH --gres=gpu:k80:2
#SBATCH --exclusive

ml purge > /dev/null 2>&1
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 
namd2 +p28 config-file.inp > output_gpu.dat
