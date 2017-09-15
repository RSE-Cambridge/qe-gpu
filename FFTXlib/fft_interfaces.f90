!
! Copyright (C) Quantum ESPRESSO group
!
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
!=---------------------------------------------------------------------------=!
MODULE fft_interfaces

  IMPLICIT NONE
  PRIVATE


  PUBLIC :: fwfft, fwfft_batch, invfft, invfft_batch

  
  INTERFACE invfft
     !! invfft is the interface to both the standard fft **invfft_x**,
     !! and to the "box-grid" version **invfft_b**, used only in CP 
     !! (the latter has an additional argument)
     
     SUBROUTINE invfft_x( grid_type, f, dfft, dtgs, howmany )
       USE fft_types,  ONLY: fft_type_descriptor
       USE task_groups,   ONLY: task_groups_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       CHARACTER(LEN=*),  INTENT(IN) :: grid_type
       TYPE(fft_type_descriptor), INTENT(IN) :: dfft
       TYPE(task_groups_descriptor), OPTIONAL, INTENT(IN) :: dtgs
       INTEGER, OPTIONAL, INTENT(IN) :: howmany
!!!pgi$ ignore_tkr(d) f
       COMPLEX(DP) :: f(:)
     END SUBROUTINE invfft_x
     !
#ifdef USE_CUDA
     SUBROUTINE invfft_x_gpu( grid_type, f, dfft, dtgs, howmany )
       USE cudafor
       USE fft_types,  ONLY: fft_type_descriptor
       USE task_groups,   ONLY: task_groups_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       CHARACTER(LEN=*),  INTENT(IN) :: grid_type
       TYPE(fft_type_descriptor), INTENT(IN) :: dfft
       TYPE(task_groups_descriptor), OPTIONAL, INTENT(IN) :: dtgs
       INTEGER, OPTIONAL, INTENT(IN) :: howmany
       COMPLEX(DP), DEVICE :: f(:)
     END SUBROUTINE invfft_x_gpu
#endif
     !
     SUBROUTINE invfft_b( f, dfft, ia )
       USE fft_smallbox_type,  ONLY: fft_box_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       INTEGER, INTENT(IN) :: ia
       TYPE(fft_box_descriptor), INTENT(IN) :: dfft
       COMPLEX(DP) :: f(:)
     END SUBROUTINE invfft_b
  END INTERFACE

  INTERFACE invfft_batch
     
     SUBROUTINE invfft_x_batch( grid_type, f, dfft, batchsize )
       USE fft_types,  ONLY: fft_type_descriptor
       USE task_groups,   ONLY: task_groups_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       CHARACTER(LEN=*),  INTENT(IN) :: grid_type
       TYPE(fft_type_descriptor), INTENT(IN) :: dfft
       INTEGER, INTENT(IN) :: batchsize
!!!pgi$ ignore_tkr(d) f
       COMPLEX(DP) :: f(:)
     END SUBROUTINE invfft_x_batch
     !
#ifdef USE_CUDA
     SUBROUTINE invfft_x_gpu_batch( grid_type, f, dfft, batchsize )
       USE cudafor
       USE fft_types,  ONLY: fft_type_descriptor
       USE task_groups,   ONLY: task_groups_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       CHARACTER(LEN=*),  INTENT(IN) :: grid_type
       TYPE(fft_type_descriptor), INTENT(IN) :: dfft
       INTEGER, INTENT(IN) :: batchsize
       !TYPE(task_groups_descriptor), OPTIONAL, INTENT(IN) :: dtgs
       !INTEGER, OPTIONAL, INTENT(IN) :: howmany
       COMPLEX(DP), DEVICE :: f(:)
     END SUBROUTINE invfft_x_gpu_batch
#endif
     !
  END INTERFACE

  INTERFACE fwfft
     SUBROUTINE fwfft_x( grid_type, f, dfft, dtgs, howmany )
       USE fft_types,  ONLY: fft_type_descriptor
       USE task_groups,   ONLY: task_groups_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       CHARACTER(LEN=*), INTENT(IN) :: grid_type
       TYPE(fft_type_descriptor), INTENT(IN) :: dfft
       TYPE(task_groups_descriptor), OPTIONAL, INTENT(IN) :: dtgs
       INTEGER, OPTIONAL, INTENT(IN) :: howmany
!!!!pgi$ ignore_tkr(d) f
       COMPLEX(DP) :: f(:)
     END SUBROUTINE fwfft_x
     !
#ifdef USE_CUDA
     SUBROUTINE fwfft_x_gpu( grid_type, f, dfft, dtgs, howmany )
       USE cudafor
       USE fft_types,  ONLY: fft_type_descriptor
       USE task_groups,   ONLY: task_groups_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       CHARACTER(LEN=*), INTENT(IN) :: grid_type
       TYPE(fft_type_descriptor), INTENT(IN) :: dfft
       TYPE(task_groups_descriptor), OPTIONAL, INTENT(IN) :: dtgs
       INTEGER, OPTIONAL, INTENT(IN) :: howmany
       COMPLEX(DP), DEVICE :: f(:)
     END SUBROUTINE fwfft_x_gpu
#endif
     !
  END INTERFACE

  INTERFACE fwfft_batch
     SUBROUTINE fwfft_x_batch( grid_type, f, dfft, batchsize)
       USE fft_types,  ONLY: fft_type_descriptor
       USE task_groups,   ONLY: task_groups_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       CHARACTER(LEN=*), INTENT(IN) :: grid_type
       TYPE(fft_type_descriptor), INTENT(IN) :: dfft
       INTEGER, INTENT(IN) :: batchsize
       !TYPE(task_groups_descriptor), OPTIONAL, INTENT(IN) :: dtgs
       !INTEGER, OPTIONAL, INTENT(IN) :: howmany
!!!!pgi$ ignore_tkr(d) f
       COMPLEX(DP) :: f(:)
     END SUBROUTINE fwfft_x_batch
     !
#ifdef USE_CUDA
     SUBROUTINE fwfft_x_gpu_batch( grid_type, f, dfft, batchsize )
       USE cudafor
       USE fft_types,  ONLY: fft_type_descriptor
       USE task_groups,   ONLY: task_groups_descriptor
       USE fft_param,  ONLY :DP
       IMPLICIT NONE
       CHARACTER(LEN=*), INTENT(IN) :: grid_type
       TYPE(fft_type_descriptor), INTENT(IN) :: dfft
       INTEGER, INTENT(IN) :: batchsize
       !TYPE(task_groups_descriptor), OPTIONAL, INTENT(IN) :: dtgs
       !INTEGER, OPTIONAL, INTENT(IN) :: howmany
       COMPLEX(DP), DEVICE :: f(:)
     END SUBROUTINE fwfft_x_gpu_batch
#endif
     !
  END INTERFACE

END MODULE fft_interfaces
!=---------------------------------------------------------------------------=!
