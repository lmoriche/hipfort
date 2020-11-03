!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! ==============================================================================
! hipfort: FORTRAN Interfaces for GPU kernels
! ==============================================================================
! Copyright (c) 2020 Advanced Micro Devices, Inc. All rights reserved.
! [MITx11 License]
! 
! Permission is hereby granted, free of charge, to any person obtaining a copy
! of this software and associated documentation files (the "Software"), to deal
! in the Software without restriction, including without limitation the rights
! to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
! copies of the Software, and to permit persons to whom the Software is
! furnished to do so, subject to the following conditions:
! 
! The above copyright notice and this permission notice shall be included in
! all copies or substantial portions of the Software.
! 
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
! AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
! THE SOFTWARE.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          
           
module hipfort_rocsolver
  use hipfort_rocsolver_enums
  implicit none

 
  !> ! \brief   loads char buf with the rocsolver library version. size_t len
  !>      is the maximum length of char buf.
  !> 
  !>  
  interface rocsolver_get_version_string
    function rocsolver_get_version_string_orig(buf,len) bind(c, name="rocsolver_get_version_string")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_get_version_string_orig
      type(c_ptr),value :: buf
      integer(c_size_t),value :: len
    end function


  end interface
  !> ! \brief LACGV conjugates the complex vector x.
  !> 
  !>     \details
  !>     It conjugates the n entries of a complex vector x with increment incx.
  !> 
  !>     @param[in]
  !>     handle          rocblas_handle
  !>     @param[in]
  !>     n               rocblas_int. n >= 0.\n
  !>                     The number of entries of the vector x.
  !>     @param[inout]
  !>     x               pointer to type. Array on the GPU of size at least n.\n
  !>                     On input it is the vector x,
  !>                     on output it is overwritten with vector conjg(x).
  !>     @param[in]
  !>     incx            rocblas_int. incx != 0.\n
  !>                     The increment between consecutive elements of x.
  !>                     If incx is negative, the elements of x are indexed in
  !>                     reverse order.
  !>     
  interface rocsolver_clacgv
    function rocsolver_clacgv_orig(handle,n,x,incx) bind(c, name="rocsolver_clacgv")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clacgv_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: x
      integer(c_int),value :: incx
    end function

    module procedure rocsolver_clacgv_rank_0,rocsolver_clacgv_rank_1
  end interface
  
  interface rocsolver_zlacgv
    function rocsolver_zlacgv_orig(handle,n,x,incx) bind(c, name="rocsolver_zlacgv")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlacgv_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: x
      integer(c_int),value :: incx
    end function

    module procedure rocsolver_zlacgv_rank_0,rocsolver_zlacgv_rank_1
  end interface
  !> ! \brief LASWP performs a series of row interchanges on the matrix A.
  !> 
  !>     \details
  !>     It interchanges row I with row IPIV[k1 + (I - k1)  abs(inx)], for
  !>     each of rows K1 through K2 of A. k1 and k2 are 1-based indices.
  !> 
  !>     @param[in]
  !>     handle          rocblas_handle
  !>     @param[in]
  !>     n               rocblas_int. n >= 0.\n
  !>                     The number of columns of the matrix A.
  !>     @param[inout]
  !>     A               pointer to type. Array on the GPU of dimension ldan. \n
  !>                     On entry, the matrix of column dimension n to which the row
  !>                     interchanges will be applied. On exit, the permuted matrix.
  !>     @param[in]
  !>     lda             rocblas_int. lda > 0.\n
  !>                     The leading dimension of the array A.
  !>     @param[in]
  !>     k1              rocblas_int. k1 > 0.\n
  !>                     The first element of IPIV for which a row interchange will
  !>                     be done. This is a 1-based index.
  !>     @param[in]
  !>     k2              rocblas_int. k2 > k1 > 0.\n
  !>                     (K2-K1+1) is the number of elements of IPIV for which a row
  !>                     interchange will be done. This is a 1-based index.
  !>     @param[in]
  !>     ipiv            pointer to rocblas_int. Array on the GPU of dimension at
  !>    least k1 + (k2 - k1)  abs(incx).\n The vector of pivot indices.  Only the
  !>    elements in positions k1 through (k1 + (k2 - k1)  abs(incx)) of IPIV are
  !>    accessed. Elements of ipiv are considered 1-based.
  !>     @param[in]
  !>     incx            rocblas_int. incx != 0.\n
  !>                     The increment between successive values of IPIV.  If IPIV
  !>                     is negative, the pivots are applied in reverse order.
  !>     
  interface rocsolver_slaswp
    function rocsolver_slaswp_orig(handle,lda,ipiv,incx) bind(c, name="rocsolver_slaswp")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slaswp_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: incx
    end function

    module procedure rocsolver_slaswp_rank_0,rocsolver_slaswp_rank_1
  end interface
  
  interface rocsolver_dlaswp
    function rocsolver_dlaswp_orig(handle,n,A,k2,incx) bind(c, name="rocsolver_dlaswp")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlaswp_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
    end function

    module procedure rocsolver_dlaswp_full_rank,rocsolver_dlaswp_rank_0,rocsolver_dlaswp_rank_1
  end interface
  
  interface rocsolver_claswp
    function rocsolver_claswp_orig(handle,n,A,k2,incx) bind(c, name="rocsolver_claswp")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_claswp_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
    end function

    module procedure rocsolver_claswp_full_rank,rocsolver_claswp_rank_0,rocsolver_claswp_rank_1
  end interface
  
  interface rocsolver_zlaswp
    function rocsolver_zlaswp_orig(handle,n,A,k2,incx) bind(c, name="rocsolver_zlaswp")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlaswp_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
    end function

    module procedure rocsolver_zlaswp_full_rank,rocsolver_zlaswp_rank_0,rocsolver_zlaswp_rank_1
  end interface
  !> ! \brief LARFG generates an orthogonal Householder reflector H of order n.
  !> 
  !>     \details
  !>     Householder reflector H is such that
  !> 
  !>         H  [alpha] = [beta]
  !>             [  x  ]   [  0 ]
  !> 
  !>     where x is an n-1 vector and alpha and beta are scalars. Matrix H can be
  !>     generated as
  !> 
  !>         H = I - tau  [1]  [1 v']
  !>                       [v]
  !> 
  !>     with v an n-1 vector and tau a scalar.
  !> 
  !>     @param[in]
  !>     handle          rocblas_handle
  !>     @param[in]
  !>     n               rocblas_int. n >= 0.\n
  !>                     The order (size) of reflector H.
  !>     @param[inout]
  !>     alpha           pointer to type. A scalar on the GPU.\n
  !>                     On input the scalar alpha,
  !>                     on output it is overwritten with beta.
  !>     @param[inout]
  !>     x               pointer to type. Array on the GPU of size at least n-1.\n
  !>                     On input it is the vector x,
  !>                     on output it is overwritten with vector v.
  !>     @param[in]
  !>     incx            rocblas_int. incx > 0.\n
  !>                     The increment between consecutive elements of x.
  !>     @param[out]
  !>     tau             pointer to type. A scalar on the GPU.\n
  !>                     The scalar tau.
  !> 
  !>     
  interface rocsolver_slarfg
    function rocsolver_slarfg_orig(handle,n,alpha,x,incx,tau) bind(c, name="rocsolver_slarfg")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarfg_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float) :: alpha
      type(c_ptr),value :: x
      integer(c_int),value :: incx
      real(c_float) :: tau
    end function

    module procedure rocsolver_slarfg_rank_0,rocsolver_slarfg_rank_1
  end interface
  
  interface rocsolver_dlarfg
    function rocsolver_dlarfg_orig(handle,n,alpha,x,incx,tau) bind(c, name="rocsolver_dlarfg")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarfg_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double) :: alpha
      type(c_ptr),value :: x
      integer(c_int),value :: incx
      real(c_double) :: tau
    end function

    module procedure rocsolver_dlarfg_rank_0,rocsolver_dlarfg_rank_1
  end interface
  
  interface rocsolver_clarfg
    function rocsolver_clarfg_orig(handle,n,alpha,x,incx,tau) bind(c, name="rocsolver_clarfg")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarfg_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex) :: alpha
      type(c_ptr),value :: x
      integer(c_int),value :: incx
      complex(c_float_complex) :: tau
    end function

    module procedure rocsolver_clarfg_rank_0,rocsolver_clarfg_rank_1
  end interface
  
  interface rocsolver_zlarfg
    function rocsolver_zlarfg_orig(handle,n,alpha,x,incx,tau) bind(c, name="rocsolver_zlarfg")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarfg_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex) :: alpha
      type(c_ptr),value :: x
      integer(c_int),value :: incx
      complex(c_double_complex) :: tau
    end function

    module procedure rocsolver_zlarfg_rank_0,rocsolver_zlarfg_rank_1
  end interface
  !> ! \brief LARFT Generates the triangular factor T of a block reflector H of
  !>    order n.
  !> 
  !>     \details
  !>     The block reflector H is defined as the product of k Householder matrices as
  !> 
  !>         H = H(1)  H(2)  ...  H(k)  (forward direction), or
  !>         H = H(k)  ...  H(2)  H(1)  (backward direction)
  !> 
  !>     depending on the value of direct.
  !> 
  !>     The triangular matrix T is upper triangular in forward direction and lower
  !>    triangular in backward direction. If storev is column-wise, then
  !> 
  !>         H = I - V  T  V'
  !> 
  !>     where the i-th column of matrix V contains the Householder vector associated
  !>    to H(i). If storev is row-wise, then
  !> 
  !>         H = I - V'  T  V
  !> 
  !>     where the i-th row of matrix V contains the Householder vector associated to
  !>    H(i).
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     direct              rocblas_direct.\n
  !>                         Specifies the direction in which the Householder
  !>    matrices are applied.
  !>     @param[in]
  !>     storev              rocblas_storev.\n
  !>                         Specifies how the Householder vectors are stored in
  !>    matrix V.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         The order (size) of the block reflector.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 1.\n
  !>                         The number of Householder matrices.
  !>     @param[in]
  !>     V                   pointer to type. Array on the GPU of size ldvk if
  !>    column-wise, or ldvn if row-wise.\n The matrix of Householder vectors.
  !>     @param[in]
  !>     ldv                 rocblas_int. ldv >= n if column-wise, or ldv >= k if
  !>    row-wise.\n Leading dimension of V.
  !>     @param[in]
  !>     tau                 pointer to type. Array of k scalars on the GPU.\n
  !>                         The vector of all the scalars associated to the
  !>    Householder matrices.
  !>     @param[out]
  !>     T                   pointer to type. Array on the GPU of dimension ldtk.\n
  !>                         The triangular factor. T is upper triangular is forward
  !>    operation, otherwise it is lower triangular. The rest of the array is not
  !>    used.
  !>     @param[in]
  !>     ldt                 rocblas_int. ldt >= k.\n
  !>                         The leading dimension of T.
  !> 
  !>     
  interface rocsolver_slarft
    function rocsolver_slarft_orig(handle,myDirect,n,ldv,tau,T,ldt) bind(c, name="rocsolver_slarft")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarft_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_float) :: tau
      type(c_ptr),value :: T
      integer(c_int),value :: ldt
    end function

    module procedure rocsolver_slarft_full_rank,rocsolver_slarft_rank_0,rocsolver_slarft_rank_1
  end interface
  
  interface rocsolver_dlarft
    function rocsolver_dlarft_orig(handle,myDirect,n,ldv,tau,T,ldt) bind(c, name="rocsolver_dlarft")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarft_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_double) :: tau
      type(c_ptr),value :: T
      integer(c_int),value :: ldt
    end function

    module procedure rocsolver_dlarft_full_rank,rocsolver_dlarft_rank_0,rocsolver_dlarft_rank_1
  end interface
  
  interface rocsolver_clarft
    function rocsolver_clarft_orig(handle,myDirect,k,V,ldv,tau,T,ldt) bind(c, name="rocsolver_clarft")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarft_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: k
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      complex(c_float_complex) :: tau
      type(c_ptr),value :: T
      integer(c_int),value :: ldt
    end function

    module procedure rocsolver_clarft_full_rank,rocsolver_clarft_rank_0,rocsolver_clarft_rank_1
  end interface
  
  interface rocsolver_zlarft
    function rocsolver_zlarft_orig(handle,myDirect,n,k,V,ldv,tau,T,ldt) bind(c, name="rocsolver_zlarft")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarft_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: k
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      complex(c_double_complex) :: tau
      type(c_ptr),value :: T
      integer(c_int),value :: ldt
    end function

    module procedure rocsolver_zlarft_full_rank,rocsolver_zlarft_rank_0,rocsolver_zlarft_rank_1
  end interface
  !> ! \brief LARF applies a Householder reflector H to a general matrix A.
  !> 
  !>     \details
  !>     The Householder reflector H, of order m (or n), is to be applied to a m-by-n
  !>    matrix A from the left (or the right). H is given by
  !> 
  !>         H = I - alpha  x  x'
  !> 
  !>     where alpha is a scalar and x a Householder vector. H is never actually
  !>    computed.
  !> 
  !>     @param[in]
  !>     handle          rocblas_handle.
  !>     @param[in]
  !>     side            rocblas_side.\n
  !>                     If side = rocblas_side_left, then compute HA
  !>                     If side = rocblas_side_right, then compute AH
  !>     @param[in]
  !>     m               rocblas_int. m >= 0.\n
  !>                     Number of rows of A.
  !>     @param[in]
  !>     n               rocblas_int. n >= 0.\n
  !>                     Number of columns of A.
  !>     @param[in]
  !>     x               pointer to type. Array on the GPU of
  !>                     size at least (1 + (m-1)abs(incx)) if left side, or
  !>                     at least (1 + (n-1)abs(incx)) if right side.\n
  !>                     The Householder vector x.
  !>     @param[in]
  !>     incx            rocblas_int. incx != 0.\n
  !>                     Increment between to consecutive elements of x.
  !>                     If incx < 0, the elements of x are used in reverse order.
  !>     @param[in]
  !>     alpha           pointer to type. A scalar on the GPU.\n
  !>                     If alpha = 0, then H = I (A will remain the same, x is never
  !>    used)
  !>     @param[inout]
  !>     A               pointer to type. Array on the GPU of size ldan.\n
  !>                     On input, the matrix A. On output it is overwritten with
  !>                     HA (or AH).
  !>     @param[in]
  !>     lda             rocblas_int. lda >= m.\n
  !>                     Leading dimension of A.
  !> 
  !>     
  interface rocsolver_slarf
    function rocsolver_slarf_orig(handle,m,incx,alpha,A,lda) bind(c, name="rocsolver_slarf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      real(c_float) :: alpha
      type(c_ptr),value :: A
      integer(c_int),value :: lda
    end function

    module procedure rocsolver_slarf_full_rank,rocsolver_slarf_rank_0,rocsolver_slarf_rank_1
  end interface
  
  interface rocsolver_dlarf
    function rocsolver_dlarf_orig(handle,m,incx,alpha,A,lda) bind(c, name="rocsolver_dlarf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      real(c_double) :: alpha
      type(c_ptr),value :: A
      integer(c_int),value :: lda
    end function

    module procedure rocsolver_dlarf_full_rank,rocsolver_dlarf_rank_0,rocsolver_dlarf_rank_1
  end interface
  
  interface rocsolver_clarf
    function rocsolver_clarf_orig(handle,m,incx,alpha,A,lda) bind(c, name="rocsolver_clarf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      complex(c_float_complex) :: alpha
      type(c_ptr),value :: A
      integer(c_int),value :: lda
    end function

    module procedure rocsolver_clarf_full_rank,rocsolver_clarf_rank_0,rocsolver_clarf_rank_1
  end interface
  
  interface rocsolver_zlarf
    function rocsolver_zlarf_orig(handle,m,incx,alpha,A,lda) bind(c, name="rocsolver_zlarf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      complex(c_double_complex) :: alpha
      type(c_ptr),value :: A
      integer(c_int),value :: lda
    end function

    module procedure rocsolver_zlarf_full_rank,rocsolver_zlarf_rank_0,rocsolver_zlarf_rank_1
  end interface
  !> ! \brief LARFB applies a block reflector H to a general m-by-n matrix A.
  !> 
  !>     \details
  !>     The block reflector H is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         H   A  (No transpose from the left)
  !>         H'  A  (Transpose or conjugate transpose from the left)
  !>         A  H   (No transpose from the right), and
  !>         A  H'  (Transpose or conjugate transpose from the right)
  !> 
  !>     The block reflector H is defined as the product of k Householder matrices as
  !> 
  !>         H = H(1)  H(2)  ...  H(k)  (forward direction), or
  !>         H = H(k)  ...  H(2)  H(1)  (backward direction)
  !> 
  !>     depending on the value of direct. H is never stored. It is calculated as
  !> 
  !>         H = I - V  T  V'
  !> 
  !>     where the i-th column of matrix V contains the Householder vector associated
  !>    with H(i), if storev is column-wise; or
  !> 
  !>         H = I - V'  T  V
  !> 
  !>     where the i-th row of matrix V contains the Householder vector associated
  !>    with H(i), if storev is row-wise. T is the associated triangular factor as
  !>    computed by LARFT.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply H.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the block reflector or its
  !>    transposeconjugate transpose is to be applied.
  !>     @param[in]
  !>     direct              rocblas_direct.\n
  !>                         Specifies the direction in which the Householder
  !>    matrices were to be applied to generate H.
  !>     @param[in]
  !>     storev              rocblas_storev.\n
  !>                         Specifies how the Householder vectors are stored in
  !>    matrix V.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix A.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix A.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 1.\n
  !>                         The number of Householder matrices.
  !>     @param[in]
  !>     V                   pointer to type. Array on the GPU of size ldvk if
  !>    column-wise, ldvn if row-wise and applying from the right, or ldvm if
  !>    row-wise and applying from the left.\n The matrix of Householder vectors.
  !>     @param[in]
  !>     ldv                 rocblas_int. ldv >= k if row-wise, ldv >= m if
  !>    column-wise and applying from the left, or ldv >= n if column-wise and
  !>    applying from the right.\n Leading dimension of V.
  !>     @param[in]
  !>     T                   pointer to type. Array on the GPU of dimension ldtk.\n
  !>                         The triangular factor of the block reflector.
  !>     @param[in]
  !>     ldt                 rocblas_int. ldt >= k.\n
  !>                         The leading dimension of T.
  !>     @param[inout]
  !>     A                   pointer to type. Array on the GPU of size ldan.\n
  !>                         On input, the matrix A. On output it is overwritten with
  !>                         HA, AH, H'A, or AH'.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= m.\n
  !>                         Leading dimension of A.
  !> 
  !>     
  interface rocsolver_slarfb
    function rocsolver_slarfb_orig(handle,side,trans,myDirect,n,ldv,T,lda) bind(c, name="rocsolver_slarfb")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarfb_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      type(c_ptr),value :: T
      integer(c_int),value :: lda
    end function

    module procedure rocsolver_slarfb_full_rank,rocsolver_slarfb_rank_0,rocsolver_slarfb_rank_1
  end interface
  
  interface rocsolver_dlarfb
    function rocsolver_dlarfb_orig(handle,side,trans,myDirect,n,ldv,T,lda) bind(c, name="rocsolver_dlarfb")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarfb_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      type(c_ptr),value :: T
      integer(c_int),value :: lda
    end function

    module procedure rocsolver_dlarfb_full_rank,rocsolver_dlarfb_rank_0,rocsolver_dlarfb_rank_1
  end interface
  
  interface rocsolver_clarfb
    function rocsolver_clarfb_orig(handle,side,trans,myDirect,n,ldv,T,ldt,A,lda) bind(c, name="rocsolver_clarfb")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarfb_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      type(c_ptr),value :: T
      integer(c_int),value :: ldt
      type(c_ptr),value :: A
      integer(c_int),value :: lda
    end function

    module procedure rocsolver_clarfb_full_rank,rocsolver_clarfb_rank_0,rocsolver_clarfb_rank_1
  end interface
  
  interface rocsolver_zlarfb
    function rocsolver_zlarfb_orig(handle,side,trans,myDirect,n,ldv,T,ldt,A,lda) bind(c, name="rocsolver_zlarfb")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarfb_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      type(c_ptr),value :: T
      integer(c_int),value :: ldt
      type(c_ptr),value :: A
      integer(c_int),value :: lda
    end function

    module procedure rocsolver_zlarfb_full_rank,rocsolver_zlarfb_rank_0,rocsolver_zlarfb_rank_1
  end interface
  !> ! \brief LABRD computes the bidiagonal form of the first k rows and columns of
  !>    a general m-by-n matrix A, as well as the matrices X and Y needed to reduce
  !>    the remaining part of A.
  !> 
  !>     \details
  !>     The bidiagonal form is given by:
  !> 
  !>         B = Q'  A  P
  !> 
  !>     where B is upper bidiagonal if m >= n and lower bidiagonal if m < n, and Q
  !>    and P are orthogonalunitary matrices represented as the product of
  !>    Householder matrices
  !> 
  !>         Q = H(1)  H(2)  ...   H(k)  and P = G(1)  G(2)  ...  G(k-1), if m
  !>    >= n, or Q = H(1)  H(2)  ...  H(k-1) and P = G(1)  G(2)  ...   G(k), if
  !>    m < n
  !> 
  !>     Each Householder matrix H(i) and G(i) is given by
  !> 
  !>         H(i) = I - tauq[i-1]  v(i)  v(i)', and
  !>         G(i) = I - taup[i-1]  u(i)  u(i)'
  !> 
  !>     If m >= n, the first i-1 elements of the Householder vector v(i) are zero,
  !>    and v(i)[i] = 1; while the first i elements of the Householder vector u(i)
  !>    are zero, and u(i)[i+1] = 1. If m < n, the first i elements of the
  !>    Householder vector v(i) are zero, and v(i)[i+1] = 1; while the first i-1
  !>    elements of the Householder vector u(i) are zero, and u(i)[i] = 1.
  !> 
  !>     The unreduced part of the matrix A can be updated using a block update:
  !> 
  !>         A = A - V  Y' - X  U'
  !> 
  !>     where V is an m-by-k matrix and U is an n-by-k formed using the vectors v
  !>    and u.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[in]
  !>     k         rocblas_int. min(m,n) >= k >= 0.\n
  !>               The number of leading rows and columns of the matrix A to be
  !>    reduced.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on the diagonal and superdiagonal (if m >=
  !>    n), or subdiagonal (if m < n) contain the bidiagonal form B. If m >= n, the
  !>    elements below the diagonal are the m - i elements of vector v(i) for i =
  !>    1,2,...,n, and the elements above the superdiagonal are the n - i - 1
  !>    elements of vector u(i) for i = 1,2,...,n-1. If m < n, the elements below the
  !>    subdiagonal are the m - i - 1 elements of vector v(i) for i = 1,2,...,m-1,
  !>    and the elements above the diagonal are the n - i elements of vector u(i) for
  !>    i = 1,2,...,m.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               specifies the leading dimension of A.
  !>     @param[out]
  !>     D         pointer to real type. Array on the GPU of dimension k.\n
  !>               The diagonal elements of B.
  !>     @param[out]
  !>     E         pointer to real type. Array on the GPU of dimension k.\n
  !>               The off-diagonal elements of B.
  !>     @param[out]
  !>     tauq      pointer to type. Array on the GPU of dimension k.\n
  !>               The scalar factors of the Householder matrices H(i).
  !>     @param[out]
  !>     taup      pointer to type. Array on the GPU of dimension k.\n
  !>               The scalar factors of the Householder matrices G(i).
  !>     @param[out]
  !>     X         pointer to type. Array on the GPU of dimension ldxk.\n
  !>               The m-by-k matrix needed to reduce the unreduced part of A.
  !>     @param[in]
  !>     ldx       rocblas_int. ldx >= m.\n
  !>               specifies the leading dimension of X.
  !>     @param[out]
  !>     Y         pointer to type. Array on the GPU of dimension ldyk.\n
  !>               The n-by-k matrix needed to reduce the unreduced part of A.
  !>     @param[in]
  !>     ldy       rocblas_int. ldy >= n.\n
  !>               specifies the leading dimension of Y.
  !> 
  !>     
  interface rocsolver_slabrd
    function rocsolver_slabrd_orig(handle,n,lda,D,E,tauq,taup,X,ldx,Y,ldy) bind(c, name="rocsolver_slabrd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slabrd_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
      type(c_ptr),value :: X
      integer(c_int),value :: ldx
      type(c_ptr),value :: Y
      integer(c_int),value :: ldy
    end function

    module procedure rocsolver_slabrd_full_rank,rocsolver_slabrd_rank_0,rocsolver_slabrd_rank_1
  end interface
  
  interface rocsolver_dlabrd
    function rocsolver_dlabrd_orig(handle,n,lda,D,E,tauq,taup,X,ldx,Y,ldy) bind(c, name="rocsolver_dlabrd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlabrd_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
      type(c_ptr),value :: X
      integer(c_int),value :: ldx
      type(c_ptr),value :: Y
      integer(c_int),value :: ldy
    end function

    module procedure rocsolver_dlabrd_full_rank,rocsolver_dlabrd_rank_0,rocsolver_dlabrd_rank_1
  end interface
  
  interface rocsolver_clabrd
    function rocsolver_clabrd_orig(handle,n,lda,D,E,tauq,taup,X,ldy) bind(c, name="rocsolver_clabrd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clabrd_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
      type(c_ptr),value :: X
      integer(c_int),value :: ldy
    end function

    module procedure rocsolver_clabrd_full_rank,rocsolver_clabrd_rank_0,rocsolver_clabrd_rank_1
  end interface
  
  interface rocsolver_zlabrd
    function rocsolver_zlabrd_orig(handle,n,lda,D,E,tauq,taup,X,ldy) bind(c, name="rocsolver_zlabrd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlabrd_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
      type(c_ptr),value :: X
      integer(c_int),value :: ldy
    end function

    module procedure rocsolver_zlabrd_full_rank,rocsolver_zlabrd_rank_0,rocsolver_zlabrd_rank_1
  end interface
  !> ! \brief ORG2R generates a m-by-n Matrix Q with orthonormal columns.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The matrix Q is defined as the first n columns of the product of k
  !>    Householder reflectors of order m
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vector v(i) and scalar ipiv_i as returned by GEQRF.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of the matrix Q.
  !>     @param[in]
  !>     n           rocblas_int. 0 <= n <= m.\n
  !>                 The number of columns of the matrix Q.
  !>     @param[in]
  !>     k           rocblas_int. 0 <= k <= n.\n
  !>                 The number of Householder reflectors.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th column has Householder vector v(i), for i =
  !>    1,2,...,k as returned in the first k columns of matrix A of GEQRF. On exit,
  !>    the computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension at least k.\n
  !>                 The scalar factors of the Householder matrices H(i) as returned
  !>    by GEQRF.
  !> 
  !>     
  interface rocsolver_sorg2r
    function rocsolver_sorg2r_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_sorg2r")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorg2r_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sorg2r_rank_0,rocsolver_sorg2r_rank_1
  end interface
  
  interface rocsolver_dorg2r
    function rocsolver_dorg2r_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_dorg2r")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorg2r_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dorg2r_rank_0,rocsolver_dorg2r_rank_1
  end interface
  !> ! \brief UNG2R generates a m-by-n complex Matrix Q with orthonormal columns.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The matrix Q is defined as the first n columns of the product of k
  !>    Householder reflectors of order m
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vector v(i) and scalar ipiv_i as returned by GEQRF.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of the matrix Q.
  !>     @param[in]
  !>     n           rocblas_int. 0 <= n <= m.\n
  !>                 The number of columns of the matrix Q.
  !>     @param[in]
  !>     k           rocblas_int. 0 <= k <= n.\n
  !>                 The number of Householder reflectors.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th column has Householder vector v(i), for i =
  !>    1,2,...,k as returned in the first k columns of matrix A of GEQRF. On exit,
  !>    the computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension at least k.\n
  !>                 The scalar factors of the Householder matrices H(i) as returned
  !>    by GEQRF.
  !> 
  !>     
  interface rocsolver_cung2r
    function rocsolver_cung2r_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_cung2r")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cung2r_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cung2r_rank_0,rocsolver_cung2r_rank_1
  end interface
  
  interface rocsolver_zung2r
    function rocsolver_zung2r_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_zung2r")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zung2r_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zung2r_rank_0,rocsolver_zung2r_rank_1
  end interface
  !> ! \brief ORGQR generates a m-by-n Matrix Q with orthonormal columns.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The matrix Q is defined as the first n columns of the product of k
  !>    Householder reflectors of order m
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vector v(i) and scalar ipiv_i as returned by GEQRF.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of the matrix Q.
  !>     @param[in]
  !>     n           rocblas_int. 0 <= n <= m.\n
  !>                 The number of columns of the matrix Q.
  !>     @param[in]
  !>     k           rocblas_int. 0 <= k <= n.\n
  !>                 The number of Householder reflectors.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th column has Householder vector v(i), for i =
  !>    1,2,...,k as returned in the first k columns of matrix A of GEQRF. On exit,
  !>    the computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension at least k.\n
  !>                 The scalar factors of the Householder matrices H(i) as returned
  !>    by GEQRF.
  !> 
  !>     
  interface rocsolver_sorgqr
    function rocsolver_sorgqr_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_sorgqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgqr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sorgqr_rank_0,rocsolver_sorgqr_rank_1
  end interface
  
  interface rocsolver_dorgqr
    function rocsolver_dorgqr_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_dorgqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgqr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dorgqr_rank_0,rocsolver_dorgqr_rank_1
  end interface
  !> ! \brief UNGQR generates a m-by-n complex Matrix Q with orthonormal columns.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The matrix Q is defined as the first n columns of the product of k
  !>    Householder reflectors of order m
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vector v(i) and scalar ipiv_i as returned by GEQRF.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of the matrix Q.
  !>     @param[in]
  !>     n           rocblas_int. 0 <= n <= m.\n
  !>                 The number of columns of the matrix Q.
  !>     @param[in]
  !>     k           rocblas_int. 0 <= k <= n.\n
  !>                 The number of Householder reflectors.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th column has Householder vector v(i), for i =
  !>    1,2,...,k as returned in the first k columns of matrix A of GEQRF. On exit,
  !>    the computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension at least k.\n
  !>                 The scalar factors of the Householder matrices H(i) as returned
  !>    by GEQRF.
  !> 
  !>     
  interface rocsolver_cungqr
    function rocsolver_cungqr_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_cungqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungqr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cungqr_rank_0,rocsolver_cungqr_rank_1
  end interface
  
  interface rocsolver_zungqr
    function rocsolver_zungqr_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_zungqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungqr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zungqr_rank_0,rocsolver_zungqr_rank_1
  end interface
  !> ! \brief ORGL2 generates a m-by-n Matrix Q with orthonormal rows.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The matrix Q is defined as the first m rows of the product of k Householder
  !>     reflectors of order n
  !> 
  !>         Q = H(k)  H(k-1)  ...  H(1)
  !> 
  !>     Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vector v(i) and scalar ipiv_i as returned by GELQF.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     m           rocblas_int. 0 <= m <= n.\n
  !>                 The number of rows of the matrix Q.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of the matrix Q.
  !>     @param[in]
  !>     k           rocblas_int. 0 <= k <= m.\n
  !>                 The number of Householder reflectors.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th row has Householder vector v(i), for i =
  !>    1,2,...,k as returned in the first k rows of matrix A of GELQF. On exit, the
  !>    computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension at least k.\n
  !>                 The scalar factors of the Householder matrices H(i) as returned
  !>    by GELQF.
  !> 
  !>     
  interface rocsolver_sorgl2
    function rocsolver_sorgl2_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_sorgl2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgl2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sorgl2_rank_0,rocsolver_sorgl2_rank_1
  end interface
  
  interface rocsolver_dorgl2
    function rocsolver_dorgl2_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_dorgl2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgl2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dorgl2_rank_0,rocsolver_dorgl2_rank_1
  end interface
  !> ! \brief UNGL2 generates a m-by-n complex Matrix Q with orthonormal rows.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The matrix Q is defined as the first m rows of the product of k Householder
  !>     reflectors of order n
  !> 
  !>         Q = H(k)H  H(k-1)H  ...  H(1)H
  !> 
  !>     Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vector v(i) and scalar ipiv_i as returned by GELQF.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     m           rocblas_int. 0 <= m <= n.\n
  !>                 The number of rows of the matrix Q.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of the matrix Q.
  !>     @param[in]
  !>     k           rocblas_int. 0 <= k <= m.\n
  !>                 The number of Householder reflectors.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th row has Householder vector v(i), for i =
  !>    1,2,...,k as returned in the first k rows of matrix A of GELQF. On exit, the
  !>    computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension at least k.\n
  !>                 The scalar factors of the Householder matrices H(i) as returned
  !>    by GELQF.
  !> 
  !>     
  interface rocsolver_cungl2
    function rocsolver_cungl2_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_cungl2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungl2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cungl2_rank_0,rocsolver_cungl2_rank_1
  end interface
  
  interface rocsolver_zungl2
    function rocsolver_zungl2_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_zungl2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungl2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zungl2_rank_0,rocsolver_zungl2_rank_1
  end interface
  !> ! \brief ORGLQ generates a m-by-n Matrix Q with orthonormal rows.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The matrix Q is defined as the first m rows of the product of k Householder
  !>     reflectors of order n
  !> 
  !>         Q = H(k)  H(k-1)  ...  H(1)
  !> 
  !>     Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vector v(i) and scalar ipiv_i as returned by GELQF.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     m           rocblas_int. 0 <= m <= n.\n
  !>                 The number of rows of the matrix Q.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of the matrix Q.
  !>     @param[in]
  !>     k           rocblas_int. 0 <= k <= m.\n
  !>                 The number of Householder reflectors.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th row has Householder vector v(i), for i =
  !>    1,2,...,k as returned in the first k rows of matrix A of GELQF. On exit, the
  !>    computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension at least k.\n
  !>                 The scalar factors of the Householder matrices H(i) as returned
  !>    by GELQF.
  !> 
  !>     
  interface rocsolver_sorglq
    function rocsolver_sorglq_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_sorglq")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorglq_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sorglq_rank_0,rocsolver_sorglq_rank_1
  end interface
  
  interface rocsolver_dorglq
    function rocsolver_dorglq_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_dorglq")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorglq_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dorglq_rank_0,rocsolver_dorglq_rank_1
  end interface
  !> ! \brief UNGLQ generates a m-by-n complex Matrix Q with orthonormal rows.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The matrix Q is defined as the first m rows of the product of k Householder
  !>     reflectors of order n
  !> 
  !>         Q = H(k)H  H(k-1)H  ...  H(1)H
  !> 
  !>     Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vector v(i) and scalar ipiv_i as returned by GELQF.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     m           rocblas_int. 0 <= m <= n.\n
  !>                 The number of rows of the matrix Q.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of the matrix Q.
  !>     @param[in]
  !>     k           rocblas_int. 0 <= k <= m.\n
  !>                 The number of Householder reflectors.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th row has Householder vector v(i), for i =
  !>    1,2,...,k as returned in the first k rows of matrix A of GELQF. On exit, the
  !>    computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension at least k.\n
  !>                 The scalar factors of the Householder matrices H(i) as returned
  !>    by GELQF.
  !> 
  !>     
  interface rocsolver_cunglq
    function rocsolver_cunglq_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_cunglq")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunglq_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cunglq_rank_0,rocsolver_cunglq_rank_1
  end interface
  
  interface rocsolver_zunglq
    function rocsolver_zunglq_orig(handle,n,lda,ipiv) bind(c, name="rocsolver_zunglq")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunglq_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zunglq_rank_0,rocsolver_zunglq_rank_1
  end interface
  !> ! \brief ORGBR generates a m-by-n Matrix Q with orthonormal rows or columns.
  !> 
  !>     \details
  !>     If storev is column-wise, then the matrix Q has orthonormal columns. If m >=
  !>    k, Q is defined as the first n columns of the product of k Householder
  !>    reflectors of order m
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     If m < k, Q is defined as the product of Householder reflectors of order m
  !> 
  !>         Q = H(1)  H(2)  ...  H(m-1)
  !> 
  !>     On the other hand, if storev is row-wise, then the matrix Q has orthonormal
  !>    rows. If n > k, Q is defined as the first m rows of the product of k
  !>    Householder reflectors of order n
  !> 
  !>         Q = H(k)  H(k-1)  ...  H(1)
  !> 
  !>     If n <= k, Q is defined as the product of Householder reflectors of order n
  !> 
  !>         Q = H(n-1)  H(n-2)  ...  H(1)
  !> 
  !>     The Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vectors v(i) and scalars ipiv_i as returned by
  !>    GEBRD in its arguments A and tauq or taup.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     storev      rocblas_storev.\n
  !>                 Specifies whether to work column-wise or row-wise.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of the matrix Q.
  !>                 If row-wise, then min(n,k) <= m <= n.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of the matrix Q.
  !>                 If column-wise, then min(m,k) <= n <= m.
  !>     @param[in]
  !>     k           rocblas_int. k >= 0.\n
  !>                 The number of columns (if storev is colum-wise) or rows (if
  !>    row-wise) of the original matrix reduced by GEBRD.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th column (or row) has the Householder vector
  !>    v(i) as returned by GEBRD. On exit, the computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension min(m,k) if
  !>    column-wise, or min(n,k) if row-wise.\n The scalar factors of the Householder
  !>    matrices H(i) as returned by GEBRD.
  !> 
  !>     
  interface rocsolver_sorgbr
    function rocsolver_sorgbr_orig(handle,storev,k,A,lda,ipiv) bind(c, name="rocsolver_sorgbr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgbr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(c_int),value :: k
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sorgbr_full_rank,rocsolver_sorgbr_rank_0,rocsolver_sorgbr_rank_1
  end interface
  
  interface rocsolver_dorgbr
    function rocsolver_dorgbr_orig(handle,storev,k,A,lda,ipiv) bind(c, name="rocsolver_dorgbr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgbr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(c_int),value :: k
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dorgbr_full_rank,rocsolver_dorgbr_rank_0,rocsolver_dorgbr_rank_1
  end interface
  !> ! \brief UNGBR generates a m-by-n complex Matrix Q with orthonormal rows or
  !>    columns.
  !> 
  !>     \details
  !>     If storev is column-wise, then the matrix Q has orthonormal columns. If m >=
  !>    k, Q is defined as the first n columns of the product of k Householder
  !>    reflectors of order m
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     If m < k, Q is defined as the product of Householder reflectors of order m
  !> 
  !>         Q = H(1)  H(2)  ...  H(m-1)
  !> 
  !>     On the other hand, if storev is row-wise, then the matrix Q has orthonormal
  !>    rows. If n > k, Q is defined as the first m rows of the product of k
  !>    Householder reflectors of order n
  !> 
  !>         Q = H(k)  H(k-1)  ...  H(1)
  !> 
  !>     If n <= k, Q is defined as the product of Householder reflectors of order n
  !> 
  !>         Q = H(n-1)  H(n-2)  ...  H(1)
  !> 
  !>     The Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vectors v(i) and scalars ipiv_i as returned by
  !>    GEBRD in its arguments A and tauq or taup.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     storev      rocblas_storev.\n
  !>                 Specifies whether to work column-wise or row-wise.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of the matrix Q.
  !>                 If row-wise, then min(n,k) <= m <= n.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of the matrix Q.
  !>                 If column-wise, then min(m,k) <= n <= m.
  !>     @param[in]
  !>     k           rocblas_int. k >= 0.\n
  !>                 The number of columns (if storev is colum-wise) or rows (if
  !>    row-wise) of the original matrix reduced by GEBRD.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry, the i-th column (or row) has the Householder vector
  !>    v(i) as returned by GEBRD. On exit, the computed matrix Q.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to type. Array on the GPU of dimension min(m,k) if
  !>    column-wise, or min(n,k) if row-wise.\n The scalar factors of the Householder
  !>    matrices H(i) as returned by GEBRD.
  !> 
  !>     
  interface rocsolver_cungbr
    function rocsolver_cungbr_orig(handle,m,k,A,lda,ipiv) bind(c, name="rocsolver_cungbr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungbr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: k
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cungbr_full_rank,rocsolver_cungbr_rank_0,rocsolver_cungbr_rank_1
  end interface
  
  interface rocsolver_zungbr
    function rocsolver_zungbr_orig(handle,m,k,A,lda,ipiv) bind(c, name="rocsolver_zungbr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungbr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: k
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zungbr_full_rank,rocsolver_zungbr_rank_0,rocsolver_zungbr_rank_1
  end interface
  !> ! \brief ORM2R applies a matrix Q with orthonormal columns to a general m-by-n
  !>    matrix C.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Transpose from the right)
  !> 
  !>     Q is an orthogonal matrix defined as the product of k Householder reflectors
  !>    as
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     or order m if applying from the left, or n if applying from the right. Q is
  !>    never stored, it is calculated from the Householder vectors and scalars
  !>    returned by the QR factorization GEQRF.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its transpose is to be
  !>    applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0; k <= m if side is left, k <= n if
  !>    side is right.\n The number of Householder reflectors that form Q.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldak.\n
  !>                         The i-th column has the Householder vector v(i)
  !>    associated with H(i) as returned by GEQRF in the first k columns of its
  !>    argument A.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= m if side is left, or lda >= n if
  !>    side is right. \n Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    k.\n The scalar factors of the Householder matrices H(i) as returned by
  !>    GEQRF.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_sorm2r
    function rocsolver_sorm2r_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_sorm2r")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorm2r_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_sorm2r_full_rank,rocsolver_sorm2r_rank_0,rocsolver_sorm2r_rank_1
  end interface
  
  interface rocsolver_dorm2r
    function rocsolver_dorm2r_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_dorm2r")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorm2r_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_dorm2r_full_rank,rocsolver_dorm2r_rank_0,rocsolver_dorm2r_rank_1
  end interface
  !> ! \brief UNM2R applies a complex matrix Q with orthonormal columns to a
  !>    general m-by-n matrix C.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Conjugate transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Conjugate transpose from the right)
  !> 
  !>     Q is a unitary matrix defined as the product of k Householder reflectors as
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     or order m if applying from the left, or n if applying from the right. Q is
  !>    never stored, it is calculated from the Householder vectors and scalars
  !>    returned by the QR factorization GEQRF.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its conjugate
  !>    transpose is to be applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0; k <= m if side is left, k <= n if
  !>    side is right.\n The number of Householder reflectors that form Q.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldak.\n
  !>                         The i-th column has the Householder vector v(i)
  !>    associated with H(i) as returned by GEQRF in the first k columns of its
  !>    argument A.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= m if side is left, or lda >= n if
  !>    side is right. \n Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    k.\n The scalar factors of the Householder matrices H(i) as returned by
  !>    GEQRF.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_cunm2r
    function rocsolver_cunm2r_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_cunm2r")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunm2r_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_cunm2r_full_rank,rocsolver_cunm2r_rank_0,rocsolver_cunm2r_rank_1
  end interface
  
  interface rocsolver_zunm2r
    function rocsolver_zunm2r_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_zunm2r")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunm2r_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_zunm2r_full_rank,rocsolver_zunm2r_rank_0,rocsolver_zunm2r_rank_1
  end interface
  !> ! \brief ORMQR applies a matrix Q with orthonormal columns to a general m-by-n
  !>    matrix C.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Transpose from the right)
  !> 
  !>     Q is an orthogonal matrix defined as the product of k Householder reflectors
  !>    as
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     or order m if applying from the left, or n if applying from the right. Q is
  !>    never stored, it is calculated from the Householder vectors and scalars
  !>    returned by the QR factorization GEQRF.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its transpose is to be
  !>    applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0; k <= m if side is left, k <= n if
  !>    side is right.\n The number of Householder reflectors that form Q.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldak.\n
  !>                         The i-th column has the Householder vector v(i)
  !>    associated with H(i) as returned by GEQRF in the first k columns of its
  !>    argument A.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= m if side is left, or lda >= n if
  !>    side is right. \n Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    k.\n The scalar factors of the Householder matrices H(i) as returned by
  !>    GEQRF.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_sormqr
    function rocsolver_sormqr_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_sormqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormqr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_sormqr_full_rank,rocsolver_sormqr_rank_0,rocsolver_sormqr_rank_1
  end interface
  
  interface rocsolver_dormqr
    function rocsolver_dormqr_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_dormqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormqr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_dormqr_full_rank,rocsolver_dormqr_rank_0,rocsolver_dormqr_rank_1
  end interface
  !> ! \brief UNMQR applies a complex matrix Q with orthonormal columns to a
  !>    general m-by-n matrix C.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Conjugate transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Conjugate transpose from the right)
  !> 
  !>     Q is a unitary matrix defined as the product of k Householder reflectors as
  !> 
  !>         Q = H(1)  H(2)  ...  H(k)
  !> 
  !>     or order m if applying from the left, or n if applying from the right. Q is
  !>    never stored, it is calculated from the Householder vectors and scalars
  !>    returned by the QR factorization GEQRF.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its conjugate
  !>    transpose is to be applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0; k <= m if side is left, k <= n if
  !>    side is right.\n The number of Householder reflectors that form Q.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldak.\n
  !>                         The i-th column has the Householder vector v(i)
  !>    associated with H(i) as returned by GEQRF in the first k columns of its
  !>    argument A.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= m if side is left, or lda >= n if
  !>    side is right. \n Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    k.\n The scalar factors of the Householder matrices H(i) as returned by
  !>    GEQRF.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_cunmqr
    function rocsolver_cunmqr_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_cunmqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmqr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_cunmqr_full_rank,rocsolver_cunmqr_rank_0,rocsolver_cunmqr_rank_1
  end interface
  
  interface rocsolver_zunmqr
    function rocsolver_zunmqr_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_zunmqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmqr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_zunmqr_full_rank,rocsolver_zunmqr_rank_0,rocsolver_zunmqr_rank_1
  end interface
  !> ! \brief ORML2 applies a matrix Q with orthonormal rows to a general m-by-n
  !>    matrix C.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Transpose from the right)
  !> 
  !>     Q is an orthogonal matrix defined as the product of k Householder reflectors
  !>    as
  !> 
  !>         Q = H(k)  H(k-1)  ...  H(1)
  !> 
  !>     or order m if applying from the left, or n if applying from the right. Q is
  !>    never stored, it is calculated from the Householder vectors and scalars
  !>    returned by the LQ factorization GELQF.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its transpose is to be
  !>    applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0; k <= m if side is left, k <= n if
  !>    side is right.\n The number of Householder reflectors that form Q.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldam if side
  !>    is left, or ldan if side is right.\n The i-th row has the Householder vector
  !>    v(i) associated with H(i) as returned by GELQF in the first k rows of its
  !>    argument A.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= k. \n
  !>                         Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    k.\n The scalar factors of the Householder matrices H(i) as returned by
  !>    GELQF.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_sorml2
    function rocsolver_sorml2_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_sorml2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorml2_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_sorml2_full_rank,rocsolver_sorml2_rank_0,rocsolver_sorml2_rank_1
  end interface
  
  interface rocsolver_dorml2
    function rocsolver_dorml2_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_dorml2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorml2_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_dorml2_full_rank,rocsolver_dorml2_rank_0,rocsolver_dorml2_rank_1
  end interface
  !> ! \brief UNML2 applies a complex matrix Q with orthonormal rows to a general
  !>    m-by-n matrix C.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Conjugate transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Conjugate transpose from the right)
  !> 
  !>     Q is a unitary matrix defined as the product of k Householder reflectors as
  !> 
  !>         Q = H(k)H  H(k-1)H  ...  H(1)H
  !> 
  !>     or order m if applying from the left, or n if applying from the right. Q is
  !>    never stored, it is calculated from the Householder vectors and scalars
  !>    returned by the LQ factorization GELQF.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its conjugate
  !>    transpose is to be applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0; k <= m if side is left, k <= n if
  !>    side is right.\n The number of Householder reflectors that form Q.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldam if side
  !>    is left, or ldan if side is right.\n The i-th row has the Householder vector
  !>    v(i) associated with H(i) as returned by GELQF in the first k rows of its
  !>    argument A.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= k. \n
  !>                         Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    k.\n The scalar factors of the Householder matrices H(i) as returned by
  !>    GELQF.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_cunml2
    function rocsolver_cunml2_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_cunml2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunml2_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_cunml2_full_rank,rocsolver_cunml2_rank_0,rocsolver_cunml2_rank_1
  end interface
  
  interface rocsolver_zunml2
    function rocsolver_zunml2_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_zunml2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunml2_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_zunml2_full_rank,rocsolver_zunml2_rank_0,rocsolver_zunml2_rank_1
  end interface
  !> ! \brief ORMLQ applies a matrix Q with orthonormal rows to a general m-by-n
  !>    matrix C.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Transpose from the right)
  !> 
  !>     Q is an orthogonal matrix defined as the product of k Householder reflectors
  !>    as
  !> 
  !>         Q = H(k)  H(k-1)  ...  H(1)
  !> 
  !>     or order m if applying from the left, or n if applying from the right. Q is
  !>    never stored, it is calculated from the Householder vectors and scalars
  !>    returned by the LQ factorization GELQF.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its transpose is to be
  !>    applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0; k <= m if side is left, k <= n if
  !>    side is right.\n The number of Householder reflectors that form Q.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldam if side
  !>    is left, or ldan if side is right.\n The i-th row has the Householder vector
  !>    v(i) associated with H(i) as returned by GELQF in the first k rows of its
  !>    argument A.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= k. \n
  !>                         Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    k.\n The scalar factors of the Householder matrices H(i) as returned by
  !>    GELQF.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_sormlq
    function rocsolver_sormlq_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_sormlq")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormlq_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_sormlq_full_rank,rocsolver_sormlq_rank_0,rocsolver_sormlq_rank_1
  end interface
  
  interface rocsolver_dormlq
    function rocsolver_dormlq_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_dormlq")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormlq_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_dormlq_full_rank,rocsolver_dormlq_rank_0,rocsolver_dormlq_rank_1
  end interface
  !> ! \brief UNMLQ applies a complex matrix Q with orthonormal rows to a general
  !>    m-by-n matrix C.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Conjugate transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Conjugate transpose from the right)
  !> 
  !>     Q is a unitary matrix defined as the product of k Householder reflectors as
  !> 
  !>         Q = H(k)H  H(k-1)H  ...  H(1)H
  !> 
  !>     or order m if applying from the left, or n if applying from the right. Q is
  !>    never stored, it is calculated from the Householder vectors and scalars
  !>    returned by the LQ factorization GELQF.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its conjugate
  !>    transpose is to be applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0; k <= m if side is left, k <= n if
  !>    side is right.\n The number of Householder reflectors that form Q.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldam if side
  !>    is left, or ldan if side is right.\n The i-th row has the Householder vector
  !>    v(i) associated with H(i) as returned by GELQF in the first k rows of its
  !>    argument A.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= k. \n
  !>                         Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    k.\n The scalar factors of the Householder matrices H(i) as returned by
  !>    GELQF.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_cunmlq
    function rocsolver_cunmlq_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_cunmlq")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmlq_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_cunmlq_full_rank,rocsolver_cunmlq_rank_0,rocsolver_cunmlq_rank_1
  end interface
  
  interface rocsolver_zunmlq
    function rocsolver_zunmlq_orig(handle,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_zunmlq")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmlq_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_zunmlq_full_rank,rocsolver_zunmlq_rank_0,rocsolver_zunmlq_rank_1
  end interface
  !> ! \brief ORMBR applies a matrix Q with orthonormal rows or columns to a
  !>    general m-by-n matrix C.
  !> 
  !>     \details
  !>     If storev is column-wise, then the matrix Q has orthonormal columns.
  !>     If storev is row-wise, then the matrix Q has orthonormal rows.
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Transpose from the right)
  !> 
  !>     The order nq of orthogonal matrix Q is nq = m if applying from the left, or
  !>    nq = n if applying from the right.
  !> 
  !>     When storev is column-wise, if nq >= k, then Q is defined as the product of
  !>    k Householder reflectors of order nq
  !> 
  !>         Q = H(1)  H(2)  ...  H(k),
  !> 
  !>     and if nq < k, then Q is defined as the product
  !> 
  !>         Q = H(1)  H(2)  ...  H(nq-1).
  !> 
  !>     When storev is row-wise, if nq > k, then Q is defined as the product of k
  !>    Householder reflectors of order nq
  !> 
  !>         Q = H(1)  H(2)  ...  H(k),
  !> 
  !>     and if n <= k, Q is defined as the product
  !> 
  !>         Q = H(1)  H(2)  ...  H(nq-1)
  !> 
  !>     The Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vectors v(i) and scalars ipiv_i as returned by
  !>    GEBRD in its arguments A and tauq or taup.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     storev              rocblas_storev.\n
  !>                         Specifies whether to work column-wise or row-wise.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its transpose is to be
  !>    applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0.\n
  !>                         The number of columns (if storev is colum-wise) or rows
  !>    (if row-wise) of the original matrix reduced by GEBRD.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldamin(nq,k)
  !>    if column-wise, or ldanq if row-wise.\n The i-th column (or row) has the
  !>    Householder vector v(i) associated with H(i) as returned by GEBRD.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= nq if column-wise, or lda >=
  !>    min(nq,k) if row-wise. \n Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    min(nq,k).\n The scalar factors of the Householder matrices H(i) as returned
  !>    by GEBRD.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_sormbr
    function rocsolver_sormbr_orig(handle,storev,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_sormbr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormbr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_sormbr_full_rank,rocsolver_sormbr_rank_0,rocsolver_sormbr_rank_1
  end interface
  
  interface rocsolver_dormbr
    function rocsolver_dormbr_orig(handle,storev,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_dormbr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormbr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_dormbr_full_rank,rocsolver_dormbr_rank_0,rocsolver_dormbr_rank_1
  end interface
  !> ! \brief UNMBR applies a complex matrix Q with orthonormal rows or columns to
  !>    a general m-by-n matrix C.
  !> 
  !>     \details
  !>     If storev is column-wise, then the matrix Q has orthonormal columns.
  !>     If storev is row-wise, then the matrix Q has orthonormal rows.
  !>     The matrix Q is applied in one of the following forms, depending on
  !>     the values of side and trans:
  !> 
  !>         Q   C  (No transpose from the left)
  !>         Q'  C  (Conjugate transpose from the left)
  !>         C  Q   (No transpose from the right), and
  !>         C  Q'  (Conjugate transpose from the right)
  !> 
  !>     The order nq of unitary matrix Q is nq = m if applying from the left, or nq
  !>    = n if applying from the right.
  !> 
  !>     When storev is column-wise, if nq >= k, then Q is defined as the product of
  !>    k Householder reflectors of order nq
  !> 
  !>         Q = H(1)  H(2)  ...  H(k),
  !> 
  !>     and if nq < k, then Q is defined as the product
  !> 
  !>         Q = H(1)  H(2)  ...  H(nq-1).
  !> 
  !>     When storev is row-wise, if nq > k, then Q is defined as the product of k
  !>    Householder reflectors of order nq
  !> 
  !>         Q = H(1)  H(2)  ...  H(k),
  !> 
  !>     and if n <= k, Q is defined as the product
  !> 
  !>         Q = H(1)  H(2)  ...  H(nq-1)
  !> 
  !>     The Householder matrices H(i) are never stored, they are computed from its
  !>    corresponding Householder vectors v(i) and scalars ipiv_i as returned by
  !>    GEBRD in its arguments A and tauq or taup.
  !> 
  !>     @param[in]
  !>     handle              rocblas_handle.
  !>     @param[in]
  !>     storev              rocblas_storev.\n
  !>                         Specifies whether to work column-wise or row-wise.
  !>     @param[in]
  !>     side                rocblas_side.\n
  !>                         Specifies from which side to apply Q.
  !>     @param[in]
  !>     trans               rocblas_operation.\n
  !>                         Specifies whether the matrix Q or its conjugate
  !>    transpose is to be applied.
  !>     @param[in]
  !>     m                   rocblas_int. m >= 0.\n
  !>                         Number of rows of matrix C.
  !>     @param[in]
  !>     n                   rocblas_int. n >= 0.\n
  !>                         Number of columns of matrix C.
  !>     @param[in]
  !>     k                   rocsovler_int. k >= 0.\n
  !>                         The number of columns (if storev is colum-wise) or rows
  !>    (if row-wise) of the original matrix reduced by GEBRD.
  !>     @param[in]
  !>     A                   pointer to type. Array on the GPU of size ldamin(nq,k)
  !>    if column-wise, or ldanq if row-wise.\n The i-th column (or row) has the
  !>    Householder vector v(i) associated with H(i) as returned by GEBRD.
  !>     @param[in]
  !>     lda                 rocblas_int. lda >= nq if column-wise, or lda >=
  !>    min(nq,k) if row-wise. \n Leading dimension of A.
  !>     @param[in]
  !>     ipiv                pointer to type. Array on the GPU of dimension at least
  !>    min(nq,k).\n The scalar factors of the Householder matrices H(i) as returned
  !>    by GEBRD.
  !>     @param[inout]
  !>     C                   pointer to type. Array on the GPU of size ldcn.\n
  !>                         On input, the matrix C. On output it is overwritten with
  !>                         QC, CQ, Q'C, or CQ'.
  !>     @param[in]
  !>     lda                 rocblas_int. ldc >= m.\n
  !>                         Leading dimension of C.
  !> 
  !>     
  interface rocsolver_cunmbr
    function rocsolver_cunmbr_orig(handle,storev,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_cunmbr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmbr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_cunmbr_full_rank,rocsolver_cunmbr_rank_0,rocsolver_cunmbr_rank_1
  end interface
  
  interface rocsolver_zunmbr
    function rocsolver_zunmbr_orig(handle,storev,side,n,lda,ipiv,C,ldc) bind(c, name="rocsolver_zunmbr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmbr_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: C
      integer(c_int),value :: ldc
    end function

    module procedure rocsolver_zunmbr_full_rank,rocsolver_zunmbr_rank_0,rocsolver_zunmbr_rank_1
  end interface
  !> ! \brief BDSQR computes the singular value decomposition (SVD) of a
  !>     n-by-n bidiagonal matrix B.
  !> 
  !>     \details
  !>     The SVD of B has the form:
  !> 
  !>         B = Ub  S  Vb'
  !> 
  !>     where S is the n-by-n diagonal matrix of singular values of B, the columns
  !>    of Ub are the left singular vectors of B, and the columns of Vb are its right
  !>    singular vectors.
  !> 
  !>     The computation of the singular vectors is optional; this function accepts
  !>    input matrices U (of size nu-by-n) and V (of size n-by-nv) that are
  !>    overwritten with UUb and Vb'V. If nu = 0 no left vectors are computed; if
  !>    nv = 0 no right vectors are computed.
  !> 
  !>     Optionally, this function can also compute Ub'C for a given n-by-nc input
  !>    matrix C.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     uplo        rocblas_fill.\n
  !>                 Specifies whether B is upper or lower bidiagonal.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of rows and columns of matrix B.
  !>     @param[in]
  !>     nv          rocblas_int. nv >= 0.\n
  !>                 The number of columns of matrix V.
  !>     @param[in]
  !>     nu          rocblas_int. nu >= 0.\n
  !>                 The number of rows of matrix U.
  !>     @param[in]
  !>     nc          rocblas_int. nu >= 0.\n
  !>                 The number of columns of matrix C.
  !>     @param[inout]
  !>     D           pointer to real type. Array on the GPU of dimension n.\n
  !>                 On entry, the diagonal elements of B. On exit, if info = 0,
  !>                 the singular values of B in decreasing order; if info > 0,
  !>                 the diagonal elements of a bidiagonal matrix
  !>                 orthogonally equivalent to B.
  !>     @param[inout]
  !>     E           pointer to real type. Array on the GPU of dimension n-1.\n
  !>                 On entry, the off-diagonal elements of B. On exit, if info > 0,
  !>                 the off-diagonal elements of a bidiagonal matrix
  !>                 orthogonally equivalent to B (if info = 0 this matrix converges
  !>    to zero).
  !>     @param[inout]
  !>     V           pointer to type. Array on the GPU of dimension ldvnv.\n
  !>                 On entry, the matrix V. On exit, it is overwritten with Vb'V.
  !>                 (Not referenced if nv = 0).
  !>     @param[in]
  !>     ldv         rocblas_int. ldv >= n if nv > 0, or ldv >=1 if nv = 0.\n
  !>                 Specifies the leading dimension of V.
  !>     @param[inout]
  !>     U           pointer to type. Array on the GPU of dimension ldun.\n
  !>                 On entry, the matrix U. On exit, it is overwritten with UUb.
  !>                 (Not referenced if nu = 0).
  !>     @param[in]
  !>     ldu         rocblas_int. ldu >= nu.\n
  !>                 Specifies the leading dimension of U.
  !>     @param[inout]
  !>     C           pointer to type. Array on the GPU of dimension ldcnc.\n
  !>                 On entry, the matrix C. On exit, it is overwritten with Ub'C.
  !>                 (Not referenced if nc = 0).
  !>     @param[in]
  !>     ldc         rocblas_int. ldc >= n if nc > 0, or ldc >=1 if nc = 0.\n
  !>                 Specifies the leading dimension of C.
  !>     @param[out]
  !>     info        pointer to a rocblas_int on the GPU.\n
  !>                 If info = 0, successful exit.
  !>                 If info = i > 0, i elements of E have not converged to zero.
  !> 
  !>     
  interface rocsolver_sbdsqr
    function rocsolver_sbdsqr_orig(handle,n,nc,D,E,V,ldu,C,myInfo) bind(c, name="rocsolver_sbdsqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sbdsqr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: V
      integer(c_int),value :: ldu
      type(c_ptr),value :: C
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_sbdsqr_full_rank,rocsolver_sbdsqr_rank_0,rocsolver_sbdsqr_rank_1
  end interface
  
  interface rocsolver_dbdsqr
    function rocsolver_dbdsqr_orig(handle,n,nc,D,E,V,ldv,U,myInfo) bind(c, name="rocsolver_dbdsqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dbdsqr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      type(c_ptr),value :: U
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dbdsqr_full_rank,rocsolver_dbdsqr_rank_0,rocsolver_dbdsqr_rank_1
  end interface
  
  interface rocsolver_cbdsqr
    function rocsolver_cbdsqr_orig(handle,n,nc,D,E,V,ldv,U,ldu,C,myInfo) bind(c, name="rocsolver_cbdsqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cbdsqr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      type(c_ptr),value :: U
      integer(c_int),value :: ldu
      type(c_ptr),value :: C
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cbdsqr_full_rank,rocsolver_cbdsqr_rank_0,rocsolver_cbdsqr_rank_1
  end interface
  
  interface rocsolver_zbdsqr
    function rocsolver_zbdsqr_orig(handle,n,nc,D,E,V,ldv,U,ldu,C,myInfo) bind(c, name="rocsolver_zbdsqr")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zbdsqr_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      type(c_ptr),value :: U
      integer(c_int),value :: ldu
      type(c_ptr),value :: C
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zbdsqr_full_rank,rocsolver_zbdsqr_rank_0,rocsolver_zbdsqr_rank_1
  end interface
  !> ! \brief GETF2_NPVT computes the LU factorization of a general m-by-n matrix A
  !>     without partial pivoting.
  !> 
  !>     \details
  !>     (This is the unblocked Level-2-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with small
  !>    and mid-size matrices if optimizations are enabled (default option). For more
  !>    details see the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization has the form
  !> 
  !>         A = L  U
  !> 
  !>     where L is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     Note: Although this routine can offer better performance, Gaussian
  !>    elimination without pivoting is not backward stable. If numerical accuracy is
  !>    compromised, use the legacy-LAPACK-like API GETF2 routines instead.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix A to be factored.
  !>               On exit, the factors L and U from the factorization.
  !>               The unit diagonal elements of L are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     info      pointer to a rocblas_int on the GPU.\n
  !>               If info = 0, successful exit.
  !>               If info = i > 0, U is singular. U(i,i) is the first zero element
  !>    in the diagonal. The factorization from this point might be incomplete.
  !> 
  !>     
  interface rocsolver_sgetf2_npvt
    function rocsolver_sgetf2_npvt_orig(handle,n,A,myInfo) bind(c, name="rocsolver_sgetf2_npvt")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_sgetf2_npvt_full_rank,rocsolver_sgetf2_npvt_rank_0,rocsolver_sgetf2_npvt_rank_1
  end interface
  
  interface rocsolver_dgetf2_npvt
    function rocsolver_dgetf2_npvt_orig(handle,n,A,myInfo) bind(c, name="rocsolver_dgetf2_npvt")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dgetf2_npvt_full_rank,rocsolver_dgetf2_npvt_rank_0,rocsolver_dgetf2_npvt_rank_1
  end interface
  
  interface rocsolver_cgetf2_npvt
    function rocsolver_cgetf2_npvt_orig(handle,n,A,myInfo) bind(c, name="rocsolver_cgetf2_npvt")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cgetf2_npvt_full_rank,rocsolver_cgetf2_npvt_rank_0,rocsolver_cgetf2_npvt_rank_1
  end interface
  
  interface rocsolver_zgetf2_npvt
    function rocsolver_zgetf2_npvt_orig(handle,n,A,myInfo) bind(c, name="rocsolver_zgetf2_npvt")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zgetf2_npvt_full_rank,rocsolver_zgetf2_npvt_rank_0,rocsolver_zgetf2_npvt_rank_1
  end interface
  !> ! \brief GETF2_NPVT_BATCHED computes the LU factorization of a batch of
  !>    general m-by-n matrices without partial pivoting.
  !> 
  !>     \details
  !>     (This is the unblocked Level-2-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with small
  !>    and mid-size matrices if optimizations are enabled (default option). For more
  !>    details see the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization of matrix A_i in the batch has the form
  !> 
  !>         A_i = L_i  U_i
  !> 
  !>     where L_i is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U_i is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     Note: Although this routine can offer better performance, Gaussian
  !>    elimination without pivoting is not backward stable. If numerical accuracy is
  !>    compromised, use the legacy-LAPACK-like API GETF2 routines instead.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all matrices A_i in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_i to be factored.
  !>               On exit, the factors L_i and U_i from the factorizations.
  !>               The unit diagonal elements of L_i are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_i.
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful exit for factorization of A_i. If info_i = j
  !>    > 0, U_i is singular. U_i(j,j) is the first zero element in the diagonal. The
  !>    factorization from this point might be incomplete.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetf2_npvt_batched
    function rocsolver_sgetf2_npvt_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_sgetf2_npvt_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetf2_npvt_batched_full_rank,rocsolver_sgetf2_npvt_batched_rank_0,rocsolver_sgetf2_npvt_batched_rank_1
  end interface
  
  interface rocsolver_dgetf2_npvt_batched
    function rocsolver_dgetf2_npvt_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_dgetf2_npvt_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetf2_npvt_batched_full_rank,rocsolver_dgetf2_npvt_batched_rank_0,rocsolver_dgetf2_npvt_batched_rank_1
  end interface
  
  interface rocsolver_cgetf2_npvt_batched
    function rocsolver_cgetf2_npvt_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_cgetf2_npvt_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetf2_npvt_batched_full_rank,rocsolver_cgetf2_npvt_batched_rank_0,rocsolver_cgetf2_npvt_batched_rank_1
  end interface
  
  interface rocsolver_zgetf2_npvt_batched
    function rocsolver_zgetf2_npvt_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_zgetf2_npvt_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetf2_npvt_batched_full_rank,rocsolver_zgetf2_npvt_batched_rank_0,rocsolver_zgetf2_npvt_batched_rank_1
  end interface
  !> ! \brief GETF2_NPVT_STRIDED_BATCHED computes the LU factorization of a batch
  !>    of general m-by-n matrices without partial pivoting.
  !> 
  !>     \details
  !>     (This is the unblocked Level-2-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with small
  !>    and mid-size matrices if optimizations are enabled (default option). For more
  !>    details see the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization of matrix A_i in the batch has the form
  !> 
  !>         A_i = L_i  U_i
  !> 
  !>     where L_i is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U_i is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     Note: Although this routine can offer better performance, Gaussian
  !>    elimination without pivoting is not backward stable. If numerical accuracy is
  !>    compromised, use the legacy-LAPACK-like API GETF2 routines instead.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all matrices A_i in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_i to be factored. On exit, the
  !>    factors L_i and U_i from the factorization. The unit diagonal elements of L_i
  !>    are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_i.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_i and the next one A_(i+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful exit for factorization of A_i. If info_i = j
  !>    > 0, U_i is singular. U_i(j,j) is the first zero element in the diagonal. The
  !>    factorization from this point might be incomplete.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetf2_npvt_strided_batched
    function rocsolver_sgetf2_npvt_strided_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_sgetf2_npvt_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetf2_npvt_strided_batched_full_rank,rocsolver_sgetf2_npvt_strided_batched_rank_0,rocsolver_sgetf2_npvt_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgetf2_npvt_strided_batched
    function rocsolver_dgetf2_npvt_strided_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_dgetf2_npvt_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetf2_npvt_strided_batched_full_rank,rocsolver_dgetf2_npvt_strided_batched_rank_0,rocsolver_dgetf2_npvt_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgetf2_npvt_strided_batched
    function rocsolver_cgetf2_npvt_strided_batched_orig(handle,n,A,lda,myInfo,batch_count) bind(c, name="rocsolver_cgetf2_npvt_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetf2_npvt_strided_batched_full_rank,rocsolver_cgetf2_npvt_strided_batched_rank_0,rocsolver_cgetf2_npvt_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgetf2_npvt_strided_batched
    function rocsolver_zgetf2_npvt_strided_batched_orig(handle,n,A,lda,myInfo,batch_count) bind(c, name="rocsolver_zgetf2_npvt_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetf2_npvt_strided_batched_full_rank,rocsolver_zgetf2_npvt_strided_batched_rank_0,rocsolver_zgetf2_npvt_strided_batched_rank_1
  end interface
  !> ! \brief GETRF_NPVT computes the LU factorization of a general m-by-n matrix A
  !>     without partial pivoting.
  !> 
  !>     \details
  !>     (This is the blocked Level-3-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with mid-size
  !>    matrices if optimizations are enabled (default option). For more details see
  !>    the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization has the form
  !> 
  !>         A = L  U
  !> 
  !>     where L is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     Note: Although this routine can offer better performance, Gaussian
  !>    elimination without pivoting is not backward stable. If numerical accuracy is
  !>    compromised, use the legacy-LAPACK-like API GETRF routines instead.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix A to be factored.
  !>               On exit, the factors L and U from the factorization.
  !>               The unit diagonal elements of L are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     info      pointer to a rocblas_int on the GPU.\n
  !>               If info = 0, successful exit.
  !>               If info = i > 0, U is singular. U(i,i) is the first zero element
  !>    in the diagonal. The factorization from this point might be incomplete.
  !> 
  !>     
  interface rocsolver_sgetrf_npvt
    function rocsolver_sgetrf_npvt_orig(handle,n,A,myInfo) bind(c, name="rocsolver_sgetrf_npvt")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_sgetrf_npvt_full_rank,rocsolver_sgetrf_npvt_rank_0,rocsolver_sgetrf_npvt_rank_1
  end interface
  
  interface rocsolver_dgetrf_npvt
    function rocsolver_dgetrf_npvt_orig(handle,n,A,myInfo) bind(c, name="rocsolver_dgetrf_npvt")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dgetrf_npvt_full_rank,rocsolver_dgetrf_npvt_rank_0,rocsolver_dgetrf_npvt_rank_1
  end interface
  
  interface rocsolver_cgetrf_npvt
    function rocsolver_cgetrf_npvt_orig(handle,n,A,myInfo) bind(c, name="rocsolver_cgetrf_npvt")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cgetrf_npvt_full_rank,rocsolver_cgetrf_npvt_rank_0,rocsolver_cgetrf_npvt_rank_1
  end interface
  
  interface rocsolver_zgetrf_npvt
    function rocsolver_zgetrf_npvt_orig(handle,n,A,myInfo) bind(c, name="rocsolver_zgetrf_npvt")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zgetrf_npvt_full_rank,rocsolver_zgetrf_npvt_rank_0,rocsolver_zgetrf_npvt_rank_1
  end interface
  !> ! \brief GETRF_NPVT_BATCHED computes the LU factorization of a batch of
  !>    general m-by-n matrices without partial pivoting.
  !> 
  !>     \details
  !>     (This is the blocked Level-3-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with mid-size
  !>    matrices if optimizations are enabled (default option). For more details see
  !>    the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization of matrix A_i in the batch has the form
  !> 
  !>         A_i = L_i  U_i
  !> 
  !>     where L_i is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U_i is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     Note: Although this routine can offer better performance, Gaussian
  !>    elimination without pivoting is not backward stable. If numerical accuracy is
  !>    compromised, use the legacy-LAPACK-like API GETRF routines instead.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all matrices A_i in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_i to be factored.
  !>               On exit, the factors L_i and U_i from the factorizations.
  !>               The unit diagonal elements of L_i are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_i.
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful exit for factorization of A_i. If info_i = j
  !>    > 0, U_i is singular. U_i(j,j) is the first zero element in the diagonal. The
  !>    factorization from this point might be incomplete.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetrf_npvt_batched
    function rocsolver_sgetrf_npvt_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_sgetrf_npvt_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetrf_npvt_batched_full_rank,rocsolver_sgetrf_npvt_batched_rank_0,rocsolver_sgetrf_npvt_batched_rank_1
  end interface
  
  interface rocsolver_dgetrf_npvt_batched
    function rocsolver_dgetrf_npvt_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_dgetrf_npvt_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetrf_npvt_batched_full_rank,rocsolver_dgetrf_npvt_batched_rank_0,rocsolver_dgetrf_npvt_batched_rank_1
  end interface
  
  interface rocsolver_cgetrf_npvt_batched
    function rocsolver_cgetrf_npvt_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_cgetrf_npvt_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetrf_npvt_batched_full_rank,rocsolver_cgetrf_npvt_batched_rank_0,rocsolver_cgetrf_npvt_batched_rank_1
  end interface
  
  interface rocsolver_zgetrf_npvt_batched
    function rocsolver_zgetrf_npvt_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_zgetrf_npvt_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetrf_npvt_batched_full_rank,rocsolver_zgetrf_npvt_batched_rank_0,rocsolver_zgetrf_npvt_batched_rank_1
  end interface
  !> ! \brief GETRF_NPVT_STRIDED_BATCHED computes the LU factorization of a batch
  !>    of general m-by-n matrices without partial pivoting.
  !> 
  !>     \details
  !>     (This is the blocked Level-3-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with mid-size
  !>    matrices if optimizations are enabled (default option). For more details see
  !>    the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization of matrix A_i in the batch has the form
  !> 
  !>         A_i = L_i  U_i
  !> 
  !>     where L_i is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U_i is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     Note: Although this routine can offer better performance, Gaussian
  !>    elimination without pivoting is not backward stable. If numerical accuracy is
  !>    compromised, use the legacy-LAPACK-like API GETRF routines instead.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all matrices A_i in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_i to be factored. On exit, the
  !>    factors L_i and U_i from the factorization. The unit diagonal elements of L_i
  !>    are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_i.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_i and the next one A_(i+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful exit for factorization of A_i. If info_i = j
  !>    > 0, U_i is singular. U_i(j,j) is the first zero element in the diagonal. The
  !>    factorization from this point might be incomplete.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetrf_npvt_strided_batched
    function rocsolver_sgetrf_npvt_strided_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_sgetrf_npvt_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetrf_npvt_strided_batched_full_rank,rocsolver_sgetrf_npvt_strided_batched_rank_0,rocsolver_sgetrf_npvt_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgetrf_npvt_strided_batched
    function rocsolver_dgetrf_npvt_strided_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_dgetrf_npvt_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetrf_npvt_strided_batched_full_rank,rocsolver_dgetrf_npvt_strided_batched_rank_0,rocsolver_dgetrf_npvt_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgetrf_npvt_strided_batched
    function rocsolver_cgetrf_npvt_strided_batched_orig(handle,n,A,lda,myInfo,batch_count) bind(c, name="rocsolver_cgetrf_npvt_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetrf_npvt_strided_batched_full_rank,rocsolver_cgetrf_npvt_strided_batched_rank_0,rocsolver_cgetrf_npvt_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgetrf_npvt_strided_batched
    function rocsolver_zgetrf_npvt_strided_batched_orig(handle,n,A,lda,myInfo,batch_count) bind(c, name="rocsolver_zgetrf_npvt_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetrf_npvt_strided_batched_full_rank,rocsolver_zgetrf_npvt_strided_batched_rank_0,rocsolver_zgetrf_npvt_strided_batched_rank_1
  end interface
  !> ! \brief GETF2 computes the LU factorization of a general m-by-n matrix A
  !>     using partial pivoting with row interchanges.
  !> 
  !>     \details
  !>     (This is the unblocked Level-2-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with small
  !>    and mid-size matrices if optimizations are enabled (default option). For more
  !>    details see the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization has the form
  !> 
  !>         A = P  L  U
  !> 
  !>     where P is a permutation matrix, L is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix A to be factored.
  !>               On exit, the factors L and U from the factorization.
  !>               The unit diagonal elements of L are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     ipiv      pointer to rocblas_int. Array on the GPU of dimension min(m,n).\n
  !>               The vector of pivot indices. Elements of ipiv are 1-based indices.
  !>               For 1 <= i <= min(m,n), the row i of the
  !>               matrix was interchanged with row ipiv[i].
  !>               Matrix P of the factorization can be derived from ipiv.
  !>     @param[out]
  !>     info      pointer to a rocblas_int on the GPU.\n
  !>               If info = 0, successful exit.
  !>               If info = i > 0, U is singular. U(i,i) is the first zero pivot.
  !> 
  !>     
  interface rocsolver_sgetf2
    function rocsolver_sgetf2_orig(handle,n,A,myInfo) bind(c, name="rocsolver_sgetf2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_sgetf2_full_rank,rocsolver_sgetf2_rank_0,rocsolver_sgetf2_rank_1
  end interface
  
  interface rocsolver_dgetf2
    function rocsolver_dgetf2_orig(handle,n,A,myInfo) bind(c, name="rocsolver_dgetf2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dgetf2_full_rank,rocsolver_dgetf2_rank_0,rocsolver_dgetf2_rank_1
  end interface
  
  interface rocsolver_cgetf2
    function rocsolver_cgetf2_orig(handle,m,n,A,myInfo) bind(c, name="rocsolver_cgetf2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cgetf2_full_rank,rocsolver_cgetf2_rank_0,rocsolver_cgetf2_rank_1
  end interface
  
  interface rocsolver_zgetf2
    function rocsolver_zgetf2_orig(handle,m,n,A,myInfo) bind(c, name="rocsolver_zgetf2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zgetf2_full_rank,rocsolver_zgetf2_rank_0,rocsolver_zgetf2_rank_1
  end interface
  !> ! \brief GETF2_BATCHED computes the LU factorization of a batch of general
  !>    m-by-n matrices using partial pivoting with row interchanges.
  !> 
  !>     \details
  !>     (This is the unblocked Level-2-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with small
  !>    and mid-size matrices if optimizations are enabled (default option). For more
  !>    details see the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !> 
  !>     The factorization of matrix A_i in the batch has the form
  !> 
  !>         A_i = P_i  L_i  U_i
  !> 
  !>     where P_i is a permutation matrix, L_i is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U_i is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all matrices A_i in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_i to be factored.
  !>               On exit, the factors L_i and U_i from the factorizations.
  !>               The unit diagonal elements of L_i are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_i.
  !>     @param[out]
  !>     ipiv      pointer to rocblas_int. Array on the GPU (the size depends on the
  !>    value of strideP).\n Contains the vectors of pivot indices ipiv_i
  !>    (corresponding to A_i). Dimension of ipiv_i is min(m,n). Elements of ipiv_i
  !>    are 1-based indices. For each instance A_i in the batch and for 1 <= j <=
  !>    min(m,n), the row j of the matrix A_i was interchanged with row ipiv_i[j].
  !>               Matrix P_i of the factorization can be derived from ipiv_i.
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_i to the next one
  !>    ipiv_(i+1). There is no restriction for the value of strideP. Normal use case
  !>    is strideP >= min(m,n).
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful exit for factorization of A_i. If info_i = j
  !>    > 0, U_i is singular. U_i(j,j) is the first zero pivot.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetf2_batched
    function rocsolver_sgetf2_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_sgetf2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetf2_batched_full_rank,rocsolver_sgetf2_batched_rank_0,rocsolver_sgetf2_batched_rank_1
  end interface
  
  interface rocsolver_dgetf2_batched
    function rocsolver_dgetf2_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_dgetf2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetf2_batched_full_rank,rocsolver_dgetf2_batched_rank_0,rocsolver_dgetf2_batched_rank_1
  end interface
  
  interface rocsolver_cgetf2_batched
    function rocsolver_cgetf2_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_cgetf2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetf2_batched_full_rank,rocsolver_cgetf2_batched_rank_0,rocsolver_cgetf2_batched_rank_1
  end interface
  
  interface rocsolver_zgetf2_batched
    function rocsolver_zgetf2_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_zgetf2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetf2_batched_full_rank,rocsolver_zgetf2_batched_rank_0,rocsolver_zgetf2_batched_rank_1
  end interface
  !> ! \brief GETF2_STRIDED_BATCHED computes the LU factorization of a batch of
  !>    general m-by-n matrices using partial pivoting with row interchanges.
  !> 
  !>     \details
  !>     (This is the unblocked Level-2-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with small
  !>    and mid-size matrices if optimizations are enabled (default option). For more
  !>    details see the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !> 
  !>     The factorization of matrix A_i in the batch has the form
  !> 
  !>         A_i = P_i  L_i  U_i
  !> 
  !>     where P_i is a permutation matrix, L_i is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U_i is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all matrices A_i in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_i to be factored. On exit, the
  !>    factors L_i and U_i from the factorization. The unit diagonal elements of L_i
  !>    are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_i.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_i and the next one A_(i+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan
  !>     @param[out]
  !>     ipiv      pointer to rocblas_int. Array on the GPU (the size depends on the
  !>    value of strideP).\n Contains the vectors of pivots indices ipiv_i
  !>    (corresponding to A_i). Dimension of ipiv_i is min(m,n). Elements of ipiv_i
  !>    are 1-based indices. For each instance A_i in the batch and for 1 <= j <=
  !>    min(m,n), the row j of the matrix A_i was interchanged with row ipiv_i[j].
  !>               Matrix P_i of the factorization can be derived from ipiv_i.
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_i to the next one
  !>    ipiv_(i+1). There is no restriction for the value of strideP. Normal use case
  !>    is strideP >= min(m,n).
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful exit for factorization of A_i. If info_i = j
  !>    > 0, U_i is singular. U_i(j,j) is the first zero pivot.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetf2_strided_batched
    function rocsolver_sgetf2_strided_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_sgetf2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetf2_strided_batched_full_rank,rocsolver_sgetf2_strided_batched_rank_0,rocsolver_sgetf2_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgetf2_strided_batched
    function rocsolver_dgetf2_strided_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_dgetf2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetf2_strided_batched_full_rank,rocsolver_dgetf2_strided_batched_rank_0,rocsolver_dgetf2_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgetf2_strided_batched
    function rocsolver_cgetf2_strided_batched_orig(handle,n,A,lda,ipiv,myInfo,batch_count) bind(c, name="rocsolver_cgetf2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetf2_strided_batched_full_rank,rocsolver_cgetf2_strided_batched_rank_0,rocsolver_cgetf2_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgetf2_strided_batched
    function rocsolver_zgetf2_strided_batched_orig(handle,n,A,lda,ipiv,myInfo,batch_count) bind(c, name="rocsolver_zgetf2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetf2_strided_batched_full_rank,rocsolver_zgetf2_strided_batched_rank_0,rocsolver_zgetf2_strided_batched_rank_1
  end interface
  !> ! \brief GETRF computes the LU factorization of a general m-by-n matrix A
  !>     using partial pivoting with row interchanges.
  !> 
  !>     \details
  !>     (This is the blocked Level-3-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with mid-size
  !>    matrices if optimizations are enabled (default option). For more details see
  !>    the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization has the form
  !> 
  !>         A = P  L  U
  !> 
  !>     where P is a permutation matrix, L is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix A to be factored.
  !>               On exit, the factors L and U from the factorization.
  !>               The unit diagonal elements of L are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     ipiv      pointer to rocblas_int. Array on the GPU of dimension min(m,n).\n
  !>               The vector of pivot indices. Elements of ipiv are 1-based indices.
  !>               For 1 <= i <= min(m,n), the row i of the
  !>               matrix was interchanged with row ipiv[i].
  !>               Matrix P of the factorization can be derived from ipiv.
  !>     @param[out]
  !>     info      pointer to a rocblas_int on the GPU.\n
  !>               If info = 0, successful exit.
  !>               If info = i > 0, U is singular. U(i,i) is the first zero pivot.
  !> 
  !>     
  interface rocsolver_sgetrf
    function rocsolver_sgetrf_orig(handle,n,A,myInfo) bind(c, name="rocsolver_sgetrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_sgetrf_full_rank,rocsolver_sgetrf_rank_0,rocsolver_sgetrf_rank_1
  end interface
  
  interface rocsolver_dgetrf
    function rocsolver_dgetrf_orig(handle,n,A,myInfo) bind(c, name="rocsolver_dgetrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dgetrf_full_rank,rocsolver_dgetrf_rank_0,rocsolver_dgetrf_rank_1
  end interface
  
  interface rocsolver_cgetrf
    function rocsolver_cgetrf_orig(handle,m,n,A,myInfo) bind(c, name="rocsolver_cgetrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cgetrf_full_rank,rocsolver_cgetrf_rank_0,rocsolver_cgetrf_rank_1
  end interface
  
  interface rocsolver_zgetrf
    function rocsolver_zgetrf_orig(handle,m,n,A,myInfo) bind(c, name="rocsolver_zgetrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zgetrf_full_rank,rocsolver_zgetrf_rank_0,rocsolver_zgetrf_rank_1
  end interface
  !> ! \brief GETRF_BATCHED computes the LU factorization of a batch of general
  !>    m-by-n matrices using partial pivoting with row interchanges.
  !> 
  !>     \details
  !>     (This is the blocked Level-3-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with mid-size
  !>    matrices if optimizations are enabled (default option). For more details see
  !>    the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization of matrix A_i in the batch has the form
  !> 
  !>         A_i = P_i  L_i  U_i
  !> 
  !>     where P_i is a permutation matrix, L_i is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U_i is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all matrices A_i in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_i to be factored.
  !>               On exit, the factors L_i and U_i from the factorizations.
  !>               The unit diagonal elements of L_i are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_i.
  !>     @param[out]
  !>     ipiv      pointer to rocblas_int. Array on the GPU (the size depends on the
  !>    value of strideP).\n Contains the vectors of pivot indices ipiv_i
  !>    (corresponding to A_i). Dimension of ipiv_i is min(m,n). Elements of ipiv_i
  !>    are 1-based indices. For each instance A_i in the batch and for 1 <= j <=
  !>    min(m,n), the row j of the matrix A_i was interchanged with row ipiv_i(j).
  !>               Matrix P_i of the factorization can be derived from ipiv_i.
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_i to the next one
  !>    ipiv_(i+1). There is no restriction for the value of strideP. Normal use case
  !>    is strideP >= min(m,n).
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful exit for factorization of A_i. If info_i = j
  !>    > 0, U_i is singular. U_i(j,j) is the first zero pivot.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetrf_batched
    function rocsolver_sgetrf_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_sgetrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetrf_batched_full_rank,rocsolver_sgetrf_batched_rank_0,rocsolver_sgetrf_batched_rank_1
  end interface
  
  interface rocsolver_dgetrf_batched
    function rocsolver_dgetrf_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_dgetrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetrf_batched_full_rank,rocsolver_dgetrf_batched_rank_0,rocsolver_dgetrf_batched_rank_1
  end interface
  
  interface rocsolver_cgetrf_batched
    function rocsolver_cgetrf_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_cgetrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetrf_batched_full_rank,rocsolver_cgetrf_batched_rank_0,rocsolver_cgetrf_batched_rank_1
  end interface
  
  interface rocsolver_zgetrf_batched
    function rocsolver_zgetrf_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_zgetrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetrf_batched_full_rank,rocsolver_zgetrf_batched_rank_0,rocsolver_zgetrf_batched_rank_1
  end interface
  !> ! \brief GETRF_STRIDED_BATCHED computes the LU factorization of a batch of
  !>    general m-by-n matrices using partial pivoting with row interchanges.
  !> 
  !>     \details
  !>     (This is the blocked Level-3-BLAS version of the algorithm. An optimized
  !>    internal implementation without rocBLAS calls could be executed with mid-size
  !>    matrices if optimizations are enabled (default option). For more details see
  !>    the section "tuning rocSOLVER performance" on the User's guide).
  !> 
  !>     The factorization of matrix A_i in the batch has the form
  !> 
  !>         A_i = P_i  L_i  U_i
  !> 
  !>     where P_i is a permutation matrix, L_i is lower triangular with unit
  !>     diagonal elements (lower trapezoidal if m > n), and U_i is upper
  !>     triangular (upper trapezoidal if m < n).
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all matrices A_i in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_i to be factored. On exit, the
  !>    factors L_i and U_i from the factorization. The unit diagonal elements of L_i
  !>    are not stored.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_i.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_i and the next one A_(i+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan
  !>     @param[out]
  !>     ipiv      pointer to rocblas_int. Array on the GPU (the size depends on the
  !>    value of strideP).\n Contains the vectors of pivots indices ipiv_i
  !>    (corresponding to A_i). Dimension of ipiv_i is min(m,n). Elements of ipiv_i
  !>    are 1-based indices. For each instance A_i in the batch and for 1 <= j <=
  !>    min(m,n), the row j of the matrix A_i was interchanged with row ipiv_i(j).
  !>               Matrix P_i of the factorization can be derived from ipiv_i.
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_i to the next one
  !>    ipiv_(i+1). There is no restriction for the value of strideP. Normal use case
  !>    is strideP >= min(m,n).
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful exit for factorization of A_i. If info_i = j
  !>    > 0, U_i is singular. U_i(j,j) is the first zero pivot.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetrf_strided_batched
    function rocsolver_sgetrf_strided_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_sgetrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetrf_strided_batched_full_rank,rocsolver_sgetrf_strided_batched_rank_0,rocsolver_sgetrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgetrf_strided_batched
    function rocsolver_dgetrf_strided_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_dgetrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetrf_strided_batched_full_rank,rocsolver_dgetrf_strided_batched_rank_0,rocsolver_dgetrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgetrf_strided_batched
    function rocsolver_cgetrf_strided_batched_orig(handle,n,A,lda,ipiv,myInfo,batch_count) bind(c, name="rocsolver_cgetrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetrf_strided_batched_full_rank,rocsolver_cgetrf_strided_batched_rank_0,rocsolver_cgetrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgetrf_strided_batched
    function rocsolver_zgetrf_strided_batched_orig(handle,n,A,lda,ipiv,myInfo,batch_count) bind(c, name="rocsolver_zgetrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetrf_strided_batched_full_rank,rocsolver_zgetrf_strided_batched_rank_0,rocsolver_zgetrf_strided_batched_rank_1
  end interface
  !> ! \brief GEQR2 computes a QR factorization of a general m-by-n matrix A.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization has the form
  !> 
  !>         A =  Q  [ R ]
  !>                  [ 0 ]
  !> 
  !>     where R is upper triangular (upper trapezoidal if m < n), and Q is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q = H(1)  H(2)  ...  H(k), with k = min(m,n)
  !> 
  !>     Each Householder matrix H(i), for i = 1,2,...,k, is given by
  !> 
  !>         H(i) = I - ipiv[i-1]  v(i)  v(i)'
  !> 
  !>     where the first i-1 elements of the Householder vector v(i) are zero, and
  !>    v(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on and above the diagonal contain the
  !>               factor R; the elements below the diagonal are the m - i elements
  !>               of vector v(i) for i = 1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices H(i).
  !> 
  !>     
  interface rocsolver_sgeqr2
    function rocsolver_sgeqr2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_sgeqr2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sgeqr2_full_rank,rocsolver_sgeqr2_rank_0,rocsolver_sgeqr2_rank_1
  end interface
  
  interface rocsolver_dgeqr2
    function rocsolver_dgeqr2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_dgeqr2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dgeqr2_full_rank,rocsolver_dgeqr2_rank_0,rocsolver_dgeqr2_rank_1
  end interface
  
  interface rocsolver_cgeqr2
    function rocsolver_cgeqr2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_cgeqr2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cgeqr2_full_rank,rocsolver_cgeqr2_rank_0,rocsolver_cgeqr2_rank_1
  end interface
  
  interface rocsolver_zgeqr2
    function rocsolver_zgeqr2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_zgeqr2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zgeqr2_full_rank,rocsolver_zgeqr2_rank_0,rocsolver_zgeqr2_rank_1
  end interface
  !> ! \brief GEQR2_BATCHED computes the QR factorization of a batch of general
  !>    m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j =  Q_j  [ R_j ]
  !>                      [  0  ]
  !> 
  !>     where R_j is upper triangular (upper trapezoidal if m < n), and Q_j is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(1)  H_j(2)  ...  H_j(k), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)  v_j(i)'
  !> 
  !>     where the first i-1 elements of Householder vector v_j(i) are zero, and
  !>    v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         Array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_j to be factored.
  !>               On exit, the elements on and above the diagonal contain the
  !>               factor R_j. The elements below the diagonal are the m - i elements
  !>               of vector v_j(i) for i=1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgeqr2_batched
    function rocsolver_sgeqr2_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_sgeqr2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgeqr2_batched_full_rank,rocsolver_sgeqr2_batched_rank_0,rocsolver_sgeqr2_batched_rank_1
  end interface
  
  interface rocsolver_dgeqr2_batched
    function rocsolver_dgeqr2_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_dgeqr2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgeqr2_batched_full_rank,rocsolver_dgeqr2_batched_rank_0,rocsolver_dgeqr2_batched_rank_1
  end interface
  
  interface rocsolver_cgeqr2_batched
    function rocsolver_cgeqr2_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_cgeqr2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgeqr2_batched_full_rank,rocsolver_cgeqr2_batched_rank_0,rocsolver_cgeqr2_batched_rank_1
  end interface
  
  interface rocsolver_zgeqr2_batched
    function rocsolver_zgeqr2_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_zgeqr2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgeqr2_batched_full_rank,rocsolver_zgeqr2_batched_rank_0,rocsolver_zgeqr2_batched_rank_1
  end interface
  !> ! \brief GEQR2_STRIDED_BATCHED computes the QR factorization of a batch of
  !>    general m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j =  Q_j  [ R_j ]
  !>                      [  0  ]
  !> 
  !>     where R_j is upper triangular (upper trapezoidal if m < n), and Q_j is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(1)  H_j(2)  ...  H_j(k), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)  v_j(i)'
  !> 
  !>     where the first i-1 elements of Householder vector v_j(i) are zero, and
  !>    v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_j to be factored. On exit, the
  !>    elements on and above the diagonal contain the factor R_j. The elements below
  !>    the diagonal are the m - i elements of vector v_j(i) for i =
  !>    1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgeqr2_strided_batched
    function rocsolver_sgeqr2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_sgeqr2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgeqr2_strided_batched_full_rank,rocsolver_sgeqr2_strided_batched_rank_0,rocsolver_sgeqr2_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgeqr2_strided_batched
    function rocsolver_dgeqr2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_dgeqr2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgeqr2_strided_batched_full_rank,rocsolver_dgeqr2_strided_batched_rank_0,rocsolver_dgeqr2_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgeqr2_strided_batched
    function rocsolver_cgeqr2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_cgeqr2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgeqr2_strided_batched_full_rank,rocsolver_cgeqr2_strided_batched_rank_0,rocsolver_cgeqr2_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgeqr2_strided_batched
    function rocsolver_zgeqr2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_zgeqr2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgeqr2_strided_batched_full_rank,rocsolver_zgeqr2_strided_batched_rank_0,rocsolver_zgeqr2_strided_batched_rank_1
  end interface
  !> ! \brief GEQL2 computes a QL factorization of a general m-by-n matrix A.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization has the form
  !> 
  !>         A =  Q  [ 0 ]
  !>                  [ L ]
  !> 
  !>     where L is lower triangular (lower trapezoidal if m < n), and Q is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q = H(k)  ...  H(2)  H(1), with k = min(m,n)
  !> 
  !>     Each Householder matrix H(i), for i = 1,2,...,k, is given by
  !> 
  !>         H(i) = I - ipiv[i-1]  v(i)  v(i)'
  !> 
  !>     where the last m-i elements of the Householder vector v(i) are zero, and
  !>    v(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on and below the (m-n)th subdiagonal (when
  !>               m >= n) or the (n-m)th superdiagonal (when n > m) contain the
  !>               factor L; the elements above the subsuperdiagonal are the i - 1
  !>               elements of vector v(i) for i = 1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices H(i).
  !> 
  !>     
  interface rocsolver_sgeql2
    function rocsolver_sgeql2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_sgeql2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sgeql2_full_rank,rocsolver_sgeql2_rank_0,rocsolver_sgeql2_rank_1
  end interface
  
  interface rocsolver_dgeql2
    function rocsolver_dgeql2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_dgeql2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dgeql2_full_rank,rocsolver_dgeql2_rank_0,rocsolver_dgeql2_rank_1
  end interface
  
  interface rocsolver_cgeql2
    function rocsolver_cgeql2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_cgeql2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cgeql2_full_rank,rocsolver_cgeql2_rank_0,rocsolver_cgeql2_rank_1
  end interface
  
  interface rocsolver_zgeql2
    function rocsolver_zgeql2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_zgeql2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zgeql2_full_rank,rocsolver_zgeql2_rank_0,rocsolver_zgeql2_rank_1
  end interface
  !> ! \brief GEQL2_BATCHED computes the QL factorization of a batch of general
  !>    m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j =  Q_j  [  0  ]
  !>                      [ L_j ]
  !> 
  !>     where L_j is lower triangular (lower trapezoidal if m < n), and Q_j is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(k)  ...  H_j(2)  H_j(1), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)  v_j(i)'
  !> 
  !>     where the last m-i elements of Householder vector v_j(i) are zero, and
  !>    v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         Array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_j to be factored.
  !>               On exit, the elements on and below the (m-n)th subdiagonal (when
  !>               m >= n) or the (n-m)th superdiagonal (when n > m) contain the
  !>               factor L_j; the elements above the subsuperdiagonal are the i - 1
  !>               elements of vector v_j(i) for i = 1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgeql2_batched
    function rocsolver_sgeql2_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_sgeql2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgeql2_batched_full_rank,rocsolver_sgeql2_batched_rank_0,rocsolver_sgeql2_batched_rank_1
  end interface
  
  interface rocsolver_dgeql2_batched
    function rocsolver_dgeql2_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_dgeql2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgeql2_batched_full_rank,rocsolver_dgeql2_batched_rank_0,rocsolver_dgeql2_batched_rank_1
  end interface
  
  interface rocsolver_cgeql2_batched
    function rocsolver_cgeql2_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_cgeql2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgeql2_batched_full_rank,rocsolver_cgeql2_batched_rank_0,rocsolver_cgeql2_batched_rank_1
  end interface
  
  interface rocsolver_zgeql2_batched
    function rocsolver_zgeql2_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_zgeql2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgeql2_batched_full_rank,rocsolver_zgeql2_batched_rank_0,rocsolver_zgeql2_batched_rank_1
  end interface
  !> ! \brief GEQL2_STRIDED_BATCHED computes the QL factorization of a batch of
  !>    general m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j =  Q_j  [  0  ]
  !>                      [ L_j ]
  !> 
  !>     where L_j is lower triangular (lower trapezoidal if m < n), and Q_j is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(k)  ...  H_j(2)  H_j(1), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)  v_j(i)'
  !> 
  !>     where the last m-i elements of Householder vector v_j(i) are zero, and
  !>    v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_j to be factored. On exit, the
  !>    elements on and below the (m-n)th subdiagonal (when m >= n) or the (n-m)th
  !>    superdiagonal (when n > m) contain the factor L_j; the elements above the
  !>    subsuperdiagonal are the i - 1 elements of vector v_j(i) for i =
  !>    1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgeql2_strided_batched
    function rocsolver_sgeql2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_sgeql2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgeql2_strided_batched_full_rank,rocsolver_sgeql2_strided_batched_rank_0,rocsolver_sgeql2_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgeql2_strided_batched
    function rocsolver_dgeql2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_dgeql2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgeql2_strided_batched_full_rank,rocsolver_dgeql2_strided_batched_rank_0,rocsolver_dgeql2_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgeql2_strided_batched
    function rocsolver_cgeql2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_cgeql2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgeql2_strided_batched_full_rank,rocsolver_cgeql2_strided_batched_rank_0,rocsolver_cgeql2_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgeql2_strided_batched
    function rocsolver_zgeql2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_zgeql2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgeql2_strided_batched_full_rank,rocsolver_zgeql2_strided_batched_rank_0,rocsolver_zgeql2_strided_batched_rank_1
  end interface
  !> ! \brief GELQ2 computes a LQ factorization of a general m-by-n matrix A.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization has the form
  !> 
  !>         A = [ L 0 ]  Q
  !> 
  !>     where L is lower triangular (lower trapezoidal if m > n), and Q is
  !>     a n-by-n orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q = H(k)  H(k-1)  ...  H(1), with k = min(m,n)
  !> 
  !>     Each Householder matrix H(i), for i = 1,2,...,k, is given by
  !> 
  !>         H(i) = I - ipiv[i-1]  v(i)'  v(i)
  !> 
  !>     where the first i-1 elements of the Householder vector v(i) are zero, and
  !>    v(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on and delow the diagonal contain the
  !>               factor L; the elements above the diagonal are the n - i elements
  !>               of vector v(i) for i = 1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices H(i).
  !> 
  !>     
  interface rocsolver_sgelq2
    function rocsolver_sgelq2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_sgelq2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sgelq2_full_rank,rocsolver_sgelq2_rank_0,rocsolver_sgelq2_rank_1
  end interface
  
  interface rocsolver_dgelq2
    function rocsolver_dgelq2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_dgelq2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dgelq2_full_rank,rocsolver_dgelq2_rank_0,rocsolver_dgelq2_rank_1
  end interface
  
  interface rocsolver_cgelq2
    function rocsolver_cgelq2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_cgelq2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cgelq2_full_rank,rocsolver_cgelq2_rank_0,rocsolver_cgelq2_rank_1
  end interface
  
  interface rocsolver_zgelq2
    function rocsolver_zgelq2_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_zgelq2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zgelq2_full_rank,rocsolver_zgelq2_rank_0,rocsolver_zgelq2_rank_1
  end interface
  !> ! \brief GELQ2_BATCHED computes the LQ factorization of a batch of general
  !>    m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j = [ L_j 0 ]  Q_j
  !> 
  !>     where L_j is lower triangular (lower trapezoidal if m > n), and Q_j is
  !>     a n-by-n orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(k)  H_j(k-1)  ...  H_j(1), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)'  v_j(i)
  !> 
  !>     where the first i-1 elements of Householder vector v_j(i) are zero, and
  !>    v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         Array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_j to be factored.
  !>               On exit, the elements on and below the diagonal contain the
  !>               factor L_j. The elements above the diagonal are the n - i elements
  !>               of vector v_j(i) for i=1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgelq2_batched
    function rocsolver_sgelq2_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_sgelq2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgelq2_batched_full_rank,rocsolver_sgelq2_batched_rank_0,rocsolver_sgelq2_batched_rank_1
  end interface
  
  interface rocsolver_dgelq2_batched
    function rocsolver_dgelq2_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_dgelq2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgelq2_batched_full_rank,rocsolver_dgelq2_batched_rank_0,rocsolver_dgelq2_batched_rank_1
  end interface
  
  interface rocsolver_cgelq2_batched
    function rocsolver_cgelq2_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_cgelq2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgelq2_batched_full_rank,rocsolver_cgelq2_batched_rank_0,rocsolver_cgelq2_batched_rank_1
  end interface
  
  interface rocsolver_zgelq2_batched
    function rocsolver_zgelq2_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_zgelq2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgelq2_batched_full_rank,rocsolver_zgelq2_batched_rank_0,rocsolver_zgelq2_batched_rank_1
  end interface
  !> ! \brief GELQ2_STRIDED_BATCHED computes the LQ factorization of a batch of
  !>    general m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j = [ L_j 0 ]  Q_j
  !> 
  !>     where L_j is lower triangular (lower trapezoidal if m > n), and Q_j is
  !>     a n-by-n orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(k)  H_j(k-1)  ...  H_j(1), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)'  v_j(i)
  !> 
  !>     where the first i-1 elements of vector Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_j to be factored. On exit, the
  !>    elements on and below the diagonal contain the factor L_j. The elements above
  !>    the diagonal are the n - i elements of vector v_j(i) for i =
  !>    1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgelq2_strided_batched
    function rocsolver_sgelq2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_sgelq2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgelq2_strided_batched_full_rank,rocsolver_sgelq2_strided_batched_rank_0,rocsolver_sgelq2_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgelq2_strided_batched
    function rocsolver_dgelq2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_dgelq2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgelq2_strided_batched_full_rank,rocsolver_dgelq2_strided_batched_rank_0,rocsolver_dgelq2_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgelq2_strided_batched
    function rocsolver_cgelq2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_cgelq2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgelq2_strided_batched_full_rank,rocsolver_cgelq2_strided_batched_rank_0,rocsolver_cgelq2_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgelq2_strided_batched
    function rocsolver_zgelq2_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_zgelq2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgelq2_strided_batched_full_rank,rocsolver_zgelq2_strided_batched_rank_0,rocsolver_zgelq2_strided_batched_rank_1
  end interface
  !> ! \brief GEQRF computes a QR factorization of a general m-by-n matrix A.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization has the form
  !> 
  !>         A =  Q  [ R ]
  !>                  [ 0 ]
  !> 
  !>     where R is upper triangular (upper trapezoidal if m < n), and Q is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q = H(1)  H(2)  ...  H(k), with k = min(m,n)
  !> 
  !>     Each Householder matrix H(i), for i = 1,2,...,k, is given by
  !> 
  !>         H(i) = I - ipiv[i-1]  v(i)  v(i)'
  !> 
  !>     where the first i-1 elements of the Householder vector v(i) are zero, and
  !>    v(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on and above the diagonal contain the
  !>               factor R; the elements below the diagonal are the m - i elements
  !>               of vector v(i) for i = 1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices H(i).
  !> 
  !>     
  interface rocsolver_sgeqrf
    function rocsolver_sgeqrf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_sgeqrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sgeqrf_full_rank,rocsolver_sgeqrf_rank_0,rocsolver_sgeqrf_rank_1
  end interface
  
  interface rocsolver_dgeqrf
    function rocsolver_dgeqrf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_dgeqrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dgeqrf_full_rank,rocsolver_dgeqrf_rank_0,rocsolver_dgeqrf_rank_1
  end interface
  
  interface rocsolver_cgeqrf
    function rocsolver_cgeqrf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_cgeqrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cgeqrf_full_rank,rocsolver_cgeqrf_rank_0,rocsolver_cgeqrf_rank_1
  end interface
  
  interface rocsolver_zgeqrf
    function rocsolver_zgeqrf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_zgeqrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zgeqrf_full_rank,rocsolver_zgeqrf_rank_0,rocsolver_zgeqrf_rank_1
  end interface
  !> ! \brief GEQRF_BATCHED computes the QR factorization of a batch of general
  !>    m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j =  Q_j  [ R_j ]
  !>                      [  0  ]
  !> 
  !>     where R_j is upper triangular (upper trapezoidal if m < n), and Q_j is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(1)  H_j(2)  ...  H_j(k), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)  v_j(i)'
  !> 
  !>     where the first i-1 elements of vector Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         Array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_j to be factored.
  !>               On exit, the elements on and above the diagonal contain the
  !>               factor R_j. The elements below the diagonal are the m - i elements
  !>               of vector v_j(i) for i=1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgeqrf_batched
    function rocsolver_sgeqrf_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_sgeqrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgeqrf_batched_full_rank,rocsolver_sgeqrf_batched_rank_0,rocsolver_sgeqrf_batched_rank_1
  end interface
  
  interface rocsolver_dgeqrf_batched
    function rocsolver_dgeqrf_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_dgeqrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgeqrf_batched_full_rank,rocsolver_dgeqrf_batched_rank_0,rocsolver_dgeqrf_batched_rank_1
  end interface
  
  interface rocsolver_cgeqrf_batched
    function rocsolver_cgeqrf_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_cgeqrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgeqrf_batched_full_rank,rocsolver_cgeqrf_batched_rank_0,rocsolver_cgeqrf_batched_rank_1
  end interface
  
  interface rocsolver_zgeqrf_batched
    function rocsolver_zgeqrf_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_zgeqrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgeqrf_batched_full_rank,rocsolver_zgeqrf_batched_rank_0,rocsolver_zgeqrf_batched_rank_1
  end interface
  !> ! \brief GEQRF_STRIDED_BATCHED computes the QR factorization of a batch of
  !>    general m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j =  Q_j  [ R_j ]
  !>                      [  0  ]
  !> 
  !>     where R_j is upper triangular (upper trapezoidal if m < n), and Q_j is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(1)  H_j(2)  ...  H_j(k), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)  v_j(i)'
  !> 
  !>     where the first i-1 elements of vector Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_j to be factored. On exit, the
  !>    elements on and above the diagonal contain the factor R_j. The elements below
  !>    the diagonal are the m - i elements of vector v_j(i) for i =
  !>    1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgeqrf_strided_batched
    function rocsolver_sgeqrf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_sgeqrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgeqrf_strided_batched_full_rank,rocsolver_sgeqrf_strided_batched_rank_0,rocsolver_sgeqrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgeqrf_strided_batched
    function rocsolver_dgeqrf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_dgeqrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgeqrf_strided_batched_full_rank,rocsolver_dgeqrf_strided_batched_rank_0,rocsolver_dgeqrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgeqrf_strided_batched
    function rocsolver_cgeqrf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_cgeqrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgeqrf_strided_batched_full_rank,rocsolver_cgeqrf_strided_batched_rank_0,rocsolver_cgeqrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgeqrf_strided_batched
    function rocsolver_zgeqrf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_zgeqrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgeqrf_strided_batched_full_rank,rocsolver_zgeqrf_strided_batched_rank_0,rocsolver_zgeqrf_strided_batched_rank_1
  end interface
  !> ! \brief GEQLF computes a QL factorization of a general m-by-n matrix A.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization has the form
  !> 
  !>         A =  Q  [ 0 ]
  !>                  [ L ]
  !> 
  !>     where L is lower triangular (lower trapezoidal if m < n), and Q is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q = H(k)  ...  H(2)  H(1), with k = min(m,n)
  !> 
  !>     Each Householder matrix H(i), for i = 1,2,...,k, is given by
  !> 
  !>         H(i) = I - ipiv[i-1]  v(i)  v(i)'
  !> 
  !>     where the last m-i elements of the Householder vector v(i) are zero, and
  !>    v(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on and below the (m-n)th subdiagonal (when
  !>               m >= n) or the (n-m)th superdiagonal (when n > m) contain the
  !>               factor L; the elements above the subsuperdiagonal are the i - 1
  !>               elements of vector v(i) for i = 1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices H(i).
  !> 
  !>     
  interface rocsolver_sgeqlf
    function rocsolver_sgeqlf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_sgeqlf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sgeqlf_full_rank,rocsolver_sgeqlf_rank_0,rocsolver_sgeqlf_rank_1
  end interface
  
  interface rocsolver_dgeqlf
    function rocsolver_dgeqlf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_dgeqlf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dgeqlf_full_rank,rocsolver_dgeqlf_rank_0,rocsolver_dgeqlf_rank_1
  end interface
  
  interface rocsolver_cgeqlf
    function rocsolver_cgeqlf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_cgeqlf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cgeqlf_full_rank,rocsolver_cgeqlf_rank_0,rocsolver_cgeqlf_rank_1
  end interface
  
  interface rocsolver_zgeqlf
    function rocsolver_zgeqlf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_zgeqlf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zgeqlf_full_rank,rocsolver_zgeqlf_rank_0,rocsolver_zgeqlf_rank_1
  end interface
  !> ! \brief GEQLF_BATCHED computes the QL factorization of a batch of general
  !>    m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j =  Q_j  [  0  ]
  !>                      [ L_j ]
  !> 
  !>     where L_j is lower triangular (lower trapezoidal if m < n), and Q_j is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(k)  ...  H_j(2)  H_j(1), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)  v_j(i)'
  !> 
  !>     where the last m-i elements of vector Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         Array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_j to be factored.
  !>               On exit, the elements on and below the (m-n)th subdiagonal (when
  !>               m >= n) or the (n-m)th superdiagonal (when n > m) contain the
  !>               factor L_j; the elements above the subsuperdiagonal are the i - 1
  !>               elements of vector v_j(i) for i = 1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgeqlf_batched
    function rocsolver_sgeqlf_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_sgeqlf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgeqlf_batched_full_rank,rocsolver_sgeqlf_batched_rank_0,rocsolver_sgeqlf_batched_rank_1
  end interface
  
  interface rocsolver_dgeqlf_batched
    function rocsolver_dgeqlf_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_dgeqlf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgeqlf_batched_full_rank,rocsolver_dgeqlf_batched_rank_0,rocsolver_dgeqlf_batched_rank_1
  end interface
  
  interface rocsolver_cgeqlf_batched
    function rocsolver_cgeqlf_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_cgeqlf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgeqlf_batched_full_rank,rocsolver_cgeqlf_batched_rank_0,rocsolver_cgeqlf_batched_rank_1
  end interface
  
  interface rocsolver_zgeqlf_batched
    function rocsolver_zgeqlf_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_zgeqlf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgeqlf_batched_full_rank,rocsolver_zgeqlf_batched_rank_0,rocsolver_zgeqlf_batched_rank_1
  end interface
  !> ! \brief GEQLF_STRIDED_BATCHED computes the QL factorization of a batch of
  !>    general m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j =  Q_j  [  0  ]
  !>                      [ L_j ]
  !> 
  !>     where L_j is lower triangular (lower trapezoidal if m < n), and Q_j is
  !>     a m-by-m orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(k)  ...  H_j(2)  H_j(1), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)  v_j(i)'
  !> 
  !>     where the last m-i elements of vector Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_j to be factored. On exit, the
  !>    elements on and below the (m-n)th subdiagonal (when m >= n) or the (n-m)th
  !>    superdiagonal (when n > m) contain the factor L_j; the elements above the
  !>    subsuperdiagonal are the i - 1 elements of vector v_j(i) for i =
  !>    1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgeqlf_strided_batched
    function rocsolver_sgeqlf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_sgeqlf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgeqlf_strided_batched_full_rank,rocsolver_sgeqlf_strided_batched_rank_0,rocsolver_sgeqlf_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgeqlf_strided_batched
    function rocsolver_dgeqlf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_dgeqlf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgeqlf_strided_batched_full_rank,rocsolver_dgeqlf_strided_batched_rank_0,rocsolver_dgeqlf_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgeqlf_strided_batched
    function rocsolver_cgeqlf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_cgeqlf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgeqlf_strided_batched_full_rank,rocsolver_cgeqlf_strided_batched_rank_0,rocsolver_cgeqlf_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgeqlf_strided_batched
    function rocsolver_zgeqlf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_zgeqlf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgeqlf_strided_batched_full_rank,rocsolver_zgeqlf_strided_batched_rank_0,rocsolver_zgeqlf_strided_batched_rank_1
  end interface
  !> ! \brief GELQF computes a LQ factorization of a general m-by-n matrix A.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization has the form
  !> 
  !>         A = [ L 0 ]  Q
  !> 
  !>     where L is lower triangular (lower trapezoidal if m > n), and Q is
  !>     a n-by-n orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q = H(k)  H(k-1)  ...  H(1), with k = min(m,n)
  !> 
  !>     Each Householder matrix H(i), for i = 1,2,...,k, is given by
  !> 
  !>         H(i) = I - ipiv[i-1]  v(i)'  v(i)
  !> 
  !>     where the first i-1 elements of the Householder vector v(i) are zero, and
  !>    v(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on and below the diagonal contain the
  !>               factor L; the elements above the diagonal are the n - i elements
  !>               of vector v(i) for i = 1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of A.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices H(i).
  !> 
  !>     
  interface rocsolver_sgelqf
    function rocsolver_sgelqf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_sgelqf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_sgelqf_full_rank,rocsolver_sgelqf_rank_0,rocsolver_sgelqf_rank_1
  end interface
  
  interface rocsolver_dgelqf
    function rocsolver_dgelqf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_dgelqf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_dgelqf_full_rank,rocsolver_dgelqf_rank_0,rocsolver_dgelqf_rank_1
  end interface
  
  interface rocsolver_cgelqf
    function rocsolver_cgelqf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_cgelqf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_cgelqf_full_rank,rocsolver_cgelqf_rank_0,rocsolver_cgelqf_rank_1
  end interface
  
  interface rocsolver_zgelqf
    function rocsolver_zgelqf_orig(handle,m,n,A,lda,ipiv) bind(c, name="rocsolver_zgelqf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
    end function

    module procedure rocsolver_zgelqf_full_rank,rocsolver_zgelqf_rank_0,rocsolver_zgelqf_rank_1
  end interface
  !> ! \brief GELQF_BATCHED computes the LQ factorization of a batch of general
  !>    m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j = [ L_j 0 ]  Q_j
  !> 
  !>     where L_j is lower triangular (lower trapezoidal if m > n), and Q_j is
  !>     a n-by-n orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(k)  H_j(k-1)  ...  H_j(1), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)'  v_j(i)
  !> 
  !>     where the first i-1 elements of Householder vector v_j(i) are zero, and
  !>    v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         Array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_j to be factored.
  !>               On exit, the elements on and below the diagonal contain the
  !>               factor L_j. The elements above the diagonal are the n - i elements
  !>               of vector v_j(i) for i=1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgelqf_batched
    function rocsolver_sgelqf_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_sgelqf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgelqf_batched_full_rank,rocsolver_sgelqf_batched_rank_0,rocsolver_sgelqf_batched_rank_1
  end interface
  
  interface rocsolver_dgelqf_batched
    function rocsolver_dgelqf_batched_orig(handle,n,A,lda,ipiv,batch_count) bind(c, name="rocsolver_dgelqf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgelqf_batched_full_rank,rocsolver_dgelqf_batched_rank_0,rocsolver_dgelqf_batched_rank_1
  end interface
  
  interface rocsolver_cgelqf_batched
    function rocsolver_cgelqf_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_cgelqf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgelqf_batched_full_rank,rocsolver_cgelqf_batched_rank_0,rocsolver_cgelqf_batched_rank_1
  end interface
  
  interface rocsolver_zgelqf_batched
    function rocsolver_zgelqf_batched_orig(handle,n,A,lda,ipiv,strideP,batch_count) bind(c, name="rocsolver_zgelqf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgelqf_batched_full_rank,rocsolver_zgelqf_batched_rank_0,rocsolver_zgelqf_batched_rank_1
  end interface
  !> ! \brief GELQF_STRIDED_BATCHED computes the LQ factorization of a batch of
  !>    general m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_j in the batch has the form
  !> 
  !>         A_j = [ L_j 0 ]  Q_j
  !> 
  !>     where L_j is lower triangular (lower trapezoidal if m > n), and Q_j is
  !>     a n-by-n orthogonalunitary matrix represented as the product of Householder
  !>    matrices
  !> 
  !>         Q_j = H_j(k)  H_j(k-1)  ...  H_j(1), with k = min(m,n)
  !> 
  !>     Each Householder matrices H_j(i), for j = 1,2,...,batch_count, and i =
  !>    1,2,...,k, is given by
  !> 
  !>         H_j(i) = I - ipiv_j[i-1]  v_j(i)'  v_j(i)
  !> 
  !>     where the first i-1 elements of vector Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_j to be factored. On exit, the
  !>    elements on and below the diagonal contain the factor L_j. The elements above
  !>    the diagonal are the n - i elements of vector v_j(i) for i =
  !>    1,2,...,min(m,n).
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     ipiv      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors ipiv_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgelqf_strided_batched
    function rocsolver_sgelqf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_sgelqf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgelqf_strided_batched_full_rank,rocsolver_sgelqf_strided_batched_rank_0,rocsolver_sgelqf_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgelqf_strided_batched
    function rocsolver_dgelqf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_dgelqf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgelqf_strided_batched_full_rank,rocsolver_dgelqf_strided_batched_rank_0,rocsolver_dgelqf_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgelqf_strided_batched
    function rocsolver_cgelqf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_cgelqf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgelqf_strided_batched_full_rank,rocsolver_cgelqf_strided_batched_rank_0,rocsolver_cgelqf_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgelqf_strided_batched
    function rocsolver_zgelqf_strided_batched_orig(handle,n,A,lda,strideA,ipiv,batch_count) bind(c, name="rocsolver_zgelqf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: ipiv
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgelqf_strided_batched_full_rank,rocsolver_zgelqf_strided_batched_rank_0,rocsolver_zgelqf_strided_batched_rank_1
  end interface
  !> ! \brief GEBD2 computes the bidiagonal form of a general m-by-n matrix A.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The bidiagonal form is given by:
  !> 
  !>         B = Q'  A  P
  !> 
  !>     where B is upper bidiagonal if m >= n and lower bidiagonal if m < n, and Q
  !>    and P are orthogonalunitary matrices represented as the product of
  !>    Householder matrices
  !> 
  !>         Q = H(1)  H(2)  ...   H(n)  and P = G(1)  G(2)  ...  G(n-1), if m
  !>    >= n, or Q = H(1)  H(2)  ...  H(m-1) and P = G(1)  G(2)  ...   G(m), if
  !>    m < n
  !> 
  !>     Each Householder matrix H(i) and G(i) is given by
  !> 
  !>         H(i) = I - tauq[i-1]  v(i)  v(i)', and
  !>         G(i) = I - taup[i-1]  u(i)  u(i)'
  !> 
  !>     If m >= n, the first i-1 elements of the Householder vector v(i) are zero,
  !>    and v(i)[i] = 1; while the first i elements of the Householder vector u(i)
  !>    are zero, and u(i)[i+1] = 1. If m < n, the first i elements of the
  !>    Householder vector v(i) are zero, and v(i)[i+1] = 1; while the first i-1
  !>    elements of the Householder vector u(i) are zero, and u(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on the diagonal and superdiagonal (if m >=
  !>    n), or subdiagonal (if m < n) contain the bidiagonal form B. If m >= n, the
  !>    elements below the diagonal are the m - i elements of vector v(i) for i =
  !>    1,2,...,n, and the elements above the superdiagonal are the n - i - 1
  !>    elements of vector u(i) for i = 1,2,...,n-1. If m < n, the elements below the
  !>    subdiagonal are the m - i - 1 elements of vector v(i) for i = 1,2,...,m-1,
  !>    and the elements above the diagonal are the n - i elements of vector u(i) for
  !>    i = 1,2,...,m.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               specifies the leading dimension of A.
  !>     @param[out]
  !>     D         pointer to real type. Array on the GPU of dimension min(m,n).\n
  !>               The diagonal elements of B.
  !>     @param[out]
  !>     E         pointer to real type. Array on the GPU of dimension min(m,n)-1.\n
  !>               The off-diagonal elements of B.
  !>     @param[out]
  !>     tauq      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices H(i).
  !>     @param[out]
  !>     taup      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices G(i).
  !> 
  !>     
  interface rocsolver_sgebd2
    function rocsolver_sgebd2_orig(handle,n,A,lda,D,E,tauq,taup) bind(c, name="rocsolver_sgebd2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
    end function

    module procedure rocsolver_sgebd2_full_rank,rocsolver_sgebd2_rank_0,rocsolver_sgebd2_rank_1
  end interface
  
  interface rocsolver_dgebd2
    function rocsolver_dgebd2_orig(handle,n,A,lda,D,E,tauq,taup) bind(c, name="rocsolver_dgebd2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
    end function

    module procedure rocsolver_dgebd2_full_rank,rocsolver_dgebd2_rank_0,rocsolver_dgebd2_rank_1
  end interface
  
  interface rocsolver_cgebd2
    function rocsolver_cgebd2_orig(handle,n,A,lda,D,E,tauq,taup) bind(c, name="rocsolver_cgebd2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
    end function

    module procedure rocsolver_cgebd2_full_rank,rocsolver_cgebd2_rank_0,rocsolver_cgebd2_rank_1
  end interface
  
  interface rocsolver_zgebd2
    function rocsolver_zgebd2_orig(handle,n,A,lda,D,E,tauq,taup) bind(c, name="rocsolver_zgebd2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
    end function

    module procedure rocsolver_zgebd2_full_rank,rocsolver_zgebd2_rank_0,rocsolver_zgebd2_rank_1
  end interface
  !> ! \brief GEBD2_BATCHED computes the bidiagonal form of a batch of general
  !>    m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The bidiagonal form is given by:
  !> 
  !>         B_j = Q_j'  A_j  P_j
  !> 
  !>     where B_j is upper bidiagonal if m >= n and lower bidiagonal if m < n, and
  !>    Q_j and P_j are orthogonalunitary matrices represented as the product of
  !>    Householder matrices
  !> 
  !>         Q_j = H_j(1)  H_j(2)  ...   H_j(n)  and P_j = G_j(1)  G_j(2)  ... 
  !>    G_j(n-1), if m >= n, or Q_j = H_j(1)  H_j(2)  ...  H_j(m-1) and P_j =
  !>    G_j(1)  G_j(2)  ...   G_j(m),  if m < n
  !> 
  !>     Each Householder matrix H_j(i) and G_j(i), for j = 1,2,...,batch_count, is
  !>    given by
  !> 
  !>         H_j(i) = I - tauq_j[i-1]  v_j(i)  v_j(i)', and
  !>         G_j(i) = I - taup_j[i-1]  u_j(i)  u_j(i)'
  !> 
  !>     If m >= n, the first i-1 elements of the Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1; while the first i elements of the Householder vector
  !>    u_j(i) are zero, and u_j(i)[i+1] = 1. If m < n, the first i elements of the
  !>    Householder vector v_j(i) are zero, and v_j(i)[i+1] = 1; while the first i-1
  !>    elements of the Householder vector u_j(i) are zero, and u_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         Array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_j to be factored.
  !>               On exit, the elements on the diagonal and superdiagonal (if m >=
  !>    n), or subdiagonal (if m < n) contain the bidiagonal form B_j. If m >= n, the
  !>    elements below the diagonal are the m - i elements of vector v_j(i) for i =
  !>    1,2,...,n, and the elements above the superdiagonal are the n - i - 1
  !>    elements of vector u_j(i) for i = 1,2,...,n-1. If m < n, the elements below
  !>    the subdiagonal are the m - i - 1 elements of vector v_j(i) for i =
  !>    1,2,...,m-1, and the elements above the diagonal are the n - i elements of
  !>    vector u_j(i) for i = 1,2,...,m.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[out]
  !>     D         pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideD).\n The diagonal elements of B_j.
  !>     @param[in]
  !>     strideD   rocblas_stride.\n
  !>               Stride from the start of one vector D_j and the next one D_(j+1).
  !>               There is no restriction for the value of strideD. Normal use case
  !>    is strideD >= min(m,n).
  !>     @param[out]
  !>     E         pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideE).\n The off-diagonal elements of B_j.
  !>     @param[in]
  !>     strideE   rocblas_stride.\n
  !>               Stride from the start of one vector E_j and the next one E_(j+1).
  !>               There is no restriction for the value of strideE. Normal use case
  !>    is strideE >= min(m,n)-1.
  !>     @param[out]
  !>     tauq      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideQ).\n Contains the vectors tauq_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideQ   rocblas_stride.\n
  !>               Stride from the start of one vector tauq_j to the next one
  !>    tauq_(j+1). There is no restriction for the value of strideQ. Normal use is
  !>    strideQ >= min(m,n).
  !>     @param[out]
  !>     taup      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors taup_j of scalar factors of the
  !>               Householder matrices G_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector taup_j to the next one
  !>    taup_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgebd2_batched
    function rocsolver_sgebd2_batched_orig(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_sgebd2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgebd2_batched_full_rank,rocsolver_sgebd2_batched_rank_0,rocsolver_sgebd2_batched_rank_1
  end interface
  
  interface rocsolver_dgebd2_batched
    function rocsolver_dgebd2_batched_orig(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_dgebd2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgebd2_batched_full_rank,rocsolver_dgebd2_batched_rank_0,rocsolver_dgebd2_batched_rank_1
  end interface
  
  interface rocsolver_cgebd2_batched
    function rocsolver_cgebd2_batched_orig(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count) bind(c, name="rocsolver_cgebd2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgebd2_batched_full_rank,rocsolver_cgebd2_batched_rank_0,rocsolver_cgebd2_batched_rank_1
  end interface
  
  interface rocsolver_zgebd2_batched
    function rocsolver_zgebd2_batched_orig(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count) bind(c, name="rocsolver_zgebd2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgebd2_batched_full_rank,rocsolver_zgebd2_batched_rank_0,rocsolver_zgebd2_batched_rank_1
  end interface
  !> ! \brief GEBD2_STRIDED_BATCHED computes the bidiagonal form of a batch of
  !>    general m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The bidiagonal form is given by:
  !> 
  !>         B_j = Q_j'  A_j  P_j
  !> 
  !>     where B_j is upper bidiagonal if m >= n and lower bidiagonal if m < n, and
  !>    Q_j and P_j are orthogonalunitary matrices represented as the product of
  !>    Householder matrices
  !> 
  !>         Q_j = H_j(1)  H_j(2)  ...   H_j(n)  and P_j = G_j(1)  G_j(2)  ... 
  !>    G_j(n-1), if m >= n, or Q_j = H_j(1)  H_j(2)  ...  H_j(m-1) and P_j =
  !>    G_j(1)  G_j(2)  ...   G_j(m),  if m < n
  !> 
  !>     Each Householder matrix H_j(i) and G_j(i), for j = 1,2,...,batch_count, is
  !>    given by
  !> 
  !>         H_j(i) = I - tauq_j[i-1]  v_j(i)  v_j(i)', and
  !>         G_j(i) = I - taup_j[i-1]  u_j(i)  u_j(i)'
  !> 
  !>     If m >= n, the first i-1 elements of the Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1; while the first i elements of the Householder vector
  !>    u_j(i) are zero, and u_j(i)[i+1] = 1. If m < n, the first i elements of the
  !>    Householder vector v_j(i) are zero, and v_j(i)[i+1] = 1; while the first i-1
  !>    elements of the Householder vector u_j(i) are zero, and u_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_j to be factored. On exit, the
  !>    elements on the diagonal and superdiagonal (if m >= n), or subdiagonal (if m
  !>    < n) contain the bidiagonal form B_j. If m >= n, the elements below the
  !>    diagonal are the m - i elements of vector v_j(i) for i = 1,2,...,n, and the
  !>    elements above the superdiagonal are the n - i - 1 elements of vector u_j(i)
  !>    for i = 1,2,...,n-1. If m < n, the elements below the subdiagonal are the m -
  !>    i - 1 elements of vector v_j(i) for i = 1,2,...,m-1, and the elements above
  !>    the diagonal are the n - i elements of vector u_j(i) for i = 1,2,...,m.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     D         pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideD).\n The diagonal elements of B_j.
  !>     @param[in]
  !>     strideD   rocblas_stride.\n
  !>               Stride from the start of one vector D_j and the next one D_(j+1).
  !>               There is no restriction for the value of strideD. Normal use case
  !>    is strideD >= min(m,n).
  !>     @param[out]
  !>     E         pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideE).\n The off-diagonal elements of B_j.
  !>     @param[in]
  !>     strideE   rocblas_stride.\n
  !>               Stride from the start of one vector E_j and the next one E_(j+1).
  !>               There is no restriction for the value of strideE. Normal use case
  !>    is strideE >= min(m,n)-1.
  !>     @param[out]
  !>     tauq      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideQ).\n Contains the vectors tauq_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideQ   rocblas_stride.\n
  !>               Stride from the start of one vector tauq_j to the next one
  !>    tauq_(j+1). There is no restriction for the value of strideQ. Normal use is
  !>    strideQ >= min(m,n).
  !>     @param[out]
  !>     taup      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors taup_j of scalar factors of the
  !>               Householder matrices G_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector taup_j to the next one
  !>    taup_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgebd2_strided_batched
    function rocsolver_sgebd2_strided_batched_orig(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_sgebd2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgebd2_strided_batched_full_rank,rocsolver_sgebd2_strided_batched_rank_0,rocsolver_sgebd2_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgebd2_strided_batched
    function rocsolver_dgebd2_strided_batched_orig(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_dgebd2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgebd2_strided_batched_full_rank,rocsolver_dgebd2_strided_batched_rank_0,rocsolver_dgebd2_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgebd2_strided_batched
    function rocsolver_cgebd2_strided_batched_orig(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_cgebd2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgebd2_strided_batched_full_rank,rocsolver_cgebd2_strided_batched_rank_0,rocsolver_cgebd2_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgebd2_strided_batched
    function rocsolver_zgebd2_strided_batched_orig(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_zgebd2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgebd2_strided_batched_full_rank,rocsolver_zgebd2_strided_batched_rank_0,rocsolver_zgebd2_strided_batched_rank_1
  end interface
  !> ! \brief GEBRD computes the bidiagonal form of a general m-by-n matrix A.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The bidiagonal form is given by:
  !> 
  !>         B = Q'  A  P
  !> 
  !>     where B is upper bidiagonal if m >= n and lower bidiagonal if m < n, and Q
  !>    and P are orthogonalunitary matrices represented as the product of
  !>    Householder matrices
  !> 
  !>         Q = H(1)  H(2)  ...   H(n)  and P = G(1)  G(2)  ...  G(n-1), if m
  !>    >= n, or Q = H(1)  H(2)  ...  H(m-1) and P = G(1)  G(2)  ...   G(m), if
  !>    m < n
  !> 
  !>     Each Householder matrix H(i) and G(i) is given by
  !> 
  !>         H(i) = I - tauq[i-1]  v(i)  v(i)', and
  !>         G(i) = I - taup[i-1]  u(i)  u(i)'
  !> 
  !>     If m >= n, the first i-1 elements of the Householder vector v(i) are zero,
  !>    and v(i)[i] = 1; while the first i elements of the Householder vector u(i)
  !>    are zero, and u(i)[i+1] = 1. If m < n, the first i elements of the
  !>    Householder vector v(i) are zero, and v(i)[i+1] = 1; while the first i-1
  !>    elements of the Householder vector u(i) are zero, and u(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of the matrix A.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the m-by-n matrix to be factored.
  !>               On exit, the elements on the diagonal and superdiagonal (if m >=
  !>    n), or subdiagonal (if m < n) contain the bidiagonal form B. If m >= n, the
  !>    elements below the diagonal are the m - i elements of vector v(i) for i =
  !>    1,2,...,n, and the elements above the superdiagonal are the n - i - 1
  !>    elements of vector u(i) for i = 1,2,...,n-1. If m < n, the elements below the
  !>    subdiagonal are the m - i - 1 elements of vector v(i) for i = 1,2,...,m-1,
  !>    and the elements above the diagonal are the n - i elements of vector u(i) for
  !>    i = 1,2,...,m.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               specifies the leading dimension of A.
  !>     @param[out]
  !>     D         pointer to real type. Array on the GPU of dimension min(m,n).\n
  !>               The diagonal elements of B.
  !>     @param[out]
  !>     E         pointer to real type. Array on the GPU of dimension min(m,n)-1.\n
  !>               The off-diagonal elements of B.
  !>     @param[out]
  !>     tauq      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices H(i).
  !>     @param[out]
  !>     taup      pointer to type. Array on the GPU of dimension min(m,n).\n
  !>               The scalar factors of the Householder matrices G(i).
  !> 
  !>     
  interface rocsolver_sgebrd
    function rocsolver_sgebrd_orig(handle,n,A,lda,D,E,tauq,taup) bind(c, name="rocsolver_sgebrd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
    end function

    module procedure rocsolver_sgebrd_full_rank,rocsolver_sgebrd_rank_0,rocsolver_sgebrd_rank_1
  end interface
  
  interface rocsolver_dgebrd
    function rocsolver_dgebrd_orig(handle,n,A,lda,D,E,tauq,taup) bind(c, name="rocsolver_dgebrd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
    end function

    module procedure rocsolver_dgebrd_full_rank,rocsolver_dgebrd_rank_0,rocsolver_dgebrd_rank_1
  end interface
  
  interface rocsolver_cgebrd
    function rocsolver_cgebrd_orig(handle,n,A,lda,D,E,tauq,taup) bind(c, name="rocsolver_cgebrd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
    end function

    module procedure rocsolver_cgebrd_full_rank,rocsolver_cgebrd_rank_0,rocsolver_cgebrd_rank_1
  end interface
  
  interface rocsolver_zgebrd
    function rocsolver_zgebrd_orig(handle,n,A,lda,D,E,tauq,taup) bind(c, name="rocsolver_zgebrd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      type(c_ptr),value :: E
      type(c_ptr),value :: tauq
      type(c_ptr),value :: taup
    end function

    module procedure rocsolver_zgebrd_full_rank,rocsolver_zgebrd_rank_0,rocsolver_zgebrd_rank_1
  end interface
  !> ! \brief GEBRD_BATCHED computes the bidiagonal form of a batch of general
  !>    m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The bidiagonal form is given by:
  !> 
  !>         B_j = Q_j'  A_j  P_j
  !> 
  !>     where B_j is upper bidiagonal if m >= n and lower bidiagonal if m < n, and
  !>    Q_j and P_j are orthogonalunitary matrices represented as the product of
  !>    Householder matrices
  !> 
  !>         Q_j = H_j(1)  H_j(2)  ...   H_j(n)  and P_j = G_j(1)  G_j(2)  ... 
  !>    G_j(n-1), if m >= n, or Q_j = H_j(1)  H_j(2)  ...  H_j(m-1) and P_j =
  !>    G_j(1)  G_j(2)  ...   G_j(m),  if m < n
  !> 
  !>     Each Householder matrix H_j(i) and G_j(i), for j = 1,2,...,batch_count, is
  !>    given by
  !> 
  !>         H_j(i) = I - tauq_j[i-1]  v_j(i)  v_j(i)', and
  !>         G_j(i) = I - taup_j[i-1]  u_j(i)  u_j(i)'
  !> 
  !>     If m >= n, the first i-1 elements of the Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1; while the first i elements of the Householder vector
  !>    u_j(i) are zero, and u_j(i)[i+1] = 1. If m < n, the first i elements of the
  !>    Householder vector v_j(i) are zero, and v_j(i)[i+1] = 1; while the first i-1
  !>    elements of the Householder vector u_j(i) are zero, and u_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         Array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the m-by-n matrices A_j to be factored.
  !>               On exit, the elements on the diagonal and superdiagonal (if m >=
  !>    n), or subdiagonal (if m < n) contain the bidiagonal form B_j. If m >= n, the
  !>    elements below the diagonal are the m - i elements of vector v_j(i) for i =
  !>    1,2,...,n, and the elements above the superdiagonal are the n - i - 1
  !>    elements of vector u_j(i) for i = 1,2,...,n-1. If m < n, the elements below
  !>    the subdiagonal are the m - i - 1 elements of vector v_j(i) for i =
  !>    1,2,...,m-1, and the elements above the diagonal are the n - i elements of
  !>    vector u_j(i) for i = 1,2,...,m.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[out]
  !>     D         pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideD).\n The diagonal elements of B_j.
  !>     @param[in]
  !>     strideD   rocblas_stride.\n
  !>               Stride from the start of one vector D_j and the next one D_(j+1).
  !>               There is no restriction for the value of strideD. Normal use case
  !>    is strideD >= min(m,n).
  !>     @param[out]
  !>     E         pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideE).\n The off-diagonal elements of B_j.
  !>     @param[in]
  !>     strideE   rocblas_stride.\n
  !>               Stride from the start of one vector E_j and the next one E_(j+1).
  !>               There is no restriction for the value of strideE. Normal use case
  !>    is strideE >= min(m,n)-1.
  !>     @param[out]
  !>     tauq      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideQ).\n Contains the vectors tauq_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideQ   rocblas_stride.\n
  !>               Stride from the start of one vector tauq_j to the next one
  !>    tauq_(j+1). There is no restriction for the value of strideQ. Normal use is
  !>    strideQ >= min(m,n).
  !>     @param[out]
  !>     taup      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors taup_j of scalar factors of the
  !>               Householder matrices G_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector taup_j to the next one
  !>    taup_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgebrd_batched
    function rocsolver_sgebrd_batched_orig(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_sgebrd_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgebrd_batched_full_rank,rocsolver_sgebrd_batched_rank_0,rocsolver_sgebrd_batched_rank_1
  end interface
  
  interface rocsolver_dgebrd_batched
    function rocsolver_dgebrd_batched_orig(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_dgebrd_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgebrd_batched_full_rank,rocsolver_dgebrd_batched_rank_0,rocsolver_dgebrd_batched_rank_1
  end interface
  
  interface rocsolver_cgebrd_batched
    function rocsolver_cgebrd_batched_orig(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count) bind(c, name="rocsolver_cgebrd_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgebrd_batched_full_rank,rocsolver_cgebrd_batched_rank_0,rocsolver_cgebrd_batched_rank_1
  end interface
  
  interface rocsolver_zgebrd_batched
    function rocsolver_zgebrd_batched_orig(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count) bind(c, name="rocsolver_zgebrd_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgebrd_batched_full_rank,rocsolver_zgebrd_batched_rank_0,rocsolver_zgebrd_batched_rank_1
  end interface
  !> ! \brief GEBRD_STRIDED_BATCHED computes the bidiagonal form of a batch of
  !>    general m-by-n matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The bidiagonal form is given by:
  !> 
  !>         B_j = Q_j'  A_j  P_j
  !> 
  !>     where B_j is upper bidiagonal if m >= n and lower bidiagonal if m < n, and
  !>    Q_j and P_j are orthogonalunitary matrices represented as the product of
  !>    Householder matrices
  !> 
  !>         Q_j = H_j(1)  H_j(2)  ...   H_j(n)  and P_j = G_j(1)  G_j(2)  ... 
  !>    G_j(n-1), if m >= n, or Q_j = H_j(1)  H_j(2)  ...  H_j(m-1) and P_j =
  !>    G_j(1)  G_j(2)  ...   G_j(m),  if m < n
  !> 
  !>     Each Householder matrix H_j(i) and G_j(i), for j = 1,2,...,batch_count, is
  !>    given by
  !> 
  !>         H_j(i) = I - tauq_j[i-1]  v_j(i)  v_j(i)', and
  !>         G_j(i) = I - taup_j[i-1]  u_j(i)  u_j(i)'
  !> 
  !>     If m >= n, the first i-1 elements of the Householder vector v_j(i) are zero,
  !>    and v_j(i)[i] = 1; while the first i elements of the Householder vector
  !>    u_j(i) are zero, and u_j(i)[i+1] = 1. If m < n, the first i elements of the
  !>    Householder vector v_j(i) are zero, and v_j(i)[i+1] = 1; while the first i-1
  !>    elements of the Householder vector u_j(i) are zero, and u_j(i)[i] = 1.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     m         rocblas_int. m >= 0.\n
  !>               The number of rows of all the matrices A_j in the batch.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of columns of all the matrices A_j in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the m-by-n matrices A_j to be factored. On exit, the
  !>    elements on the diagonal and superdiagonal (if m >= n), or subdiagonal (if m
  !>    < n) contain the bidiagonal form B_j. If m >= n, the elements below the
  !>    diagonal are the m - i elements of vector v_j(i) for i = 1,2,...,n, and the
  !>    elements above the superdiagonal are the n - i - 1 elements of vector u_j(i)
  !>    for i = 1,2,...,n-1. If m < n, the elements below the subdiagonal are the m -
  !>    i - 1 elements of vector v_j(i) for i = 1,2,...,m-1, and the elements above
  !>    the diagonal are the n - i elements of vector u_j(i) for i = 1,2,...,m.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= m.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     D         pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideD).\n The diagonal elements of B_j.
  !>     @param[in]
  !>     strideD   rocblas_stride.\n
  !>               Stride from the start of one vector D_j and the next one D_(j+1).
  !>               There is no restriction for the value of strideD. Normal use case
  !>    is strideD >= min(m,n).
  !>     @param[out]
  !>     E         pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideE).\n The off-diagonal elements of B_j.
  !>     @param[in]
  !>     strideE   rocblas_stride.\n
  !>               Stride from the start of one vector E_j and the next one E_(j+1).
  !>               There is no restriction for the value of strideE. Normal use case
  !>    is strideE >= min(m,n)-1.
  !>     @param[out]
  !>     tauq      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideQ).\n Contains the vectors tauq_j of scalar factors of the
  !>               Householder matrices H_j(i).
  !>     @param[in]
  !>     strideQ   rocblas_stride.\n
  !>               Stride from the start of one vector tauq_j to the next one
  !>    tauq_(j+1). There is no restriction for the value of strideQ. Normal use is
  !>    strideQ >= min(m,n).
  !>     @param[out]
  !>     taup      pointer to type. Array on the GPU (the size depends on the value
  !>    of strideP).\n Contains the vectors taup_j of scalar factors of the
  !>               Householder matrices G_j(i).
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector taup_j to the next one
  !>    taup_(j+1). There is no restriction for the value of strideP. Normal use is
  !>    strideP >= min(m,n).
  !>     @param[in]
  !>     batch_count  rocblas_int. batch_count >= 0.\n
  !>                  Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgebrd_strided_batched
    function rocsolver_sgebrd_strided_batched_orig(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_sgebrd_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgebrd_strided_batched_full_rank,rocsolver_sgebrd_strided_batched_rank_0,rocsolver_sgebrd_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgebrd_strided_batched
    function rocsolver_dgebrd_strided_batched_orig(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_dgebrd_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgebrd_strided_batched_full_rank,rocsolver_dgebrd_strided_batched_rank_0,rocsolver_dgebrd_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgebrd_strided_batched
    function rocsolver_cgebrd_strided_batched_orig(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_cgebrd_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgebrd_strided_batched_full_rank,rocsolver_cgebrd_strided_batched_rank_0,rocsolver_cgebrd_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgebrd_strided_batched
    function rocsolver_zgebrd_strided_batched_orig(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count) bind(c, name="rocsolver_zgebrd_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: D
      integer(c_int64_t),value :: strideD
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: tauq
      integer(c_int64_t),value :: strideQ
      type(c_ptr),value :: taup
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgebrd_strided_batched_full_rank,rocsolver_zgebrd_strided_batched_rank_0,rocsolver_zgebrd_strided_batched_rank_1
  end interface
  !> ! \brief GETRS solves a system of n linear equations on n variables using the
  !>    LU factorization computed by GETRF.
  !> 
  !>     \details
  !>     It solves one of the following systems:
  !> 
  !>         A   X = B (no transpose),
  !>         A'  X = B (transpose),  or
  !>         A  X = B (conjugate transpose)
  !> 
  !>     depending on the value of trans.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     trans       rocblas_operation.\n
  !>                 Specifies the form of the system of equations.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The order of the system, i.e. the number of columns and rows of
  !>    A.
  !>     @param[in]
  !>     nrhs        rocblas_int. nrhs >= 0.\n
  !>                 The number of right hand sides, i.e., the number of columns
  !>                 of the matrix B.
  !>     @param[in]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 The factors L and U of the factorization A = PLU returned by
  !>    GETRF.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= n.\n
  !>                 The leading dimension of A.
  !>     @param[in]
  !>     ipiv        pointer to rocblas_int. Array on the GPU of dimension n.\n
  !>                 The pivot indices returned by GETRF.
  !>     @param[in,out]
  !>     B           pointer to type. Array on the GPU of dimension ldbnrhs.\n
  !>                 On entry, the right hand side matrix B.
  !>                 On exit, the solution matrix X.
  !>     @param[in]
  !>     ldb         rocblas_int. ldb >= n.\n
  !>                 The leading dimension of B.
  !> 
  !>    
  interface rocsolver_sgetrs
    function rocsolver_sgetrs_orig(handle,n,lda,ldb) bind(c, name="rocsolver_sgetrs")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrs_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),value :: ldb
    end function


  end interface
  
  interface rocsolver_dgetrs
    function rocsolver_dgetrs_orig(handle,n,lda,ldb) bind(c, name="rocsolver_dgetrs")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrs_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),value :: ldb
    end function


  end interface
  
  interface rocsolver_cgetrs
    function rocsolver_cgetrs_orig(handle,n,lda,ldb) bind(c, name="rocsolver_cgetrs")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),value :: ldb
    end function


  end interface
  
  interface rocsolver_zgetrs
    function rocsolver_zgetrs_orig(handle,n,lda,ldb) bind(c, name="rocsolver_zgetrs")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),value :: ldb
    end function


  end interface
  !> ! \brief GETRS_BATCHED solves a batch of systems of n linear equations on n
  !>    variables using the LU factorization computed by GETRF_BATCHED.
  !> 
  !>     \details
  !>     For each instance j in the batch, it solves one of the following systems:
  !> 
  !>         A_j   X_j = B_j (no transpose),
  !>         A_j'  X_j = B_j (transpose),  or
  !>         A_j  X_j = B_j (conjugate transpose)
  !> 
  !>     depending on the value of trans.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     trans       rocblas_operation.\n
  !>                 Specifies the form of the system of equations of each instance
  !>    in the batch.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The order of the system, i.e. the number of columns and rows of
  !>    all A_j matrices.
  !>     @param[in]
  !>     nrhs        rocblas_int. nrhs >= 0.\n
  !>                 The number of right hand sides, i.e., the number of columns
  !>                 of all the matrices B_j.
  !>     @param[in]
  !>     A           Array of pointers to type. Each pointer points to an array on
  !>    the GPU of dimension ldan.\n The factors L_j and U_j of the factorization
  !>    A_j = P_jL_jU_j returned by GETRF_BATCHED.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= n.\n
  !>                 The leading dimension of matrices A_j.
  !>     @param[in]
  !>     ipiv        pointer to rocblas_int. Array on the GPU (the size depends on
  !>    the value of strideP).\n Contains the vectors ipiv_j of pivot indices
  !>    returned by GETRF_BATCHED.
  !>     @param[in]
  !>     strideP     rocblas_stride.\n
  !>                 Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use case
  !>    is strideP >= min(m,n).
  !>     @param[in,out]
  !>     B           Array of pointers to type. Each pointer points to an array on
  !>    the GPU of dimension ldbnrhs.\n On entry, the right hand side matrices B_j.
  !>                 On exit, the solution matrix X_j of each system in the batch.
  !>     @param[in]
  !>     ldb         rocblas_int. ldb >= n.\n
  !>                 The leading dimension of matrices B_j.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of instances (systems) in the batch.
  !> 
  !>    
  interface rocsolver_sgetrs_batched
    function rocsolver_sgetrs_batched_orig(handle,n,lda,ipiv,strideP,B,batch_count) bind(c, name="rocsolver_sgetrs_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrs_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      type(c_ptr) :: B
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetrs_batched_full_rank,rocsolver_sgetrs_batched_rank_0,rocsolver_sgetrs_batched_rank_1
  end interface
  
  interface rocsolver_dgetrs_batched
    function rocsolver_dgetrs_batched_orig(handle,n,lda,ipiv,strideP,B,batch_count) bind(c, name="rocsolver_dgetrs_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrs_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      type(c_ptr) :: B
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetrs_batched_full_rank,rocsolver_dgetrs_batched_rank_0,rocsolver_dgetrs_batched_rank_1
  end interface
  
  interface rocsolver_cgetrs_batched
    function rocsolver_cgetrs_batched_orig(handle,n,nrhs,A,ipiv,strideP,B,batch_count) bind(c, name="rocsolver_cgetrs_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nrhs
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      type(c_ptr) :: B
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetrs_batched_full_rank,rocsolver_cgetrs_batched_rank_0,rocsolver_cgetrs_batched_rank_1
  end interface
  
  interface rocsolver_zgetrs_batched
    function rocsolver_zgetrs_batched_orig(handle,n,nrhs,A,ipiv,strideP,B,batch_count) bind(c, name="rocsolver_zgetrs_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nrhs
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      type(c_ptr) :: B
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetrs_batched_full_rank,rocsolver_zgetrs_batched_rank_0,rocsolver_zgetrs_batched_rank_1
  end interface
  !> ! \brief GETRS_STRIDED_BATCHED solves a batch of systems of n linear equations
  !>    on n variables using the LU factorization computed by GETRF_STRIDED_BATCHED.
  !> 
  !>     \details
  !>     For each instance j in the batch, it solves one of the following systems:
  !> 
  !>         A_j   X_j = B_j (no transpose),
  !>         A_j'  X_j = B_j (transpose),  or
  !>         A_j  X_j = B_j (conjugate transpose)
  !> 
  !>     depending on the value of trans.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     trans       rocblas_operation.\n
  !>                 Specifies the form of the system of equations of each instance
  !>    in the batch.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The order of the system, i.e. the number of columns and rows of
  !>    all A_j matrices.
  !>     @param[in]
  !>     nrhs        rocblas_int. nrhs >= 0.\n
  !>                 The number of right hand sides, i.e., the number of columns
  !>                 of all the matrices B_j.
  !>     @param[in]
  !>     A           pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n The factors L_j and U_j of the factorization A_j = P_jL_jU_j
  !>    returned by GETRF_STRIDED_BATCHED.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= n.\n
  !>                 The leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA     rocblas_stride.\n
  !>                 Stride from the start of one matrix A_j and the next one
  !>    A_(j+1). There is no restriction for the value of strideA. Normal use case is
  !>    strideA >= ldan.
  !>     @param[in]
  !>     ipiv        pointer to rocblas_int. Array on the GPU (the size depends on
  !>    the value of strideP).\n Contains the vectors ipiv_j of pivot indices
  !>    returned by GETRF_STRIDED_BATCHED.
  !>     @param[in]
  !>     strideP     rocblas_stride.\n
  !>                 Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use case
  !>    is strideP >= min(m,n).
  !>     @param[in,out]
  !>     B           pointer to type. Array on the GPU (size depends on the value of
  !>    strideB).\n On entry, the right hand side matrices B_j. On exit, the solution
  !>    matrix X_j of each system in the batch.
  !>     @param[in]
  !>     ldb         rocblas_int. ldb >= n.\n
  !>                 The leading dimension of matrices B_j.
  !>     @param[in]
  !>     strideB     rocblas_stride.\n
  !>                 Stride from the start of one matrix B_j and the next one
  !>    B_(j+1). There is no restriction for the value of strideB. Normal use case is
  !>    strideB >= ldbnrhs.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of instances (systems) in the batch.
  !> 
  !>    
  interface rocsolver_sgetrs_strided_batched
    function rocsolver_sgetrs_strided_batched_orig(handle,n,lda,ipiv,ldb,batch_count) bind(c, name="rocsolver_sgetrs_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrs_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: ldb
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetrs_strided_batched_rank_0,rocsolver_sgetrs_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgetrs_strided_batched
    function rocsolver_dgetrs_strided_batched_orig(handle,n,lda,ipiv,ldb,batch_count) bind(c, name="rocsolver_dgetrs_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrs_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int),value :: ldb
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetrs_strided_batched_rank_0,rocsolver_dgetrs_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgetrs_strided_batched
    function rocsolver_cgetrs_strided_batched_orig(handle,n,lda,ipiv,strideP,B,ldb,strideB,batch_count) bind(c, name="rocsolver_cgetrs_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      type(c_ptr),value :: B
      integer(c_int),value :: ldb
      integer(c_int64_t),value :: strideB
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetrs_strided_batched_full_rank,rocsolver_cgetrs_strided_batched_rank_0,rocsolver_cgetrs_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgetrs_strided_batched
    function rocsolver_zgetrs_strided_batched_orig(handle,n,lda,ipiv,strideP,B,ldb,strideB,batch_count) bind(c, name="rocsolver_zgetrs_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      type(c_ptr),value :: B
      integer(c_int),value :: ldb
      integer(c_int64_t),value :: strideB
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetrs_strided_batched_full_rank,rocsolver_zgetrs_strided_batched_rank_0,rocsolver_zgetrs_strided_batched_rank_1
  end interface
  !> ! \brief GETRI inverts a general n-by-n matrix A using the LU factorization
  !>     computed by GETRF.
  !> 
  !>     \details
  !>     The inverse is computed by solving the linear system
  !> 
  !>         inv(A)  L = inv(U)
  !> 
  !>     where L is the lower triangular factor of A with unit diagonal elements, and
  !>    U is the upper triangular factor.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of rows and columns of the matrix A.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the factors L and U of the factorization A = PLU
  !>    returned by GETRF. On exit, the inverse of A if info = 0; otherwise
  !>    undefined.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               Specifies the leading dimension of A.
  !>     @param[in]
  !>     ipiv      pointer to rocblas_int. Array on the GPU of dimension n.\n
  !>               The pivot indices returned by GETRF.
  !>     @param[out]
  !>     info      pointer to a rocblas_int on the GPU.\n
  !>               If info = 0, successful exit.
  !>               If info = i > 0, U is singular. U(i,i) is the first zero pivot.
  !> 
  !>     
  interface rocsolver_sgetri
    function rocsolver_sgetri_orig(handle,n,A,lda,ipiv,myInfo) bind(c, name="rocsolver_sgetri")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_sgetri_full_rank,rocsolver_sgetri_rank_0,rocsolver_sgetri_rank_1
  end interface
  
  interface rocsolver_dgetri
    function rocsolver_dgetri_orig(handle,n,A,lda,ipiv,myInfo) bind(c, name="rocsolver_dgetri")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dgetri_full_rank,rocsolver_dgetri_rank_0,rocsolver_dgetri_rank_1
  end interface
  
  interface rocsolver_cgetri
    function rocsolver_cgetri_orig(handle,n,A,myInfo) bind(c, name="rocsolver_cgetri")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cgetri_full_rank,rocsolver_cgetri_rank_0,rocsolver_cgetri_rank_1
  end interface
  
  interface rocsolver_zgetri
    function rocsolver_zgetri_orig(handle,n,A,myInfo) bind(c, name="rocsolver_zgetri")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zgetri_full_rank,rocsolver_zgetri_rank_0,rocsolver_zgetri_rank_1
  end interface
  !> ! \brief GETRI_BATCHED inverts a batch of general n-by-n matrices using
  !>     the LU factorization computed by GETRF_BATCHED.
  !> 
  !>     \details
  !>     The inverse is computed by solving the linear system
  !> 
  !>         inv(A_j)  L_j = inv(U_j)
  !> 
  !>     where L_j is the lower triangular factor of A_j with unit diagonal elements,
  !>    and U_j is the upper triangular factor.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of rows and columns of all matrices A_j in the batch.
  !>     @param[inout]
  !>     A         array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the factors L_j and U_j of the
  !>    factorization A = P_jL_jU_j returned by GETRF_BATCHED. On exit, the
  !>    inverses of A_j if info_j = 0; otherwise undefined.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     ipiv      pointer to rocblas_int. Array on the GPU (the size depends on the
  !>    value of strideP).\n The pivot indices returned by GETRF_BATCHED.
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(i+j). There is no restriction for the value of strideP. Normal use case
  !>    is strideP >= n.
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_j = 0, successful exit for inversion of A_j. If info_j = i >
  !>    0, U_j is singular. U_j(i,i) is the first zero pivot.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetri_batched
    function rocsolver_sgetri_batched_orig(handle,n,A,ipiv,strideP,batch_count) bind(c, name="rocsolver_sgetri_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetri_batched_full_rank,rocsolver_sgetri_batched_rank_0,rocsolver_sgetri_batched_rank_1
  end interface
  
  interface rocsolver_dgetri_batched
    function rocsolver_dgetri_batched_orig(handle,n,A,ipiv,strideP,batch_count) bind(c, name="rocsolver_dgetri_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetri_batched_full_rank,rocsolver_dgetri_batched_rank_0,rocsolver_dgetri_batched_rank_1
  end interface
  
  interface rocsolver_cgetri_batched
    function rocsolver_cgetri_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_cgetri_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetri_batched_full_rank,rocsolver_cgetri_batched_rank_0,rocsolver_cgetri_batched_rank_1
  end interface
  
  interface rocsolver_zgetri_batched
    function rocsolver_zgetri_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_zgetri_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetri_batched_full_rank,rocsolver_zgetri_batched_rank_0,rocsolver_zgetri_batched_rank_1
  end interface
  !> ! \brief GETRI_STRIDED_BATCHED inverts a batch of general n-by-n matrices
  !>    using the LU factorization computed by GETRF_STRIDED_BATCHED.
  !> 
  !>     \details
  !>     The inverse is computed by solving the linear system
  !> 
  !>         inv(A_j)  L_j = inv(U_j)
  !> 
  !>     where L_j is the lower triangular factor of A_j with unit diagonal elements,
  !>    and U_j is the upper triangular factor.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The number of rows and columns of all matrices A_i in the batch.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the factors L_j and U_j of the factorization A_j =
  !>    P_jL_jU_j returned by GETRF_STRIDED_BATCHED. On exit, the inverses of A_j
  !>    if info_j = 0; otherwise undefined.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               Specifies the leading dimension of matrices A_j.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_j and the next one A_(j+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan
  !>     @param[in]
  !>     ipiv      pointer to rocblas_int. Array on the GPU (the size depends on the
  !>    value of strideP).\n The pivot indices returned by GETRF_STRIDED_BATCHED.
  !>     @param[in]
  !>     strideP   rocblas_stride.\n
  !>               Stride from the start of one vector ipiv_j to the next one
  !>    ipiv_(j+1). There is no restriction for the value of strideP. Normal use case
  !>    is strideP >= n.
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_j = 0, successful exit for inversion of A_j. If info_j = i >
  !>    0, U_j is singular. U_j(i,i) is the first zero pivot.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgetri_strided_batched
    function rocsolver_sgetri_strided_batched_orig(handle,lda,ipiv,myInfo,batch_count) bind(c, name="rocsolver_sgetri_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: lda
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgetri_strided_batched_rank_0,rocsolver_sgetri_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgetri_strided_batched
    function rocsolver_dgetri_strided_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_dgetri_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgetri_strided_batched_full_rank,rocsolver_dgetri_strided_batched_rank_0,rocsolver_dgetri_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgetri_strided_batched
    function rocsolver_cgetri_strided_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_cgetri_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgetri_strided_batched_full_rank,rocsolver_cgetri_strided_batched_rank_0,rocsolver_cgetri_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgetri_strided_batched
    function rocsolver_zgetri_strided_batched_orig(handle,n,A,ipiv,myInfo,batch_count) bind(c, name="rocsolver_zgetri_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgetri_strided_batched_full_rank,rocsolver_zgetri_strided_batched_rank_0,rocsolver_zgetri_strided_batched_rank_1
  end interface
  !> ! \brief POTF2 computes the Cholesky factorization of a real symmetriccomplex
  !>     Hermitian positive definite matrix A.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization has the form:
  !> 
  !>         A = U'  U, or
  !>         A = L   L'
  !> 
  !>     depending on the value of uplo. U is an upper triangular matrix and L is
  !>    lower triangular.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     uplo      rocblas_fill.\n
  !>               Specifies whether the factorization is upper or lower triangular.
  !>               If uplo indicates lower (or upper), then the upper (or lower) part
  !>    of A is not used.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The matrix dimensions.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the matrix A to be factored. On exit, the lower or upper
  !>    triangular factor.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               specifies the leading dimension of A.
  !>     @param[out]
  !>     info      pointer to a rocblas_int on the GPU.\n
  !>               If info = 0, successful factorization of matrix A.
  !>               If info = i > 0, the leading minor of order i of A is not positive
  !>    definite. The factorization stopped at this point.
  !> 
  !>     
  interface rocsolver_spotf2
    function rocsolver_spotf2_orig(handle,uplo,n,A,lda,myInfo) bind(c, name="rocsolver_spotf2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_spotf2_full_rank,rocsolver_spotf2_rank_0,rocsolver_spotf2_rank_1
  end interface
  
  interface rocsolver_dpotf2
    function rocsolver_dpotf2_orig(handle,uplo,n,A,lda,myInfo) bind(c, name="rocsolver_dpotf2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dpotf2_full_rank,rocsolver_dpotf2_rank_0,rocsolver_dpotf2_rank_1
  end interface
  
  interface rocsolver_cpotf2
    function rocsolver_cpotf2_orig(handle,n,A,myInfo) bind(c, name="rocsolver_cpotf2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cpotf2_full_rank,rocsolver_cpotf2_rank_0,rocsolver_cpotf2_rank_1
  end interface
  
  interface rocsolver_zpotf2
    function rocsolver_zpotf2_orig(handle,n,A,myInfo) bind(c, name="rocsolver_zpotf2")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zpotf2_full_rank,rocsolver_zpotf2_rank_0,rocsolver_zpotf2_rank_1
  end interface
  !> ! \brief POTF2_BATCHED computes the Cholesky factorization of a
  !>     batch of real symmetriccomplex Hermitian positive definite matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_i in the batch has the form:
  !> 
  !>         A_i = U_i'  U_i, or
  !>         A_i = L_i   L_i'
  !> 
  !>     depending on the value of uplo. U_i is an upper triangular matrix and L_i is
  !>    lower triangular.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     uplo      rocblas_fill.\n
  !>               Specifies whether the factorization is upper or lower triangular.
  !>               If uplo indicates lower (or upper), then the upper (or lower) part
  !>    of A is not used.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The dimension of matrix A_i.
  !>     @param[inout]
  !>     A         array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the matrices A_i to be factored. On exit,
  !>    the upper or lower triangular factors.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               specifies the leading dimension of A_i.
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful factorization of matrix A_i. If info_i = j >
  !>    0, the leading minor of order j of A_i is not positive definite. The i-th
  !>    factorization stopped at this point.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_spotf2_batched
    function rocsolver_spotf2_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_spotf2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_spotf2_batched_full_rank,rocsolver_spotf2_batched_rank_0,rocsolver_spotf2_batched_rank_1
  end interface
  
  interface rocsolver_dpotf2_batched
    function rocsolver_dpotf2_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_dpotf2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dpotf2_batched_full_rank,rocsolver_dpotf2_batched_rank_0,rocsolver_dpotf2_batched_rank_1
  end interface
  
  interface rocsolver_cpotf2_batched
    function rocsolver_cpotf2_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_cpotf2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cpotf2_batched_full_rank,rocsolver_cpotf2_batched_rank_0,rocsolver_cpotf2_batched_rank_1
  end interface
  
  interface rocsolver_zpotf2_batched
    function rocsolver_zpotf2_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_zpotf2_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zpotf2_batched_full_rank,rocsolver_zpotf2_batched_rank_0,rocsolver_zpotf2_batched_rank_1
  end interface
  !> ! \brief POTF2_STRIDED_BATCHED computes the Cholesky factorization of a
  !>     batch of real symmetriccomplex Hermitian positive definite matrices.
  !> 
  !>     \details
  !>     (This is the unblocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_i in the batch has the form:
  !> 
  !>         A_i = U_i'  U_i, or
  !>         A_i = L_i   L_i'
  !> 
  !>     depending on the value of uplo. U_i is an upper triangular matrix and L_i is
  !>    lower triangular.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     uplo      rocblas_fill.\n
  !>               Specifies whether the factorization is upper or lower triangular.
  !>               If uplo indicates lower (or upper), then the upper (or lower) part
  !>    of A is not used.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The dimension of matrix A_i.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the matrices A_i to be factored. On exit, the upper
  !>    or lower triangular factors.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               specifies the leading dimension of A_i.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_i and the next one A_(i+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful factorization of matrix A_i. If info_i = j >
  !>    0, the leading minor of order j of A_i is not positive definite. The i-th
  !>    factorization stopped at this point.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_spotf2_strided_batched
    function rocsolver_spotf2_strided_batched_orig(handle,n,A,lda,strideA,batch_count) bind(c, name="rocsolver_spotf2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_spotf2_strided_batched_full_rank,rocsolver_spotf2_strided_batched_rank_0,rocsolver_spotf2_strided_batched_rank_1
  end interface
  
  interface rocsolver_dpotf2_strided_batched
    function rocsolver_dpotf2_strided_batched_orig(handle,n,A,lda,strideA,batch_count) bind(c, name="rocsolver_dpotf2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dpotf2_strided_batched_full_rank,rocsolver_dpotf2_strided_batched_rank_0,rocsolver_dpotf2_strided_batched_rank_1
  end interface
  
  interface rocsolver_cpotf2_strided_batched
    function rocsolver_cpotf2_strided_batched_orig(handle,n,A,lda,myInfo,batch_count) bind(c, name="rocsolver_cpotf2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cpotf2_strided_batched_full_rank,rocsolver_cpotf2_strided_batched_rank_0,rocsolver_cpotf2_strided_batched_rank_1
  end interface
  
  interface rocsolver_zpotf2_strided_batched
    function rocsolver_zpotf2_strided_batched_orig(handle,n,A,lda,myInfo,batch_count) bind(c, name="rocsolver_zpotf2_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zpotf2_strided_batched_full_rank,rocsolver_zpotf2_strided_batched_rank_0,rocsolver_zpotf2_strided_batched_rank_1
  end interface
  !> ! \brief POTRF computes the Cholesky factorization of a real symmetriccomplex
  !>     Hermitian positive definite matrix A.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization has the form:
  !> 
  !>         A = U'  U, or
  !>         A = L   L'
  !> 
  !>     depending on the value of uplo. U is an upper triangular matrix and L is
  !>    lower triangular.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     uplo      rocblas_fill.\n
  !>               Specifies whether the factorization is upper or lower triangular.
  !>               If uplo indicates lower (or upper), then the upper (or lower) part
  !>    of A is not used.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The matrix dimensions.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU of dimension ldan.\n
  !>               On entry, the matrix A to be factored. On exit, the lower or upper
  !>    triangular factor.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               specifies the leading dimension of A.
  !>     @param[out]
  !>     info      pointer to a rocblas_int on the GPU.\n
  !>               If info = 0, successful factorization of matrix A.
  !>               If info = i > 0, the leading minor of order i of A is not positive
  !>    definite. The factorization stopped at this point.
  !> 
  !>     
  interface rocsolver_spotrf
    function rocsolver_spotrf_orig(handle,uplo,n,A,lda,myInfo) bind(c, name="rocsolver_spotrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_spotrf_full_rank,rocsolver_spotrf_rank_0,rocsolver_spotrf_rank_1
  end interface
  
  interface rocsolver_dpotrf
    function rocsolver_dpotrf_orig(handle,uplo,n,A,lda,myInfo) bind(c, name="rocsolver_dpotrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dpotrf_full_rank,rocsolver_dpotrf_rank_0,rocsolver_dpotrf_rank_1
  end interface
  
  interface rocsolver_cpotrf
    function rocsolver_cpotrf_orig(handle,n,A,myInfo) bind(c, name="rocsolver_cpotrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cpotrf_full_rank,rocsolver_cpotrf_rank_0,rocsolver_cpotrf_rank_1
  end interface
  
  interface rocsolver_zpotrf
    function rocsolver_zpotrf_orig(handle,n,A,myInfo) bind(c, name="rocsolver_zpotrf")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zpotrf_full_rank,rocsolver_zpotrf_rank_0,rocsolver_zpotrf_rank_1
  end interface
  !> ! \brief POTRF_BATCHED computes the Cholesky factorization of a
  !>     batch of real symmetriccomplex Hermitian positive definite matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_i in the batch has the form:
  !> 
  !>         A_i = U_i'  U_i, or
  !>         A_i = L_i   L_i'
  !> 
  !>     depending on the value of uplo. U_i is an upper triangular matrix and L_i is
  !>    lower triangular.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     uplo      rocblas_fill.\n
  !>               Specifies whether the factorization is upper or lower triangular.
  !>               If uplo indicates lower (or upper), then the upper (or lower) part
  !>    of A is not used.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The dimension of matrix A_i.
  !>     @param[inout]
  !>     A         array of pointers to type. Each pointer points to an array on the
  !>    GPU of dimension ldan.\n On entry, the matrices A_i to be factored. On exit,
  !>    the upper or lower triangular factors.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               specifies the leading dimension of A_i.
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful factorization of matrix A_i. If info_i = j >
  !>    0, the leading minor of order j of A_i is not positive definite. The i-th
  !>    factorization stopped at this point.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_spotrf_batched
    function rocsolver_spotrf_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_spotrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_spotrf_batched_full_rank,rocsolver_spotrf_batched_rank_0,rocsolver_spotrf_batched_rank_1
  end interface
  
  interface rocsolver_dpotrf_batched
    function rocsolver_dpotrf_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_dpotrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dpotrf_batched_full_rank,rocsolver_dpotrf_batched_rank_0,rocsolver_dpotrf_batched_rank_1
  end interface
  
  interface rocsolver_cpotrf_batched
    function rocsolver_cpotrf_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_cpotrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cpotrf_batched_full_rank,rocsolver_cpotrf_batched_rank_0,rocsolver_cpotrf_batched_rank_1
  end interface
  
  interface rocsolver_zpotrf_batched
    function rocsolver_zpotrf_batched_orig(handle,n,A,myInfo,batch_count) bind(c, name="rocsolver_zpotrf_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zpotrf_batched_full_rank,rocsolver_zpotrf_batched_rank_0,rocsolver_zpotrf_batched_rank_1
  end interface
  !> ! \brief POTRF_STRIDED_BATCHED computes the Cholesky factorization of a
  !>     batch of real symmetriccomplex Hermitian positive definite matrices.
  !> 
  !>     \details
  !>     (This is the blocked version of the algorithm).
  !> 
  !>     The factorization of matrix A_i in the batch has the form:
  !> 
  !>         A_i = U_i'  U_i, or
  !>         A_i = L_i   L_i'
  !> 
  !>     depending on the value of uplo. U_i is an upper triangular matrix and L_i is
  !>    lower triangular.
  !> 
  !>     @param[in]
  !>     handle    rocblas_handle.
  !>     @param[in]
  !>     uplo      rocblas_fill.\n
  !>               Specifies whether the factorization is upper or lower triangular.
  !>               If uplo indicates lower (or upper), then the upper (or lower) part
  !>    of A is not used.
  !>     @param[in]
  !>     n         rocblas_int. n >= 0.\n
  !>               The dimension of matrix A_i.
  !>     @param[inout]
  !>     A         pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry, the matrices A_i to be factored. On exit, the upper
  !>    or lower triangular factors.
  !>     @param[in]
  !>     lda       rocblas_int. lda >= n.\n
  !>               specifies the leading dimension of A_i.
  !>     @param[in]
  !>     strideA   rocblas_stride.\n
  !>               Stride from the start of one matrix A_i and the next one A_(i+1).
  !>               There is no restriction for the value of strideA. Normal use case
  !>    is strideA >= ldan.
  !>     @param[out]
  !>     info      pointer to rocblas_int. Array of batch_count integers on the
  !>    GPU.\n If info_i = 0, successful factorization of matrix A_i. If info_i = j >
  !>    0, the leading minor of order j of A_i is not positive definite. The i-th
  !>    factorization stopped at this point.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_spotrf_strided_batched
    function rocsolver_spotrf_strided_batched_orig(handle,n,A,lda,strideA,batch_count) bind(c, name="rocsolver_spotrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_spotrf_strided_batched_full_rank,rocsolver_spotrf_strided_batched_rank_0,rocsolver_spotrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_dpotrf_strided_batched
    function rocsolver_dpotrf_strided_batched_orig(handle,n,A,lda,strideA,batch_count) bind(c, name="rocsolver_dpotrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dpotrf_strided_batched_full_rank,rocsolver_dpotrf_strided_batched_rank_0,rocsolver_dpotrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_cpotrf_strided_batched
    function rocsolver_cpotrf_strided_batched_orig(handle,n,A,lda,myInfo,batch_count) bind(c, name="rocsolver_cpotrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cpotrf_strided_batched_full_rank,rocsolver_cpotrf_strided_batched_rank_0,rocsolver_cpotrf_strided_batched_rank_1
  end interface
  
  interface rocsolver_zpotrf_strided_batched
    function rocsolver_zpotrf_strided_batched_orig(handle,n,A,lda,myInfo,batch_count) bind(c, name="rocsolver_zpotrf_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_strided_batched_orig
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zpotrf_strided_batched_full_rank,rocsolver_zpotrf_strided_batched_rank_0,rocsolver_zpotrf_strided_batched_rank_1
  end interface
  !> ! \brief GESVD computes the Singular Values and optionally the Singular
  !>    Vectors of a general m-by-n matrix A (Singular Value Decomposition).
  !> 
  !>     \details
  !>     The SVD of matrix A is given by:
  !> 
  !>         A = U  S  V'
  !> 
  !>     where the m-by-n matrix S is zero except, possibly, for its min(m,n)
  !>    diagonal elements, which are the singular values of A. U and V are orthogonal
  !>    (unitary) matrices. The first min(m,n) columns of U and V are the left and
  !>    right singular vectors of A, respectively.
  !> 
  !>     The computation of the singular vectors is optional and it is controlled by
  !>    the function arguments left_svect and right_svect as described below. When
  !>    computed, this function returns the tranpose (or transpose conjugate) of the
  !>    right singular vectors, i.e. the rows of V'.
  !> 
  !>     left_svect and right_svect are rocblas_svect enums that can take the
  !>    following values:
  !> 
  !>     - rocblas_svect_all: the entire matrix U (or V') is computed,
  !>     - rocblas_svect_singular: only the singular vectors (first min(m,n)
  !>    columns of U or rows of V') are computed,
  !>     - rocblas_svect_overwrite: the first
  !>    columns (or rows) of A are overwritten with the singular vectors, or
  !>     - rocblas_svect_none: no columns (or rows) of U (or V') are computed, i.e.
  !>    no singular vectors.
  !> 
  !>     left_svect and right_svect cannot both be set to overwrite. When neither is
  !>    set to overwrite, the contents of A are destroyed by the time the function
  !>    returns.
  !> 
  !>    \note
  !>    When m >> n (or n >> m) the algorithm could be sped up by compressing
  !>    the matrix A via a QR (or LQ) factorization, and working with the triangular
  !>    factor afterwards (thin-SVD). If the singular vectors are also requested, its
  !>    computation could be sped up as well via executing some intermediate
  !>    operations out-of-place, and relying more on matrix multiplications (GEMMs);
  !>    this will require, however, a larger memory workspace. The parameter fast_alg
  !>    controls whether the fast algorithm is executed or not. For more details see
  !>    the sections "Tuning rocSOLVER performance" and "Memory model" on the User's
  !>    guide.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     left_svect  rocblas_svect.\n
  !>                 Specifies how the left singular vectors are computed.
  !>     @param[in]
  !>     right_svect rocblas_svect.\n
  !>                 Specifies how the right singular vectors are computed.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of matrix A.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of matrix A.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU of dimension ldan.\n
  !>                 On entry the matrix A.
  !>                 On exit, if left_svect (or right_svect) is equal to overwrite,
  !>    the first columns (or rows) contain the left (or right) singular vectors;
  !>    otherwise, contents of A are destroyed.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 The leading dimension of A.
  !>     @param[out]
  !>     S           pointer to real type. Array on the GPU of dimension min(m,n).\n
  !>                 The singular values of A in decreasing order.
  !>     @param[out]
  !>     U           pointer to type. Array on the GPU of dimension ldumin(m,n) if
  !>    left_svect is set to singular, or ldum when left_svect is equal to all. \n
  !>                 The matrix of left singular vectors stored as columns. Not
  !>    referenced if left_svect is set to overwrite or none.
  !>     @param[in]
  !>     ldu         rocblas_int. ldu >= m if left_svect is all or singular; ldu >= 1
  !>    otherwise.\n The leading dimension of U.
  !>     @param[out]
  !>     V           pointer to type. Array on the GPU of dimension ldvn. \n
  !>                 The matrix of right singular vectors stored as rows (transposed
  !>     conjugate-tranposed). Not referenced if right_svect is set to overwrite or
  !>    none.
  !>     @param[in]
  !>     ldv         rocblas_int. ldv >= n if right_svect is all; ldv >= min(m,n) if
  !>    right_svect is set to singular; or ldv >= 1 otherwise.\n The leading
  !>    dimension of V.
  !>     @param[out]
  !>     E           pointer to real type. Array on the GPU of dimension
  !>    min(m,n)-1.\n This array is used to work internaly with the bidiagonal matrix
  !>    B associated to A (using BDSQR). On exit, if info > 0, it contains the
  !>    unconverged off-diagonal elements of B (or properly speaking, a bidiagonal
  !>    matrix orthogonally equivalent to B). The diagonal elements of this matrix
  !>    are in S; those that converged correspond to a subset of the singular values
  !>    of A (not necessarily ordered).
  !>     @param[in]
  !>     fast_alg    rocblas_workmode. \n
  !>                 If set to rocblas_outofplace, the function will execute the fast
  !>    thin-SVD version of the algorithm when possible.
  !>     @param[out]
  !>     info        pointer to a rocblas_int on the GPU.\n
  !>                 If info = 0, successful exit.
  !>                 If info = i > 0, BDSQR did not converge. i elements of E did not
  !>    converge to zero.
  !> 
  !>     
  interface rocsolver_sgesvd
    function rocsolver_sgesvd_orig(handle,left_svect,n,A,ldu,V,ldv,E,fast_alg,myInfo) bind(c, name="rocsolver_sgesvd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: ldu
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      type(c_ptr),value :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_sgesvd_full_rank,rocsolver_sgesvd_rank_0,rocsolver_sgesvd_rank_1
  end interface
  
  interface rocsolver_dgesvd
    function rocsolver_dgesvd_orig(handle,left_svect,n,A,lda,S,U,ldv,E,myInfo) bind(c, name="rocsolver_dgesvd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: S
      type(c_ptr),value :: U
      integer(c_int),value :: ldv
      type(c_ptr),value :: E
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_dgesvd_full_rank,rocsolver_dgesvd_rank_0,rocsolver_dgesvd_rank_1
  end interface
  
  interface rocsolver_cgesvd
    function rocsolver_cgesvd_orig(handle,left_svect,n,A,lda,S,U,ldu,V,ldv,E,fast_alg,myInfo) bind(c, name="rocsolver_cgesvd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: S
      type(c_ptr),value :: U
      integer(c_int),value :: ldu
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      type(c_ptr),value :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_cgesvd_full_rank,rocsolver_cgesvd_rank_0,rocsolver_cgesvd_rank_1
  end interface
  
  interface rocsolver_zgesvd
    function rocsolver_zgesvd_orig(handle,left_svect,n,A,lda,S,U,ldu,V,ldv,E,fast_alg,myInfo) bind(c, name="rocsolver_zgesvd")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: S
      type(c_ptr),value :: U
      integer(c_int),value :: ldu
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      type(c_ptr),value :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
    end function

    module procedure rocsolver_zgesvd_full_rank,rocsolver_zgesvd_rank_0,rocsolver_zgesvd_rank_1
  end interface
  !> ! \brief GESVD_BATCHED computes the Singular Values and optionally the
  !>    Singular Vectors of a batch of general m-by-n matrix A (Singular Value
  !>    Decomposition).
  !> 
  !>     \details
  !>     The SVD of matrix A_j is given by:
  !> 
  !>         A_j = U_j  S_j  V_j'
  !> 
  !>     where the m-by-n matrix S_j is zero except, possibly, for its min(m,n)
  !>    diagonal elements, which are the singular values of A_j. U_j and V_j are
  !>    orthogonal (unitary) matrices. The first min(m,n) columns of U_j and V_j are
  !>    the left and right singular vectors of A_j, respectively.
  !> 
  !>     The computation of the singular vectors is optional and it is controlled by
  !>    the function arguments left_svect and right_svect as described below. When
  !>    computed, this function returns the tranpose (or transpose conjugate) of the
  !>    right singular vectors, i.e. the rows of V_j'.
  !> 
  !>     left_svect and right_svect are rocblas_svect enums that can take the
  !>    following values:
  !> 
  !>     - rocblas_svect_all: the entire matrix U_j (or V_j') is computed,
  !>     - rocblas_svect_singular: only the singular vectors (first min(m,n)
  !>    columns of U_j or rows of V_j') are computed,
  !>     - rocblas_svect_overwrite: the
  !>    first columns (or rows) of A_j are overwritten with the singular vectors, or
  !>     - rocblas_svect_none: no columns (or rows) of U_j (or V_j') are computed,
  !>    i.e. no singular vectors.
  !> 
  !>     left_svect and right_svect cannot both be set to overwrite. When neither is
  !>    set to overwrite, the contents of A_j are destroyed by the time the function
  !>    returns.
  !> 
  !>     \note
  !>     When m >> n (or n >> m) the algorithm could be sped up by compressing
  !>    the matrix A_j via a QR (or LQ) factorization, and working with the
  !>     triangular factor afterwards (thin-SVD). If the singular vectors are also
  !>    requested, its computation could be sped up as well via executing some
  !>    intermediate operations out-of-place, and relying more on matrix
  !>    multiplications (GEMMs); this will require, however, a larger memory
  !>     workspace. The parameter fast_alg controls whether the fast algorithm is
  !>    executed or not. For more details see the sections
  !>     "Tuning rocSOLVER performance" and "Memory model" on the User's guide.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     left_svect  rocblas_svect.\n
  !>                 Specifies how the left singular vectors are computed.
  !>     @param[in]
  !>     right_svect rocblas_svect.\n
  !>                 Specifies how the right singular vectors are computed.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of all matrices A_j in the batch.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of all matrices A_j in the batch.
  !>     @param[inout]
  !>     A           Array of pointers to type. Each pointer points to an array on
  !>    the GPU of dimension ldan.\n On entry the matrices A_j. On exit, if
  !>    left_svect (or right_svect) is equal to overwrite, the first columns (or
  !>    rows) of A_j contain the left (or right) corresponding singular vectors;
  !>    otherwise, contents of A_j are destroyed.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 The leading dimension of A_j.
  !>     @param[out]
  !>     S           pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideS).\n The singular values of A_j in decreasing order.
  !>     @param[in]
  !>     strideS     rocblas_stride.\n
  !>                 Stride from the start of one vector S_j to the next one S_(j+1).
  !>    There is no restriction for the value of strideS. Normal use case is strideS
  !>    >= min(m,n).
  !>     @param[out]
  !>     U           pointer to type. Array on the GPU (the side depends on the value
  !>    of strideU). \n The matrices U_j of left singular vectors stored as columns.
  !>    Not referenced if left_svect is set to overwrite or none.
  !>     @param[in]
  !>     ldu         rocblas_int. ldu >= m if left_svect is all or singular; ldu >= 1
  !>    otherwise.\n The leading dimension of U_j.
  !>     @param[in]
  !>     strideU     rocblas_stride.\n
  !>                 Stride from the start of one matrix U_j to the next one U_(j+1).
  !>    There is no restriction for the value of strideU. Normal use case is strideU
  !>    >= ldumin(m,n) if left_svect is set to singular, or strideU >= ldum when
  !>    left_svect is equal to all.
  !>     @param[out]
  !>     V           pointer to type. Array on the GPU (the size depends on the value
  !>    of strideV). \n The matrices V_j of right singular vectors stored as rows
  !>    (transposed  conjugate-tranposed). Not referenced if right_svect is set to
  !>    overwrite or none.
  !>     @param[in]
  !>     ldv         rocblas_int. ldv >= n if right_svect is all; ldv >= min(m,n) if
  !>    right_svect is set to singular; or ldv >= 1 otherwise.\n The leading
  !>    dimension of V.
  !>     @param[in]
  !>     strideV     rocblas_stride.\n
  !>                 Stride from the start of one matrix V_j to the next one V_(j+1).
  !>    There is no restriction for the value of strideV. Normal use case is strideV
  !>    >= ldvn.
  !>     @param[out]
  !>     E           pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideE).\n This array is used to work internaly with the bidiagonal
  !>    matrix B_j associated to A_j (using BDSQR). On exit, if info > 0, it contains
  !>    the unconverged off-diagonal elements of B_j (or properly speaking, a
  !>    bidiagonal matrix orthogonally equivalent to B_j). The diagonal elements of
  !>    this matrix are in S_j; those that converged correspond to a subset of the
  !>    singular values of A_j (not necessarily ordered).
  !>     @param[in]
  !>     strideE     rocblas_stride.\n
  !>                 Stride from the start of one vector E_j to the next one E_(j+1).
  !>    There is no restriction for the value of strideE. Normal use case is strideE
  !>    >= min(m,n)-1.
  !>     @param[in]
  !>     fast_alg    rocblas_workmode. \n
  !>                 If set to rocblas_outofplace, the function will execute the fast
  !>    thin-SVD version of the algorithm when possible.
  !>     @param[out]
  !>     info        pointer to a rocblas_int on the GPU.\n
  !>                 If info = 0, successful exit.
  !>                 If info = i > 0, BDSQR did not converge. i elements of E did not
  !>    converge to zero.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgesvd_batched
    function rocsolver_sgesvd_batched_orig(handle,left_svect,n,A,lda,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count) bind(c, name="rocsolver_sgesvd_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_batched_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgesvd_batched_full_rank,rocsolver_sgesvd_batched_rank_0,rocsolver_sgesvd_batched_rank_1
  end interface
  
  interface rocsolver_dgesvd_batched
    function rocsolver_dgesvd_batched_orig(handle,left_svect,n,A,lda,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count) bind(c, name="rocsolver_dgesvd_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_batched_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgesvd_batched_full_rank,rocsolver_dgesvd_batched_rank_0,rocsolver_dgesvd_batched_rank_1
  end interface
  
  interface rocsolver_cgesvd_batched
    function rocsolver_cgesvd_batched_orig(handle,left_svect,n,A,lda,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,myInfo,batch_count) bind(c, name="rocsolver_cgesvd_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_batched_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: S
      integer(c_int64_t),value :: strideS
      type(c_ptr),value :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgesvd_batched_full_rank,rocsolver_cgesvd_batched_rank_0,rocsolver_cgesvd_batched_rank_1
  end interface
  
  interface rocsolver_zgesvd_batched
    function rocsolver_zgesvd_batched_orig(handle,left_svect,n,A,lda,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,myInfo,batch_count) bind(c, name="rocsolver_zgesvd_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_batched_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: S
      integer(c_int64_t),value :: strideS
      type(c_ptr),value :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgesvd_batched_full_rank,rocsolver_zgesvd_batched_rank_0,rocsolver_zgesvd_batched_rank_1
  end interface
  !> ! \brief GESVD_STRIDED_BATCHED computes the Singular Values and optionally the
  !>    Singular Vectors of a batch of general m-by-n matrix A (Singular Value
  !>    Decomposition).
  !> 
  !>     \details
  !>     The SVD of matrix A_j is given by:
  !> 
  !>         A_j = U_j  S_j  V_j'
  !> 
  !>     where the m-by-n matrix S_j is zero except, possibly, for its min(m,n)
  !>    diagonal elements, which are the singular values of A_j. U_j and V_j are
  !>    orthogonal (unitary) matrices. The first min(m,n) columns of U_j and V_j are
  !>    the left and right singular vectors of A_j, respectively.
  !> 
  !>     The computation of the singular vectors is optional and it is controlled by
  !>    the function arguments left_svect and right_svect as described below. When
  !>    computed, this function returns the tranpose (or transpose conjugate) of the
  !>    right singular vectors, i.e. the rows of V_j'.
  !> 
  !>     left_svect and right_svect are rocblas_svect enums that can take the
  !>    following values:
  !> 
  !>     - rocblas_svect_all: the entire matrix U_j (or V_j') is computed,
  !>     - rocblas_svect_singular: only the singular vectors (first min(m,n) columns
  !>    of U_j or rows of V_j') are computed,
  !>     - rocblas_svect_overwrite: the first columns (or rows) of
  !>    A_j are overwritten with the singular vectors, or
  !>     - rocblas_svect_none: no columns (or rows) of U_j (or V_j')
  !>    are computed, i.e. no singular vectors.
  !> 
  !>     left_svect and right_svect cannot both be set to overwrite. When neither is
  !>    set to overwrite, the contents of A_j are destroyed by the time the function
  !>    returns.
  !> 
  !>     \note
  !>     When m >> n (or n >> m) the algorithm could be sped up by compressing
  !>    the matrix A_j via a QR (or LQ) factorization, and working with the
  !>     triangular factor afterwards (thin-SVD). If the singular vectors are also
  !>    requested, its computation could be sped up as well via executing some
  !>    intermediate operations out-of-place, and relying more on matrix
  !>    multiplications (GEMMs); this will require, however, a larger memory
  !>     workspace. The parameter fast_alg controls whether the fast algorithm is
  !>    executed or not. For more details see the sections
  !>     "Tuning rocSOLVER performance" and "Memory model" on the User's guide.
  !> 
  !>     @param[in]
  !>     handle      rocblas_handle.
  !>     @param[in]
  !>     left_svect  rocblas_svect.\n
  !>                 Specifies how the left singular vectors are computed.
  !>     @param[in]
  !>     right_svect rocblas_svect.\n
  !>                 Specifies how the right singular vectors are computed.
  !>     @param[in]
  !>     m           rocblas_int. m >= 0.\n
  !>                 The number of rows of all matrices A_j in the batch.
  !>     @param[in]
  !>     n           rocblas_int. n >= 0.\n
  !>                 The number of columns of all matrices A_j in the batch.
  !>     @param[inout]
  !>     A           pointer to type. Array on the GPU (the size depends on the value
  !>    of strideA).\n On entry the matrices A_j. On exit, if left_svect (or
  !>    right_svect) is equal to overwrite, the first columns (or rows) of A_j
  !>    contain the left (or right) corresponding singular vectors; otherwise,
  !>    contents of A_j are destroyed.
  !>     @param[in]
  !>     lda         rocblas_int. lda >= m.\n
  !>                 The leading dimension of A_j.
  !>     @param[in]
  !>     strideA     rocblas_stride.\n
  !>                 Stride from the start of one matrix A_j to the next one A_(j+1).
  !>    There is no restriction for the value of strideA. Normal use case is strideA
  !>    >= ldan.
  !>     @param[out]
  !>     S           pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideS).\n The singular values of A_j in decreasing order.
  !>     @param[in]
  !>     strideS     rocblas_stride.\n
  !>                 Stride from the start of one vector S_j to the next one S_(j+1).
  !>    There is no restriction for the value of strideS. Normal use case is strideS
  !>    >= min(m,n).
  !>     @param[out]
  !>     U           pointer to type. Array on the GPU (the side depends on the value
  !>    of strideU). \n The matrices U_j of left singular vectors stored as columns.
  !>    Not referenced if left_svect is set to overwrite or none.
  !>     @param[in]
  !>     ldu         rocblas_int. ldu >= m if left_svect is all or singular; ldu >= 1
  !>    otherwise.\n The leading dimension of U_j.
  !>     @param[in]
  !>     strideU     rocblas_stride.\n
  !>                 Stride from the start of one matrix U_j to the next one U_(j+1).
  !>    There is no restriction for the value of strideU. Normal use case is strideU
  !>    >= ldumin(m,n) if left_svect is set to singular, or strideU >= ldum when
  !>    left_svect is equal to all.
  !>     @param[out]
  !>     V           pointer to type. Array on the GPU (the size depends on the value
  !>    of strideV). \n The matrices V_j of right singular vectors stored as rows
  !>    (transposed  conjugate-tranposed). Not referenced if right_svect is set to
  !>    overwrite or none.
  !>     @param[in]
  !>     ldv         rocblas_int. ldv >= n if right_svect is all; ldv >= min(m,n) if
  !>    right_svect is set to singular; or ldv >= 1 otherwise.\n The leading
  !>    dimension of V.
  !>     @param[in]
  !>     strideV     rocblas_stride.\n
  !>                 Stride from the start of one matrix V_j to the next one V_(j+1).
  !>    There is no restriction for the value of strideV. Normal use case is strideV
  !>    >= ldvn.
  !>     @param[out]
  !>     E           pointer to real type. Array on the GPU (the size depends on the
  !>    value of strideE).\n This array is used to work internaly with the bidiagonal
  !>    matrix B_j associated to A_j (using BDSQR). On exit, if info > 0, it contains
  !>    the unconverged off-diagonal elements of B_j (or properly speaking, a
  !>    bidiagonal matrix orthogonally equivalent to B_j). The diagonal elements of
  !>    this matrix are in S_j; those that converged correspond to a subset of the
  !>    singular values of A_j (not necessarily ordered).
  !>     @param[in]
  !>     strideE     rocblas_stride.\n
  !>                 Stride from the start of one vector E_j to the next one E_(j+1).
  !>    There is no restriction for the value of strideE. Normal use case is strideE
  !>    >= min(m,n)-1.
  !>     @param[in]
  !>     fast_alg    rocblas_workmode. \n
  !>                 If set to rocblas_outofplace, the function will execute the fast
  !>    thin-SVD version of the algorithm when possible.
  !>     @param[out]
  !>     info        pointer to a rocblas_int on the GPU.\n
  !>                 If info = 0, successful exit.
  !>                 If info = i > 0, BDSQR did not converge. i elements of E did not
  !>    converge to zero.
  !>     @param[in]
  !>     batch_count rocblas_int. batch_count >= 0.\n
  !>                 Number of matrices in the batch.
  !> 
  !>     
  interface rocsolver_sgesvd_strided_batched
    function rocsolver_sgesvd_strided_batched_orig(handle,left_svect,n,A,lda,strideA,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count) bind(c, name="rocsolver_sgesvd_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_strided_batched_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_sgesvd_strided_batched_full_rank,rocsolver_sgesvd_strided_batched_rank_0,rocsolver_sgesvd_strided_batched_rank_1
  end interface
  
  interface rocsolver_dgesvd_strided_batched
    function rocsolver_dgesvd_strided_batched_orig(handle,left_svect,n,A,lda,strideA,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count) bind(c, name="rocsolver_dgesvd_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_strided_batched_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_dgesvd_strided_batched_full_rank,rocsolver_dgesvd_strided_batched_rank_0,rocsolver_dgesvd_strided_batched_rank_1
  end interface
  
  interface rocsolver_cgesvd_strided_batched
    function rocsolver_cgesvd_strided_batched_orig(handle,left_svect,n,A,lda,strideA,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,fast_alg,batch_count) bind(c, name="rocsolver_cgesvd_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_strided_batched_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: S
      integer(c_int64_t),value :: strideS
      type(c_ptr),value :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      integer(kind(rocblas_outofplace)),value :: fast_alg
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_cgesvd_strided_batched_full_rank,rocsolver_cgesvd_strided_batched_rank_0,rocsolver_cgesvd_strided_batched_rank_1
  end interface
  
  interface rocsolver_zgesvd_strided_batched
    function rocsolver_zgesvd_strided_batched_orig(handle,left_svect,n,A,lda,strideA,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,fast_alg,batch_count) bind(c, name="rocsolver_zgesvd_strided_batched")
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_strided_batched_orig
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      type(c_ptr),value :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      type(c_ptr),value :: S
      integer(c_int64_t),value :: strideS
      type(c_ptr),value :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      type(c_ptr),value :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      type(c_ptr),value :: E
      integer(c_int64_t),value :: strideE
      integer(kind(rocblas_outofplace)),value :: fast_alg
      integer(c_int),value :: batch_count
    end function

    module procedure rocsolver_zgesvd_strided_batched_full_rank,rocsolver_zgesvd_strided_batched_rank_0,rocsolver_zgesvd_strided_batched_rank_1
  end interface

  contains

    function rocsolver_clacgv_rank_0(handle,n,x,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clacgv_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: x
      integer(c_int),value :: incx
      !
      rocsolver_clacgv_rank_0 = rocsolver_clacgv_orig(handle,n,c_loc(x),incx)
    end function

    function rocsolver_clacgv_rank_1(handle,n,x,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clacgv_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: x
      integer(c_int),value :: incx
      !
      rocsolver_clacgv_rank_1 = rocsolver_clacgv_orig(handle,n,c_loc(x),incx)
    end function

    function rocsolver_zlacgv_rank_0(handle,n,x,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlacgv_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: x
      integer(c_int),value :: incx
      !
      rocsolver_zlacgv_rank_0 = rocsolver_zlacgv_orig(handle,n,c_loc(x),incx)
    end function

    function rocsolver_zlacgv_rank_1(handle,n,x,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlacgv_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: x
      integer(c_int),value :: incx
      !
      rocsolver_zlacgv_rank_1 = rocsolver_zlacgv_orig(handle,n,c_loc(x),incx)
    end function

    function rocsolver_slaswp_rank_0(handle,lda,ipiv,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slaswp_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      integer(c_int),value :: incx
      !
      rocsolver_slaswp_rank_0 = rocsolver_slaswp_orig(handle,lda,c_loc(ipiv),incx)
    end function

    function rocsolver_slaswp_rank_1(handle,lda,ipiv,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slaswp_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int),value :: incx
      !
      rocsolver_slaswp_rank_1 = rocsolver_slaswp_orig(handle,lda,c_loc(ipiv),incx)
    end function

    function rocsolver_dlaswp_full_rank(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlaswp_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_dlaswp_full_rank = rocsolver_dlaswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_dlaswp_rank_0(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlaswp_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_dlaswp_rank_0 = rocsolver_dlaswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_dlaswp_rank_1(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlaswp_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_dlaswp_rank_1 = rocsolver_dlaswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_claswp_full_rank(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_claswp_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_claswp_full_rank = rocsolver_claswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_claswp_rank_0(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_claswp_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_claswp_rank_0 = rocsolver_claswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_claswp_rank_1(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_claswp_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_claswp_rank_1 = rocsolver_claswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_zlaswp_full_rank(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlaswp_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_zlaswp_full_rank = rocsolver_zlaswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_zlaswp_rank_0(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlaswp_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_zlaswp_rank_0 = rocsolver_zlaswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_zlaswp_rank_1(handle,n,A,k2,incx)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlaswp_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: k2
      integer(c_int),value :: incx
      !
      rocsolver_zlaswp_rank_1 = rocsolver_zlaswp_orig(handle,n,c_loc(A),k2,incx)
    end function

    function rocsolver_slarfg_rank_0(handle,n,alpha,x,incx,tau)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarfg_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float) :: alpha
      real(c_float),target :: x
      integer(c_int),value :: incx
      real(c_float) :: tau
      !
      rocsolver_slarfg_rank_0 = rocsolver_slarfg_orig(handle,n,alpha,c_loc(x),incx,tau)
    end function

    function rocsolver_slarfg_rank_1(handle,n,alpha,x,incx,tau)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarfg_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float) :: alpha
      real(c_float),target,dimension(:) :: x
      integer(c_int),value :: incx
      real(c_float) :: tau
      !
      rocsolver_slarfg_rank_1 = rocsolver_slarfg_orig(handle,n,alpha,c_loc(x),incx,tau)
    end function

    function rocsolver_dlarfg_rank_0(handle,n,alpha,x,incx,tau)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarfg_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double) :: alpha
      real(c_double),target :: x
      integer(c_int),value :: incx
      real(c_double) :: tau
      !
      rocsolver_dlarfg_rank_0 = rocsolver_dlarfg_orig(handle,n,alpha,c_loc(x),incx,tau)
    end function

    function rocsolver_dlarfg_rank_1(handle,n,alpha,x,incx,tau)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarfg_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double) :: alpha
      real(c_double),target,dimension(:) :: x
      integer(c_int),value :: incx
      real(c_double) :: tau
      !
      rocsolver_dlarfg_rank_1 = rocsolver_dlarfg_orig(handle,n,alpha,c_loc(x),incx,tau)
    end function

    function rocsolver_clarfg_rank_0(handle,n,alpha,x,incx,tau)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarfg_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex) :: alpha
      complex(c_float_complex),target :: x
      integer(c_int),value :: incx
      complex(c_float_complex) :: tau
      !
      rocsolver_clarfg_rank_0 = rocsolver_clarfg_orig(handle,n,alpha,c_loc(x),incx,tau)
    end function

    function rocsolver_clarfg_rank_1(handle,n,alpha,x,incx,tau)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarfg_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex) :: alpha
      complex(c_float_complex),target,dimension(:) :: x
      integer(c_int),value :: incx
      complex(c_float_complex) :: tau
      !
      rocsolver_clarfg_rank_1 = rocsolver_clarfg_orig(handle,n,alpha,c_loc(x),incx,tau)
    end function

    function rocsolver_zlarfg_rank_0(handle,n,alpha,x,incx,tau)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarfg_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex) :: alpha
      complex(c_double_complex),target :: x
      integer(c_int),value :: incx
      complex(c_double_complex) :: tau
      !
      rocsolver_zlarfg_rank_0 = rocsolver_zlarfg_orig(handle,n,alpha,c_loc(x),incx,tau)
    end function

    function rocsolver_zlarfg_rank_1(handle,n,alpha,x,incx,tau)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarfg_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex) :: alpha
      complex(c_double_complex),target,dimension(:) :: x
      integer(c_int),value :: incx
      complex(c_double_complex) :: tau
      !
      rocsolver_zlarfg_rank_1 = rocsolver_zlarfg_orig(handle,n,alpha,c_loc(x),incx,tau)
    end function

    function rocsolver_slarft_full_rank(handle,myDirect,n,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarft_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_float) :: tau
      real(c_float),target,dimension(:,:) :: T
      integer(c_int),value :: ldt
      !
      rocsolver_slarft_full_rank = rocsolver_slarft_orig(handle,myDirect,n,ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_slarft_rank_0(handle,myDirect,n,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarft_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_float) :: tau
      real(c_float),target :: T
      integer(c_int),value :: ldt
      !
      rocsolver_slarft_rank_0 = rocsolver_slarft_orig(handle,myDirect,n,ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_slarft_rank_1(handle,myDirect,n,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarft_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_float) :: tau
      real(c_float),target,dimension(:) :: T
      integer(c_int),value :: ldt
      !
      rocsolver_slarft_rank_1 = rocsolver_slarft_orig(handle,myDirect,n,ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_dlarft_full_rank(handle,myDirect,n,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarft_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_double) :: tau
      real(c_double),target,dimension(:,:) :: T
      integer(c_int),value :: ldt
      !
      rocsolver_dlarft_full_rank = rocsolver_dlarft_orig(handle,myDirect,n,ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_dlarft_rank_0(handle,myDirect,n,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarft_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_double) :: tau
      real(c_double),target :: T
      integer(c_int),value :: ldt
      !
      rocsolver_dlarft_rank_0 = rocsolver_dlarft_orig(handle,myDirect,n,ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_dlarft_rank_1(handle,myDirect,n,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarft_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_double) :: tau
      real(c_double),target,dimension(:) :: T
      integer(c_int),value :: ldt
      !
      rocsolver_dlarft_rank_1 = rocsolver_dlarft_orig(handle,myDirect,n,ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_clarft_full_rank(handle,myDirect,k,V,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarft_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: k
      complex(c_float_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      complex(c_float_complex) :: tau
      complex(c_float_complex),target,dimension(:,:) :: T
      integer(c_int),value :: ldt
      !
      rocsolver_clarft_full_rank = rocsolver_clarft_orig(handle,myDirect,k,c_loc(V),ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_clarft_rank_0(handle,myDirect,k,V,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarft_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: k
      complex(c_float_complex),target :: V
      integer(c_int),value :: ldv
      complex(c_float_complex) :: tau
      complex(c_float_complex),target :: T
      integer(c_int),value :: ldt
      !
      rocsolver_clarft_rank_0 = rocsolver_clarft_orig(handle,myDirect,k,c_loc(V),ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_clarft_rank_1(handle,myDirect,k,V,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarft_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: k
      complex(c_float_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      complex(c_float_complex) :: tau
      complex(c_float_complex),target,dimension(:) :: T
      integer(c_int),value :: ldt
      !
      rocsolver_clarft_rank_1 = rocsolver_clarft_orig(handle,myDirect,k,c_loc(V),ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_zlarft_full_rank(handle,myDirect,n,k,V,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarft_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: k
      complex(c_double_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      complex(c_double_complex) :: tau
      complex(c_double_complex),target,dimension(:,:) :: T
      integer(c_int),value :: ldt
      !
      rocsolver_zlarft_full_rank = rocsolver_zlarft_orig(handle,myDirect,n,k,c_loc(V),ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_zlarft_rank_0(handle,myDirect,n,k,V,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarft_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: k
      complex(c_double_complex),target :: V
      integer(c_int),value :: ldv
      complex(c_double_complex) :: tau
      complex(c_double_complex),target :: T
      integer(c_int),value :: ldt
      !
      rocsolver_zlarft_rank_0 = rocsolver_zlarft_orig(handle,myDirect,n,k,c_loc(V),ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_zlarft_rank_1(handle,myDirect,n,k,V,ldv,tau,T,ldt)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarft_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: k
      complex(c_double_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      complex(c_double_complex) :: tau
      complex(c_double_complex),target,dimension(:) :: T
      integer(c_int),value :: ldt
      !
      rocsolver_zlarft_rank_1 = rocsolver_zlarft_orig(handle,myDirect,n,k,c_loc(V),ldv,tau,c_loc(T),ldt)
    end function

    function rocsolver_slarf_full_rank(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      real(c_float) :: alpha
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_slarf_full_rank = rocsolver_slarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_slarf_rank_0(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      real(c_float) :: alpha
      real(c_float),target :: A
      integer(c_int),value :: lda
      !
      rocsolver_slarf_rank_0 = rocsolver_slarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_slarf_rank_1(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      real(c_float) :: alpha
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_slarf_rank_1 = rocsolver_slarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_dlarf_full_rank(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      real(c_double) :: alpha
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_dlarf_full_rank = rocsolver_dlarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_dlarf_rank_0(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      real(c_double) :: alpha
      real(c_double),target :: A
      integer(c_int),value :: lda
      !
      rocsolver_dlarf_rank_0 = rocsolver_dlarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_dlarf_rank_1(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      real(c_double) :: alpha
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_dlarf_rank_1 = rocsolver_dlarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_clarf_full_rank(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      complex(c_float_complex) :: alpha
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_clarf_full_rank = rocsolver_clarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_clarf_rank_0(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      complex(c_float_complex) :: alpha
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      !
      rocsolver_clarf_rank_0 = rocsolver_clarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_clarf_rank_1(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      complex(c_float_complex) :: alpha
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_clarf_rank_1 = rocsolver_clarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_zlarf_full_rank(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      complex(c_double_complex) :: alpha
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_zlarf_full_rank = rocsolver_zlarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_zlarf_rank_0(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      complex(c_double_complex) :: alpha
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      !
      rocsolver_zlarf_rank_0 = rocsolver_zlarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_zlarf_rank_1(handle,m,incx,alpha,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: incx
      complex(c_double_complex) :: alpha
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_zlarf_rank_1 = rocsolver_zlarf_orig(handle,m,incx,alpha,c_loc(A),lda)
    end function

    function rocsolver_slarfb_full_rank(handle,side,trans,myDirect,n,ldv,T,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarfb_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_float),target,dimension(:,:) :: T
      integer(c_int),value :: lda
      !
      rocsolver_slarfb_full_rank = rocsolver_slarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),lda)
    end function

    function rocsolver_slarfb_rank_0(handle,side,trans,myDirect,n,ldv,T,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarfb_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_float),target :: T
      integer(c_int),value :: lda
      !
      rocsolver_slarfb_rank_0 = rocsolver_slarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),lda)
    end function

    function rocsolver_slarfb_rank_1(handle,side,trans,myDirect,n,ldv,T,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slarfb_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_float),target,dimension(:) :: T
      integer(c_int),value :: lda
      !
      rocsolver_slarfb_rank_1 = rocsolver_slarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),lda)
    end function

    function rocsolver_dlarfb_full_rank(handle,side,trans,myDirect,n,ldv,T,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarfb_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_double),target,dimension(:,:) :: T
      integer(c_int),value :: lda
      !
      rocsolver_dlarfb_full_rank = rocsolver_dlarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),lda)
    end function

    function rocsolver_dlarfb_rank_0(handle,side,trans,myDirect,n,ldv,T,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarfb_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_double),target :: T
      integer(c_int),value :: lda
      !
      rocsolver_dlarfb_rank_0 = rocsolver_dlarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),lda)
    end function

    function rocsolver_dlarfb_rank_1(handle,side,trans,myDirect,n,ldv,T,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlarfb_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      real(c_double),target,dimension(:) :: T
      integer(c_int),value :: lda
      !
      rocsolver_dlarfb_rank_1 = rocsolver_dlarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),lda)
    end function

    function rocsolver_clarfb_full_rank(handle,side,trans,myDirect,n,ldv,T,ldt,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarfb_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      complex(c_float_complex),target,dimension(:,:) :: T
      integer(c_int),value :: ldt
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_clarfb_full_rank = rocsolver_clarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),ldt,c_loc(A),lda)
    end function

    function rocsolver_clarfb_rank_0(handle,side,trans,myDirect,n,ldv,T,ldt,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarfb_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      complex(c_float_complex),target :: T
      integer(c_int),value :: ldt
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      !
      rocsolver_clarfb_rank_0 = rocsolver_clarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),ldt,c_loc(A),lda)
    end function

    function rocsolver_clarfb_rank_1(handle,side,trans,myDirect,n,ldv,T,ldt,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clarfb_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      complex(c_float_complex),target,dimension(:) :: T
      integer(c_int),value :: ldt
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_clarfb_rank_1 = rocsolver_clarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),ldt,c_loc(A),lda)
    end function

    function rocsolver_zlarfb_full_rank(handle,side,trans,myDirect,n,ldv,T,ldt,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarfb_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      complex(c_double_complex),target,dimension(:,:) :: T
      integer(c_int),value :: ldt
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_zlarfb_full_rank = rocsolver_zlarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),ldt,c_loc(A),lda)
    end function

    function rocsolver_zlarfb_rank_0(handle,side,trans,myDirect,n,ldv,T,ldt,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarfb_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      complex(c_double_complex),target :: T
      integer(c_int),value :: ldt
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      !
      rocsolver_zlarfb_rank_0 = rocsolver_zlarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),ldt,c_loc(A),lda)
    end function

    function rocsolver_zlarfb_rank_1(handle,side,trans,myDirect,n,ldv,T,ldt,A,lda)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlarfb_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(kind(rocblas_operation_none)),value :: trans
      integer(kind(rocblas_forward_direction)),value :: myDirect
      integer(c_int),value :: n
      integer(c_int),value :: ldv
      complex(c_double_complex),target,dimension(:) :: T
      integer(c_int),value :: ldt
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      !
      rocsolver_zlarfb_rank_1 = rocsolver_zlarfb_orig(handle,side,trans,myDirect,n,ldv,c_loc(T),ldt,c_loc(A),lda)
    end function

    function rocsolver_slabrd_full_rank(handle,n,lda,D,E,tauq,taup,X,ldx,Y,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slabrd_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      real(c_float),target,dimension(:) :: tauq
      real(c_float),target,dimension(:) :: taup
      real(c_float),target,dimension(:,:) :: X
      integer(c_int),value :: ldx
      real(c_float),target,dimension(:,:) :: Y
      integer(c_int),value :: ldy
      !
      rocsolver_slabrd_full_rank = rocsolver_slabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldx,c_loc(Y),ldy)
    end function

    function rocsolver_slabrd_rank_0(handle,n,lda,D,E,tauq,taup,X,ldx,Y,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slabrd_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: D
      real(c_float),target :: E
      real(c_float),target :: tauq
      real(c_float),target :: taup
      real(c_float),target :: X
      integer(c_int),value :: ldx
      real(c_float),target :: Y
      integer(c_int),value :: ldy
      !
      rocsolver_slabrd_rank_0 = rocsolver_slabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldx,c_loc(Y),ldy)
    end function

    function rocsolver_slabrd_rank_1(handle,n,lda,D,E,tauq,taup,X,ldx,Y,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_slabrd_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      real(c_float),target,dimension(:) :: tauq
      real(c_float),target,dimension(:) :: taup
      real(c_float),target,dimension(:) :: X
      integer(c_int),value :: ldx
      real(c_float),target,dimension(:) :: Y
      integer(c_int),value :: ldy
      !
      rocsolver_slabrd_rank_1 = rocsolver_slabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldx,c_loc(Y),ldy)
    end function

    function rocsolver_dlabrd_full_rank(handle,n,lda,D,E,tauq,taup,X,ldx,Y,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlabrd_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      real(c_double),target,dimension(:) :: tauq
      real(c_double),target,dimension(:) :: taup
      real(c_double),target,dimension(:,:) :: X
      integer(c_int),value :: ldx
      real(c_double),target,dimension(:,:) :: Y
      integer(c_int),value :: ldy
      !
      rocsolver_dlabrd_full_rank = rocsolver_dlabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldx,c_loc(Y),ldy)
    end function

    function rocsolver_dlabrd_rank_0(handle,n,lda,D,E,tauq,taup,X,ldx,Y,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlabrd_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: D
      real(c_double),target :: E
      real(c_double),target :: tauq
      real(c_double),target :: taup
      real(c_double),target :: X
      integer(c_int),value :: ldx
      real(c_double),target :: Y
      integer(c_int),value :: ldy
      !
      rocsolver_dlabrd_rank_0 = rocsolver_dlabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldx,c_loc(Y),ldy)
    end function

    function rocsolver_dlabrd_rank_1(handle,n,lda,D,E,tauq,taup,X,ldx,Y,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dlabrd_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      real(c_double),target,dimension(:) :: tauq
      real(c_double),target,dimension(:) :: taup
      real(c_double),target,dimension(:) :: X
      integer(c_int),value :: ldx
      real(c_double),target,dimension(:) :: Y
      integer(c_int),value :: ldy
      !
      rocsolver_dlabrd_rank_1 = rocsolver_dlabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldx,c_loc(Y),ldy)
    end function

    function rocsolver_clabrd_full_rank(handle,n,lda,D,E,tauq,taup,X,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clabrd_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      complex(c_float_complex),target,dimension(:) :: tauq
      complex(c_float_complex),target,dimension(:) :: taup
      complex(c_float_complex),target,dimension(:,:) :: X
      integer(c_int),value :: ldy
      !
      rocsolver_clabrd_full_rank = rocsolver_clabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldy)
    end function

    function rocsolver_clabrd_rank_0(handle,n,lda,D,E,tauq,taup,X,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clabrd_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: D
      real(c_float),target :: E
      complex(c_float_complex),target :: tauq
      complex(c_float_complex),target :: taup
      complex(c_float_complex),target :: X
      integer(c_int),value :: ldy
      !
      rocsolver_clabrd_rank_0 = rocsolver_clabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldy)
    end function

    function rocsolver_clabrd_rank_1(handle,n,lda,D,E,tauq,taup,X,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_clabrd_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      complex(c_float_complex),target,dimension(:) :: tauq
      complex(c_float_complex),target,dimension(:) :: taup
      complex(c_float_complex),target,dimension(:) :: X
      integer(c_int),value :: ldy
      !
      rocsolver_clabrd_rank_1 = rocsolver_clabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldy)
    end function

    function rocsolver_zlabrd_full_rank(handle,n,lda,D,E,tauq,taup,X,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlabrd_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      complex(c_double_complex),target,dimension(:) :: tauq
      complex(c_double_complex),target,dimension(:) :: taup
      complex(c_double_complex),target,dimension(:,:) :: X
      integer(c_int),value :: ldy
      !
      rocsolver_zlabrd_full_rank = rocsolver_zlabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldy)
    end function

    function rocsolver_zlabrd_rank_0(handle,n,lda,D,E,tauq,taup,X,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlabrd_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: D
      real(c_double),target :: E
      complex(c_double_complex),target :: tauq
      complex(c_double_complex),target :: taup
      complex(c_double_complex),target :: X
      integer(c_int),value :: ldy
      !
      rocsolver_zlabrd_rank_0 = rocsolver_zlabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldy)
    end function

    function rocsolver_zlabrd_rank_1(handle,n,lda,D,E,tauq,taup,X,ldy)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zlabrd_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      complex(c_double_complex),target,dimension(:) :: tauq
      complex(c_double_complex),target,dimension(:) :: taup
      complex(c_double_complex),target,dimension(:) :: X
      integer(c_int),value :: ldy
      !
      rocsolver_zlabrd_rank_1 = rocsolver_zlabrd_orig(handle,n,lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup),c_loc(X),ldy)
    end function

    function rocsolver_sorg2r_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorg2r_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sorg2r_rank_0 = rocsolver_sorg2r_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_sorg2r_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorg2r_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sorg2r_rank_1 = rocsolver_sorg2r_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_dorg2r_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorg2r_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dorg2r_rank_0 = rocsolver_dorg2r_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_dorg2r_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorg2r_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dorg2r_rank_1 = rocsolver_dorg2r_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_cung2r_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cung2r_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cung2r_rank_0 = rocsolver_cung2r_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_cung2r_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cung2r_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cung2r_rank_1 = rocsolver_cung2r_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_zung2r_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zung2r_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zung2r_rank_0 = rocsolver_zung2r_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_zung2r_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zung2r_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zung2r_rank_1 = rocsolver_zung2r_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_sorgqr_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgqr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sorgqr_rank_0 = rocsolver_sorgqr_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_sorgqr_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgqr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sorgqr_rank_1 = rocsolver_sorgqr_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_dorgqr_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgqr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dorgqr_rank_0 = rocsolver_dorgqr_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_dorgqr_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgqr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dorgqr_rank_1 = rocsolver_dorgqr_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_cungqr_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungqr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cungqr_rank_0 = rocsolver_cungqr_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_cungqr_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungqr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cungqr_rank_1 = rocsolver_cungqr_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_zungqr_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungqr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zungqr_rank_0 = rocsolver_zungqr_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_zungqr_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungqr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zungqr_rank_1 = rocsolver_zungqr_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_sorgl2_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgl2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sorgl2_rank_0 = rocsolver_sorgl2_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_sorgl2_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgl2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sorgl2_rank_1 = rocsolver_sorgl2_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_dorgl2_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgl2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dorgl2_rank_0 = rocsolver_dorgl2_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_dorgl2_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgl2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dorgl2_rank_1 = rocsolver_dorgl2_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_cungl2_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungl2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cungl2_rank_0 = rocsolver_cungl2_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_cungl2_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungl2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cungl2_rank_1 = rocsolver_cungl2_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_zungl2_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungl2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zungl2_rank_0 = rocsolver_zungl2_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_zungl2_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungl2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zungl2_rank_1 = rocsolver_zungl2_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_sorglq_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorglq_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sorglq_rank_0 = rocsolver_sorglq_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_sorglq_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorglq_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sorglq_rank_1 = rocsolver_sorglq_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_dorglq_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorglq_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dorglq_rank_0 = rocsolver_dorglq_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_dorglq_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorglq_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dorglq_rank_1 = rocsolver_dorglq_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_cunglq_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunglq_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cunglq_rank_0 = rocsolver_cunglq_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_cunglq_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunglq_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cunglq_rank_1 = rocsolver_cunglq_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_zunglq_rank_0(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunglq_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zunglq_rank_0 = rocsolver_zunglq_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_zunglq_rank_1(handle,n,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunglq_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zunglq_rank_1 = rocsolver_zunglq_orig(handle,n,lda,c_loc(ipiv))
    end function

    function rocsolver_sorgbr_full_rank(handle,storev,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgbr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(c_int),value :: k
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sorgbr_full_rank = rocsolver_sorgbr_orig(handle,storev,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sorgbr_rank_0(handle,storev,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgbr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(c_int),value :: k
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sorgbr_rank_0 = rocsolver_sorgbr_orig(handle,storev,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sorgbr_rank_1(handle,storev,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorgbr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(c_int),value :: k
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sorgbr_rank_1 = rocsolver_sorgbr_orig(handle,storev,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dorgbr_full_rank(handle,storev,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgbr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(c_int),value :: k
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dorgbr_full_rank = rocsolver_dorgbr_orig(handle,storev,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dorgbr_rank_0(handle,storev,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgbr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(c_int),value :: k
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dorgbr_rank_0 = rocsolver_dorgbr_orig(handle,storev,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dorgbr_rank_1(handle,storev,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorgbr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(c_int),value :: k
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dorgbr_rank_1 = rocsolver_dorgbr_orig(handle,storev,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cungbr_full_rank(handle,m,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungbr_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: k
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cungbr_full_rank = rocsolver_cungbr_orig(handle,m,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cungbr_rank_0(handle,m,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungbr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: k
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cungbr_rank_0 = rocsolver_cungbr_orig(handle,m,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cungbr_rank_1(handle,m,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cungbr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: k
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cungbr_rank_1 = rocsolver_cungbr_orig(handle,m,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zungbr_full_rank(handle,m,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungbr_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: k
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zungbr_full_rank = rocsolver_zungbr_orig(handle,m,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zungbr_rank_0(handle,m,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungbr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: k
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zungbr_rank_0 = rocsolver_zungbr_orig(handle,m,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zungbr_rank_1(handle,m,k,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zungbr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: k
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zungbr_rank_1 = rocsolver_zungbr_orig(handle,m,k,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sorm2r_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorm2r_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sorm2r_full_rank = rocsolver_sorm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sorm2r_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorm2r_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      real(c_float),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sorm2r_rank_0 = rocsolver_sorm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sorm2r_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorm2r_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sorm2r_rank_1 = rocsolver_sorm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dorm2r_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorm2r_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dorm2r_full_rank = rocsolver_dorm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dorm2r_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorm2r_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      real(c_double),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dorm2r_rank_0 = rocsolver_dorm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dorm2r_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorm2r_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dorm2r_rank_1 = rocsolver_dorm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunm2r_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunm2r_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunm2r_full_rank = rocsolver_cunm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunm2r_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunm2r_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      complex(c_float_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunm2r_rank_0 = rocsolver_cunm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunm2r_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunm2r_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunm2r_rank_1 = rocsolver_cunm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunm2r_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunm2r_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunm2r_full_rank = rocsolver_zunm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunm2r_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunm2r_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      complex(c_double_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunm2r_rank_0 = rocsolver_zunm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunm2r_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunm2r_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunm2r_rank_1 = rocsolver_zunm2r_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormqr_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormqr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormqr_full_rank = rocsolver_sormqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormqr_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormqr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      real(c_float),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormqr_rank_0 = rocsolver_sormqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormqr_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormqr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormqr_rank_1 = rocsolver_sormqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormqr_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormqr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormqr_full_rank = rocsolver_dormqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormqr_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormqr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      real(c_double),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormqr_rank_0 = rocsolver_dormqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormqr_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormqr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormqr_rank_1 = rocsolver_dormqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmqr_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmqr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmqr_full_rank = rocsolver_cunmqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmqr_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmqr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      complex(c_float_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmqr_rank_0 = rocsolver_cunmqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmqr_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmqr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmqr_rank_1 = rocsolver_cunmqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmqr_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmqr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmqr_full_rank = rocsolver_zunmqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmqr_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmqr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      complex(c_double_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmqr_rank_0 = rocsolver_zunmqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmqr_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmqr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmqr_rank_1 = rocsolver_zunmqr_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sorml2_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorml2_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sorml2_full_rank = rocsolver_sorml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sorml2_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorml2_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      real(c_float),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sorml2_rank_0 = rocsolver_sorml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sorml2_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sorml2_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sorml2_rank_1 = rocsolver_sorml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dorml2_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorml2_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dorml2_full_rank = rocsolver_dorml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dorml2_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorml2_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      real(c_double),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dorml2_rank_0 = rocsolver_dorml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dorml2_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dorml2_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dorml2_rank_1 = rocsolver_dorml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunml2_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunml2_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunml2_full_rank = rocsolver_cunml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunml2_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunml2_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      complex(c_float_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunml2_rank_0 = rocsolver_cunml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunml2_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunml2_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunml2_rank_1 = rocsolver_cunml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunml2_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunml2_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunml2_full_rank = rocsolver_zunml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunml2_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunml2_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      complex(c_double_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunml2_rank_0 = rocsolver_zunml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunml2_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunml2_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunml2_rank_1 = rocsolver_zunml2_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormlq_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormlq_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormlq_full_rank = rocsolver_sormlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormlq_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormlq_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      real(c_float),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormlq_rank_0 = rocsolver_sormlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormlq_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormlq_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormlq_rank_1 = rocsolver_sormlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormlq_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormlq_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormlq_full_rank = rocsolver_dormlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormlq_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormlq_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      real(c_double),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormlq_rank_0 = rocsolver_dormlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormlq_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormlq_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormlq_rank_1 = rocsolver_dormlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmlq_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmlq_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmlq_full_rank = rocsolver_cunmlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmlq_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmlq_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      complex(c_float_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmlq_rank_0 = rocsolver_cunmlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmlq_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmlq_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmlq_rank_1 = rocsolver_cunmlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmlq_full_rank(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmlq_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmlq_full_rank = rocsolver_zunmlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmlq_rank_0(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmlq_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      complex(c_double_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmlq_rank_0 = rocsolver_zunmlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmlq_rank_1(handle,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmlq_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmlq_rank_1 = rocsolver_zunmlq_orig(handle,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormbr_full_rank(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormbr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormbr_full_rank = rocsolver_sormbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormbr_rank_0(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormbr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      real(c_float),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormbr_rank_0 = rocsolver_sormbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sormbr_rank_1(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sormbr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      real(c_float),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_sormbr_rank_1 = rocsolver_sormbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormbr_full_rank(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormbr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormbr_full_rank = rocsolver_dormbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormbr_rank_0(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormbr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      real(c_double),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormbr_rank_0 = rocsolver_dormbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_dormbr_rank_1(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dormbr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      real(c_double),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_dormbr_rank_1 = rocsolver_dormbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmbr_full_rank(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmbr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmbr_full_rank = rocsolver_cunmbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmbr_rank_0(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmbr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      complex(c_float_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmbr_rank_0 = rocsolver_cunmbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_cunmbr_rank_1(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cunmbr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      complex(c_float_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_cunmbr_rank_1 = rocsolver_cunmbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmbr_full_rank(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmbr_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:,:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmbr_full_rank = rocsolver_zunmbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmbr_rank_0(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmbr_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      complex(c_double_complex),target :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmbr_rank_0 = rocsolver_zunmbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_zunmbr_rank_1(handle,storev,side,n,lda,ipiv,C,ldc)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zunmbr_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_column_wise)),value :: storev
      integer(kind(rocblas_side_left)),value :: side
      integer(c_int),value :: n
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      complex(c_double_complex),target,dimension(:) :: C
      integer(c_int),value :: ldc
      !
      rocsolver_zunmbr_rank_1 = rocsolver_zunmbr_orig(handle,storev,side,n,lda,c_loc(ipiv),c_loc(C),ldc)
    end function

    function rocsolver_sbdsqr_full_rank(handle,n,nc,D,E,V,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sbdsqr_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      real(c_float),target,dimension(:,:) :: V
      integer(c_int),value :: ldu
      real(c_float),target,dimension(:,:) :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_sbdsqr_full_rank = rocsolver_sbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_sbdsqr_rank_0(handle,n,nc,D,E,V,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sbdsqr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_float),target :: D
      real(c_float),target :: E
      real(c_float),target :: V
      integer(c_int),value :: ldu
      real(c_float),target :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_sbdsqr_rank_0 = rocsolver_sbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_sbdsqr_rank_1(handle,n,nc,D,E,V,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sbdsqr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      real(c_float),target,dimension(:) :: V
      integer(c_int),value :: ldu
      real(c_float),target,dimension(:) :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_sbdsqr_rank_1 = rocsolver_sbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_dbdsqr_full_rank(handle,n,nc,D,E,V,ldv,U,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dbdsqr_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      real(c_double),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      real(c_double),target,dimension(:,:) :: U
      type(c_ptr),value :: myInfo
      !
      rocsolver_dbdsqr_full_rank = rocsolver_dbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),myInfo)
    end function

    function rocsolver_dbdsqr_rank_0(handle,n,nc,D,E,V,ldv,U,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dbdsqr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_double),target :: D
      real(c_double),target :: E
      real(c_double),target :: V
      integer(c_int),value :: ldv
      real(c_double),target :: U
      type(c_ptr),value :: myInfo
      !
      rocsolver_dbdsqr_rank_0 = rocsolver_dbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),myInfo)
    end function

    function rocsolver_dbdsqr_rank_1(handle,n,nc,D,E,V,ldv,U,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dbdsqr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      real(c_double),target,dimension(:) :: V
      integer(c_int),value :: ldv
      real(c_double),target,dimension(:) :: U
      type(c_ptr),value :: myInfo
      !
      rocsolver_dbdsqr_rank_1 = rocsolver_dbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),myInfo)
    end function

    function rocsolver_cbdsqr_full_rank(handle,n,nc,D,E,V,ldv,U,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cbdsqr_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      complex(c_float_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      complex(c_float_complex),target,dimension(:,:) :: U
      integer(c_int),value :: ldu
      complex(c_float_complex),target,dimension(:,:) :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_cbdsqr_full_rank = rocsolver_cbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_cbdsqr_rank_0(handle,n,nc,D,E,V,ldv,U,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cbdsqr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_float),target :: D
      real(c_float),target :: E
      complex(c_float_complex),target :: V
      integer(c_int),value :: ldv
      complex(c_float_complex),target :: U
      integer(c_int),value :: ldu
      complex(c_float_complex),target :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_cbdsqr_rank_0 = rocsolver_cbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_cbdsqr_rank_1(handle,n,nc,D,E,V,ldv,U,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cbdsqr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      complex(c_float_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      complex(c_float_complex),target,dimension(:) :: U
      integer(c_int),value :: ldu
      complex(c_float_complex),target,dimension(:) :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_cbdsqr_rank_1 = rocsolver_cbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_zbdsqr_full_rank(handle,n,nc,D,E,V,ldv,U,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zbdsqr_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      complex(c_double_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      complex(c_double_complex),target,dimension(:,:) :: U
      integer(c_int),value :: ldu
      complex(c_double_complex),target,dimension(:,:) :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_zbdsqr_full_rank = rocsolver_zbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_zbdsqr_rank_0(handle,n,nc,D,E,V,ldv,U,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zbdsqr_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_double),target :: D
      real(c_double),target :: E
      complex(c_double_complex),target :: V
      integer(c_int),value :: ldv
      complex(c_double_complex),target :: U
      integer(c_int),value :: ldu
      complex(c_double_complex),target :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_zbdsqr_rank_0 = rocsolver_zbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_zbdsqr_rank_1(handle,n,nc,D,E,V,ldv,U,ldu,C,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zbdsqr_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nc
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      complex(c_double_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      complex(c_double_complex),target,dimension(:) :: U
      integer(c_int),value :: ldu
      complex(c_double_complex),target,dimension(:) :: C
      type(c_ptr),value :: myInfo
      !
      rocsolver_zbdsqr_rank_1 = rocsolver_zbdsqr_orig(handle,n,nc,c_loc(D),c_loc(E),c_loc(V),ldv,c_loc(U),ldu,c_loc(C),myInfo)
    end function

    function rocsolver_sgetf2_npvt_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetf2_npvt_full_rank = rocsolver_sgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetf2_npvt_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetf2_npvt_rank_0 = rocsolver_sgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetf2_npvt_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetf2_npvt_rank_1 = rocsolver_sgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetf2_npvt_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetf2_npvt_full_rank = rocsolver_dgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetf2_npvt_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetf2_npvt_rank_0 = rocsolver_dgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetf2_npvt_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetf2_npvt_rank_1 = rocsolver_dgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetf2_npvt_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetf2_npvt_full_rank = rocsolver_cgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetf2_npvt_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetf2_npvt_rank_0 = rocsolver_cgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetf2_npvt_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetf2_npvt_rank_1 = rocsolver_cgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetf2_npvt_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetf2_npvt_full_rank = rocsolver_zgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetf2_npvt_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetf2_npvt_rank_0 = rocsolver_zgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetf2_npvt_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetf2_npvt_rank_1 = rocsolver_zgetf2_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetf2_npvt_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_npvt_batched_full_rank = rocsolver_sgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_npvt_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_npvt_batched_rank_0 = rocsolver_sgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_npvt_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_npvt_batched_rank_1 = rocsolver_sgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_npvt_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_npvt_batched_full_rank = rocsolver_dgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_npvt_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_npvt_batched_rank_0 = rocsolver_dgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_npvt_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_npvt_batched_rank_1 = rocsolver_dgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_npvt_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_npvt_batched_full_rank = rocsolver_cgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_npvt_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_npvt_batched_rank_0 = rocsolver_cgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_npvt_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_npvt_batched_rank_1 = rocsolver_cgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_npvt_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_npvt_batched_full_rank = rocsolver_zgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_npvt_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_npvt_batched_rank_0 = rocsolver_zgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_npvt_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_npvt_batched_rank_1 = rocsolver_zgetf2_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_npvt_strided_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_npvt_strided_batched_full_rank = rocsolver_sgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_npvt_strided_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_npvt_strided_batched_rank_0 = rocsolver_sgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_npvt_strided_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_npvt_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_npvt_strided_batched_rank_1 = rocsolver_sgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_npvt_strided_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_npvt_strided_batched_full_rank = rocsolver_dgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_npvt_strided_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_npvt_strided_batched_rank_0 = rocsolver_dgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_npvt_strided_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_npvt_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_npvt_strided_batched_rank_1 = rocsolver_dgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_npvt_strided_batched_full_rank(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_npvt_strided_batched_full_rank = rocsolver_cgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_cgetf2_npvt_strided_batched_rank_0(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_npvt_strided_batched_rank_0 = rocsolver_cgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_cgetf2_npvt_strided_batched_rank_1(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_npvt_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_npvt_strided_batched_rank_1 = rocsolver_cgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zgetf2_npvt_strided_batched_full_rank(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_npvt_strided_batched_full_rank = rocsolver_zgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zgetf2_npvt_strided_batched_rank_0(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_npvt_strided_batched_rank_0 = rocsolver_zgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zgetf2_npvt_strided_batched_rank_1(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_npvt_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_npvt_strided_batched_rank_1 = rocsolver_zgetf2_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_sgetrf_npvt_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetrf_npvt_full_rank = rocsolver_sgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetrf_npvt_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetrf_npvt_rank_0 = rocsolver_sgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetrf_npvt_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetrf_npvt_rank_1 = rocsolver_sgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetrf_npvt_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetrf_npvt_full_rank = rocsolver_dgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetrf_npvt_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetrf_npvt_rank_0 = rocsolver_dgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetrf_npvt_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetrf_npvt_rank_1 = rocsolver_dgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetrf_npvt_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetrf_npvt_full_rank = rocsolver_cgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetrf_npvt_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetrf_npvt_rank_0 = rocsolver_cgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetrf_npvt_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetrf_npvt_rank_1 = rocsolver_cgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetrf_npvt_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetrf_npvt_full_rank = rocsolver_zgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetrf_npvt_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetrf_npvt_rank_0 = rocsolver_zgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetrf_npvt_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetrf_npvt_rank_1 = rocsolver_zgetrf_npvt_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetrf_npvt_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_npvt_batched_full_rank = rocsolver_sgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_npvt_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_npvt_batched_rank_0 = rocsolver_sgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_npvt_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_npvt_batched_rank_1 = rocsolver_sgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_npvt_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_npvt_batched_full_rank = rocsolver_dgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_npvt_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_npvt_batched_rank_0 = rocsolver_dgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_npvt_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_npvt_batched_rank_1 = rocsolver_dgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_npvt_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_npvt_batched_full_rank = rocsolver_cgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_npvt_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_npvt_batched_rank_0 = rocsolver_cgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_npvt_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_npvt_batched_rank_1 = rocsolver_cgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_npvt_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_npvt_batched_full_rank = rocsolver_zgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_npvt_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_npvt_batched_rank_0 = rocsolver_zgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_npvt_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_npvt_batched_rank_1 = rocsolver_zgetrf_npvt_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_npvt_strided_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_npvt_strided_batched_full_rank = rocsolver_sgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_npvt_strided_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_npvt_strided_batched_rank_0 = rocsolver_sgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_npvt_strided_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_npvt_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_npvt_strided_batched_rank_1 = rocsolver_sgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_npvt_strided_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_npvt_strided_batched_full_rank = rocsolver_dgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_npvt_strided_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_npvt_strided_batched_rank_0 = rocsolver_dgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_npvt_strided_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_npvt_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_npvt_strided_batched_rank_1 = rocsolver_dgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_npvt_strided_batched_full_rank(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_npvt_strided_batched_full_rank = rocsolver_cgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_cgetrf_npvt_strided_batched_rank_0(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_npvt_strided_batched_rank_0 = rocsolver_cgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_cgetrf_npvt_strided_batched_rank_1(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_npvt_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_npvt_strided_batched_rank_1 = rocsolver_cgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zgetrf_npvt_strided_batched_full_rank(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_npvt_strided_batched_full_rank = rocsolver_zgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zgetrf_npvt_strided_batched_rank_0(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_npvt_strided_batched_rank_0 = rocsolver_zgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zgetrf_npvt_strided_batched_rank_1(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_npvt_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_npvt_strided_batched_rank_1 = rocsolver_zgetrf_npvt_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_sgetf2_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetf2_full_rank = rocsolver_sgetf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetf2_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetf2_rank_0 = rocsolver_sgetf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetf2_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetf2_rank_1 = rocsolver_sgetf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetf2_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetf2_full_rank = rocsolver_dgetf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetf2_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetf2_rank_0 = rocsolver_dgetf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetf2_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetf2_rank_1 = rocsolver_dgetf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetf2_full_rank(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetf2_full_rank = rocsolver_cgetf2_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetf2_rank_0(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetf2_rank_0 = rocsolver_cgetf2_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetf2_rank_1(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetf2_rank_1 = rocsolver_cgetf2_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetf2_full_rank(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetf2_full_rank = rocsolver_zgetf2_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetf2_rank_0(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetf2_rank_0 = rocsolver_zgetf2_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetf2_rank_1(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetf2_rank_1 = rocsolver_zgetf2_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetf2_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_batched_full_rank = rocsolver_sgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_batched_rank_0 = rocsolver_sgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_batched_rank_1 = rocsolver_sgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_batched_full_rank = rocsolver_dgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_batched_rank_0 = rocsolver_dgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_batched_rank_1 = rocsolver_dgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_batched_full_rank = rocsolver_cgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_batched_rank_0 = rocsolver_cgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_batched_rank_1 = rocsolver_cgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_batched_full_rank = rocsolver_zgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_batched_rank_0 = rocsolver_zgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_batched_rank_1 = rocsolver_zgetf2_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_strided_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_strided_batched_full_rank = rocsolver_sgetf2_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_strided_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_strided_batched_rank_0 = rocsolver_sgetf2_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetf2_strided_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetf2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetf2_strided_batched_rank_1 = rocsolver_sgetf2_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_strided_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_strided_batched_full_rank = rocsolver_dgetf2_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_strided_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_strided_batched_rank_0 = rocsolver_dgetf2_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetf2_strided_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetf2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetf2_strided_batched_rank_1 = rocsolver_dgetf2_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_strided_batched_full_rank(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_strided_batched_full_rank = rocsolver_cgetf2_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_strided_batched_rank_0(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_strided_batched_rank_0 = rocsolver_cgetf2_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetf2_strided_batched_rank_1(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetf2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetf2_strided_batched_rank_1 = rocsolver_cgetf2_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_strided_batched_full_rank(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_strided_batched_full_rank = rocsolver_zgetf2_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_strided_batched_rank_0(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_strided_batched_rank_0 = rocsolver_zgetf2_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetf2_strided_batched_rank_1(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetf2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetf2_strided_batched_rank_1 = rocsolver_zgetf2_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetrf_full_rank = rocsolver_sgetrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetrf_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetrf_rank_0 = rocsolver_sgetrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetrf_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetrf_rank_1 = rocsolver_sgetrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetrf_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetrf_full_rank = rocsolver_dgetrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetrf_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetrf_rank_0 = rocsolver_dgetrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_dgetrf_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetrf_rank_1 = rocsolver_dgetrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetrf_full_rank(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetrf_full_rank = rocsolver_cgetrf_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetrf_rank_0(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetrf_rank_0 = rocsolver_cgetrf_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetrf_rank_1(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetrf_rank_1 = rocsolver_cgetrf_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetrf_full_rank(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetrf_full_rank = rocsolver_zgetrf_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetrf_rank_0(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetrf_rank_0 = rocsolver_zgetrf_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetrf_rank_1(handle,m,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetrf_rank_1 = rocsolver_zgetrf_orig(handle,m,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetrf_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_batched_full_rank = rocsolver_sgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_batched_rank_0 = rocsolver_sgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_batched_rank_1 = rocsolver_sgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_batched_full_rank = rocsolver_dgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_batched_rank_0 = rocsolver_dgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_batched_rank_1 = rocsolver_dgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_batched_full_rank = rocsolver_cgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_batched_rank_0 = rocsolver_cgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_batched_rank_1 = rocsolver_cgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_batched_full_rank = rocsolver_zgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_batched_rank_0 = rocsolver_zgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_batched_rank_1 = rocsolver_zgetrf_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_strided_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_strided_batched_full_rank = rocsolver_sgetrf_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_strided_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_strided_batched_rank_0 = rocsolver_sgetrf_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetrf_strided_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrf_strided_batched_rank_1 = rocsolver_sgetrf_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_strided_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_strided_batched_full_rank = rocsolver_dgetrf_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_strided_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_strided_batched_rank_0 = rocsolver_dgetrf_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetrf_strided_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrf_strided_batched_rank_1 = rocsolver_dgetrf_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_strided_batched_full_rank(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_strided_batched_full_rank = rocsolver_cgetrf_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_strided_batched_rank_0(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_strided_batched_rank_0 = rocsolver_cgetrf_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetrf_strided_batched_rank_1(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrf_strided_batched_rank_1 = rocsolver_cgetrf_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_strided_batched_full_rank(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_strided_batched_full_rank = rocsolver_zgetrf_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_strided_batched_rank_0(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_strided_batched_rank_0 = rocsolver_zgetrf_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetrf_strided_batched_rank_1(handle,n,A,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrf_strided_batched_rank_1 = rocsolver_zgetrf_strided_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgeqr2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgeqr2_full_rank = rocsolver_sgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqr2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sgeqr2_rank_0 = rocsolver_sgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqr2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgeqr2_rank_1 = rocsolver_sgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqr2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgeqr2_full_rank = rocsolver_dgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqr2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dgeqr2_rank_0 = rocsolver_dgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqr2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgeqr2_rank_1 = rocsolver_dgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqr2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgeqr2_full_rank = rocsolver_cgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqr2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cgeqr2_rank_0 = rocsolver_cgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqr2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgeqr2_rank_1 = rocsolver_cgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqr2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgeqr2_full_rank = rocsolver_zgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqr2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zgeqr2_rank_0 = rocsolver_zgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqr2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgeqr2_rank_1 = rocsolver_zgeqr2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqr2_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqr2_batched_full_rank = rocsolver_sgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqr2_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqr2_batched_rank_0 = rocsolver_sgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqr2_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqr2_batched_rank_1 = rocsolver_sgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqr2_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqr2_batched_full_rank = rocsolver_dgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqr2_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqr2_batched_rank_0 = rocsolver_dgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqr2_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqr2_batched_rank_1 = rocsolver_dgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqr2_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqr2_batched_full_rank = rocsolver_cgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgeqr2_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqr2_batched_rank_0 = rocsolver_cgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgeqr2_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqr2_batched_rank_1 = rocsolver_cgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqr2_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqr2_batched_full_rank = rocsolver_zgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqr2_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqr2_batched_rank_0 = rocsolver_zgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqr2_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqr2_batched_rank_1 = rocsolver_zgeqr2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_sgeqr2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqr2_strided_batched_full_rank = rocsolver_sgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqr2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqr2_strided_batched_rank_0 = rocsolver_sgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqr2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqr2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqr2_strided_batched_rank_1 = rocsolver_sgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqr2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqr2_strided_batched_full_rank = rocsolver_dgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqr2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqr2_strided_batched_rank_0 = rocsolver_dgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqr2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqr2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqr2_strided_batched_rank_1 = rocsolver_dgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqr2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqr2_strided_batched_full_rank = rocsolver_cgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqr2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqr2_strided_batched_rank_0 = rocsolver_cgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqr2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqr2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqr2_strided_batched_rank_1 = rocsolver_cgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqr2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqr2_strided_batched_full_rank = rocsolver_zgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqr2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqr2_strided_batched_rank_0 = rocsolver_zgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqr2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqr2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqr2_strided_batched_rank_1 = rocsolver_zgeqr2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeql2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgeql2_full_rank = rocsolver_sgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeql2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sgeql2_rank_0 = rocsolver_sgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeql2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgeql2_rank_1 = rocsolver_sgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeql2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgeql2_full_rank = rocsolver_dgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeql2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dgeql2_rank_0 = rocsolver_dgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeql2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgeql2_rank_1 = rocsolver_dgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeql2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgeql2_full_rank = rocsolver_cgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeql2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cgeql2_rank_0 = rocsolver_cgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeql2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgeql2_rank_1 = rocsolver_cgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeql2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgeql2_full_rank = rocsolver_zgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeql2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zgeql2_rank_0 = rocsolver_zgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeql2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgeql2_rank_1 = rocsolver_zgeql2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeql2_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeql2_batched_full_rank = rocsolver_sgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeql2_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeql2_batched_rank_0 = rocsolver_sgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeql2_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeql2_batched_rank_1 = rocsolver_sgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeql2_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeql2_batched_full_rank = rocsolver_dgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeql2_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeql2_batched_rank_0 = rocsolver_dgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeql2_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeql2_batched_rank_1 = rocsolver_dgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeql2_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeql2_batched_full_rank = rocsolver_cgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgeql2_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeql2_batched_rank_0 = rocsolver_cgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgeql2_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeql2_batched_rank_1 = rocsolver_cgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeql2_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeql2_batched_full_rank = rocsolver_zgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeql2_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeql2_batched_rank_0 = rocsolver_zgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeql2_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeql2_batched_rank_1 = rocsolver_zgeql2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_sgeql2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeql2_strided_batched_full_rank = rocsolver_sgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeql2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeql2_strided_batched_rank_0 = rocsolver_sgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeql2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeql2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeql2_strided_batched_rank_1 = rocsolver_sgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeql2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeql2_strided_batched_full_rank = rocsolver_dgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeql2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeql2_strided_batched_rank_0 = rocsolver_dgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeql2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeql2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeql2_strided_batched_rank_1 = rocsolver_dgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeql2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeql2_strided_batched_full_rank = rocsolver_cgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeql2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeql2_strided_batched_rank_0 = rocsolver_cgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeql2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeql2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeql2_strided_batched_rank_1 = rocsolver_cgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeql2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeql2_strided_batched_full_rank = rocsolver_zgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeql2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeql2_strided_batched_rank_0 = rocsolver_zgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeql2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeql2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeql2_strided_batched_rank_1 = rocsolver_zgeql2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelq2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgelq2_full_rank = rocsolver_sgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgelq2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sgelq2_rank_0 = rocsolver_sgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgelq2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgelq2_rank_1 = rocsolver_sgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgelq2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgelq2_full_rank = rocsolver_dgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgelq2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dgelq2_rank_0 = rocsolver_dgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgelq2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgelq2_rank_1 = rocsolver_dgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgelq2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgelq2_full_rank = rocsolver_cgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgelq2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cgelq2_rank_0 = rocsolver_cgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgelq2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgelq2_rank_1 = rocsolver_cgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgelq2_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgelq2_full_rank = rocsolver_zgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgelq2_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zgelq2_rank_0 = rocsolver_zgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgelq2_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgelq2_rank_1 = rocsolver_zgelq2_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgelq2_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelq2_batched_full_rank = rocsolver_sgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelq2_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelq2_batched_rank_0 = rocsolver_sgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelq2_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelq2_batched_rank_1 = rocsolver_sgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelq2_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelq2_batched_full_rank = rocsolver_dgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelq2_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelq2_batched_rank_0 = rocsolver_dgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelq2_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelq2_batched_rank_1 = rocsolver_dgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgelq2_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelq2_batched_full_rank = rocsolver_cgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgelq2_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelq2_batched_rank_0 = rocsolver_cgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgelq2_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelq2_batched_rank_1 = rocsolver_cgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgelq2_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelq2_batched_full_rank = rocsolver_zgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgelq2_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelq2_batched_rank_0 = rocsolver_zgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgelq2_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelq2_batched_rank_1 = rocsolver_zgelq2_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_sgelq2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelq2_strided_batched_full_rank = rocsolver_sgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelq2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelq2_strided_batched_rank_0 = rocsolver_sgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelq2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelq2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelq2_strided_batched_rank_1 = rocsolver_sgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelq2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelq2_strided_batched_full_rank = rocsolver_dgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelq2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelq2_strided_batched_rank_0 = rocsolver_dgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelq2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelq2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelq2_strided_batched_rank_1 = rocsolver_dgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgelq2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelq2_strided_batched_full_rank = rocsolver_cgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgelq2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelq2_strided_batched_rank_0 = rocsolver_cgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgelq2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelq2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelq2_strided_batched_rank_1 = rocsolver_cgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgelq2_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelq2_strided_batched_full_rank = rocsolver_zgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgelq2_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelq2_strided_batched_rank_0 = rocsolver_zgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgelq2_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelq2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelq2_strided_batched_rank_1 = rocsolver_zgelq2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqrf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgeqrf_full_rank = rocsolver_sgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqrf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sgeqrf_rank_0 = rocsolver_sgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqrf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgeqrf_rank_1 = rocsolver_sgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqrf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgeqrf_full_rank = rocsolver_dgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqrf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dgeqrf_rank_0 = rocsolver_dgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqrf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgeqrf_rank_1 = rocsolver_dgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqrf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgeqrf_full_rank = rocsolver_cgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqrf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cgeqrf_rank_0 = rocsolver_cgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqrf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgeqrf_rank_1 = rocsolver_cgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqrf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgeqrf_full_rank = rocsolver_zgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqrf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zgeqrf_rank_0 = rocsolver_zgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqrf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgeqrf_rank_1 = rocsolver_zgeqrf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqrf_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqrf_batched_full_rank = rocsolver_sgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqrf_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqrf_batched_rank_0 = rocsolver_sgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqrf_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqrf_batched_rank_1 = rocsolver_sgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqrf_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqrf_batched_full_rank = rocsolver_dgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqrf_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqrf_batched_rank_0 = rocsolver_dgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqrf_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqrf_batched_rank_1 = rocsolver_dgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqrf_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqrf_batched_full_rank = rocsolver_cgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgeqrf_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqrf_batched_rank_0 = rocsolver_cgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgeqrf_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqrf_batched_rank_1 = rocsolver_cgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqrf_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqrf_batched_full_rank = rocsolver_zgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqrf_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqrf_batched_rank_0 = rocsolver_zgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqrf_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqrf_batched_rank_1 = rocsolver_zgeqrf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_sgeqrf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqrf_strided_batched_full_rank = rocsolver_sgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqrf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqrf_strided_batched_rank_0 = rocsolver_sgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqrf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqrf_strided_batched_rank_1 = rocsolver_sgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqrf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqrf_strided_batched_full_rank = rocsolver_dgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqrf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqrf_strided_batched_rank_0 = rocsolver_dgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqrf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqrf_strided_batched_rank_1 = rocsolver_dgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqrf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqrf_strided_batched_full_rank = rocsolver_cgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqrf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqrf_strided_batched_rank_0 = rocsolver_cgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqrf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqrf_strided_batched_rank_1 = rocsolver_cgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqrf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqrf_strided_batched_full_rank = rocsolver_zgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqrf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqrf_strided_batched_rank_0 = rocsolver_zgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqrf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqrf_strided_batched_rank_1 = rocsolver_zgeqrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqlf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgeqlf_full_rank = rocsolver_sgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqlf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sgeqlf_rank_0 = rocsolver_sgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqlf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgeqlf_rank_1 = rocsolver_sgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqlf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgeqlf_full_rank = rocsolver_dgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqlf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dgeqlf_rank_0 = rocsolver_dgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgeqlf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgeqlf_rank_1 = rocsolver_dgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqlf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgeqlf_full_rank = rocsolver_cgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqlf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cgeqlf_rank_0 = rocsolver_cgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgeqlf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgeqlf_rank_1 = rocsolver_cgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqlf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgeqlf_full_rank = rocsolver_zgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqlf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zgeqlf_rank_0 = rocsolver_zgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgeqlf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgeqlf_rank_1 = rocsolver_zgeqlf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgeqlf_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqlf_batched_full_rank = rocsolver_sgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqlf_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqlf_batched_rank_0 = rocsolver_sgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqlf_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqlf_batched_rank_1 = rocsolver_sgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqlf_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqlf_batched_full_rank = rocsolver_dgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqlf_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqlf_batched_rank_0 = rocsolver_dgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqlf_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqlf_batched_rank_1 = rocsolver_dgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqlf_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqlf_batched_full_rank = rocsolver_cgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgeqlf_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqlf_batched_rank_0 = rocsolver_cgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgeqlf_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqlf_batched_rank_1 = rocsolver_cgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqlf_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqlf_batched_full_rank = rocsolver_zgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqlf_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqlf_batched_rank_0 = rocsolver_zgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgeqlf_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqlf_batched_rank_1 = rocsolver_zgeqlf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_sgeqlf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqlf_strided_batched_full_rank = rocsolver_sgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqlf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqlf_strided_batched_rank_0 = rocsolver_sgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgeqlf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgeqlf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgeqlf_strided_batched_rank_1 = rocsolver_sgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqlf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqlf_strided_batched_full_rank = rocsolver_dgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqlf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqlf_strided_batched_rank_0 = rocsolver_dgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgeqlf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgeqlf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgeqlf_strided_batched_rank_1 = rocsolver_dgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqlf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqlf_strided_batched_full_rank = rocsolver_cgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqlf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqlf_strided_batched_rank_0 = rocsolver_cgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgeqlf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgeqlf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgeqlf_strided_batched_rank_1 = rocsolver_cgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqlf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqlf_strided_batched_full_rank = rocsolver_zgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqlf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqlf_strided_batched_rank_0 = rocsolver_zgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgeqlf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgeqlf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgeqlf_strided_batched_rank_1 = rocsolver_zgeqlf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelqf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgelqf_full_rank = rocsolver_sgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgelqf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      !
      rocsolver_sgelqf_rank_0 = rocsolver_sgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgelqf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      !
      rocsolver_sgelqf_rank_1 = rocsolver_sgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgelqf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgelqf_full_rank = rocsolver_dgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgelqf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      !
      rocsolver_dgelqf_rank_0 = rocsolver_dgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_dgelqf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      !
      rocsolver_dgelqf_rank_1 = rocsolver_dgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgelqf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgelqf_full_rank = rocsolver_cgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgelqf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      !
      rocsolver_cgelqf_rank_0 = rocsolver_cgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_cgelqf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      !
      rocsolver_cgelqf_rank_1 = rocsolver_cgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgelqf_full_rank(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgelqf_full_rank = rocsolver_zgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgelqf_rank_0(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      !
      rocsolver_zgelqf_rank_0 = rocsolver_zgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_zgelqf_rank_1(handle,m,n,A,lda,ipiv)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: m
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      !
      rocsolver_zgelqf_rank_1 = rocsolver_zgelqf_orig(handle,m,n,c_loc(A),lda,c_loc(ipiv))
    end function

    function rocsolver_sgelqf_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelqf_batched_full_rank = rocsolver_sgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelqf_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelqf_batched_rank_0 = rocsolver_sgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelqf_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelqf_batched_rank_1 = rocsolver_sgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelqf_batched_full_rank(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelqf_batched_full_rank = rocsolver_dgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelqf_batched_rank_0(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelqf_batched_rank_0 = rocsolver_dgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelqf_batched_rank_1(handle,n,A,lda,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelqf_batched_rank_1 = rocsolver_dgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgelqf_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelqf_batched_full_rank = rocsolver_cgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgelqf_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelqf_batched_rank_0 = rocsolver_cgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgelqf_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelqf_batched_rank_1 = rocsolver_cgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgelqf_batched_full_rank(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelqf_batched_full_rank = rocsolver_zgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgelqf_batched_rank_0(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelqf_batched_rank_0 = rocsolver_zgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_zgelqf_batched_rank_1(handle,n,A,lda,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelqf_batched_rank_1 = rocsolver_zgelqf_batched_orig(handle,n,c_loc(A),lda,c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_sgelqf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelqf_strided_batched_full_rank = rocsolver_sgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelqf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelqf_strided_batched_rank_0 = rocsolver_sgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgelqf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgelqf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_sgelqf_strided_batched_rank_1 = rocsolver_sgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelqf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelqf_strided_batched_full_rank = rocsolver_dgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelqf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelqf_strided_batched_rank_0 = rocsolver_dgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_dgelqf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgelqf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_dgelqf_strided_batched_rank_1 = rocsolver_dgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgelqf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelqf_strided_batched_full_rank = rocsolver_cgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgelqf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelqf_strided_batched_rank_0 = rocsolver_cgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_cgelqf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgelqf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_float_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_cgelqf_strided_batched_rank_1 = rocsolver_cgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgelqf_strided_batched_full_rank(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelqf_strided_batched_full_rank = rocsolver_zgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgelqf_strided_batched_rank_0(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelqf_strided_batched_rank_0 = rocsolver_zgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_zgelqf_strided_batched_rank_1(handle,n,A,lda,strideA,ipiv,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgelqf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      complex(c_double_complex),target,dimension(:) :: ipiv
      integer(c_int),value :: batch_count
      !
      rocsolver_zgelqf_strided_batched_rank_1 = rocsolver_zgelqf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(ipiv),batch_count)
    end function

    function rocsolver_sgebd2_full_rank(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      real(c_float),target,dimension(:) :: tauq
      real(c_float),target,dimension(:) :: taup
      !
      rocsolver_sgebd2_full_rank = rocsolver_sgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_sgebd2_rank_0(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: D
      real(c_float),target :: E
      real(c_float),target :: tauq
      real(c_float),target :: taup
      !
      rocsolver_sgebd2_rank_0 = rocsolver_sgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_sgebd2_rank_1(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      real(c_float),target,dimension(:) :: tauq
      real(c_float),target,dimension(:) :: taup
      !
      rocsolver_sgebd2_rank_1 = rocsolver_sgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_dgebd2_full_rank(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      real(c_double),target,dimension(:) :: tauq
      real(c_double),target,dimension(:) :: taup
      !
      rocsolver_dgebd2_full_rank = rocsolver_dgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_dgebd2_rank_0(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: D
      real(c_double),target :: E
      real(c_double),target :: tauq
      real(c_double),target :: taup
      !
      rocsolver_dgebd2_rank_0 = rocsolver_dgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_dgebd2_rank_1(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      real(c_double),target,dimension(:) :: tauq
      real(c_double),target,dimension(:) :: taup
      !
      rocsolver_dgebd2_rank_1 = rocsolver_dgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_cgebd2_full_rank(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      complex(c_float_complex),target,dimension(:) :: tauq
      complex(c_float_complex),target,dimension(:) :: taup
      !
      rocsolver_cgebd2_full_rank = rocsolver_cgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_cgebd2_rank_0(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: D
      real(c_float),target :: E
      complex(c_float_complex),target :: tauq
      complex(c_float_complex),target :: taup
      !
      rocsolver_cgebd2_rank_0 = rocsolver_cgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_cgebd2_rank_1(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      complex(c_float_complex),target,dimension(:) :: tauq
      complex(c_float_complex),target,dimension(:) :: taup
      !
      rocsolver_cgebd2_rank_1 = rocsolver_cgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_zgebd2_full_rank(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      complex(c_double_complex),target,dimension(:) :: tauq
      complex(c_double_complex),target,dimension(:) :: taup
      !
      rocsolver_zgebd2_full_rank = rocsolver_zgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_zgebd2_rank_0(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: D
      real(c_double),target :: E
      complex(c_double_complex),target :: tauq
      complex(c_double_complex),target :: taup
      !
      rocsolver_zgebd2_rank_0 = rocsolver_zgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_zgebd2_rank_1(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      complex(c_double_complex),target,dimension(:) :: tauq
      complex(c_double_complex),target,dimension(:) :: taup
      !
      rocsolver_zgebd2_rank_1 = rocsolver_zgebd2_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_sgebd2_batched_full_rank(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebd2_batched_full_rank = rocsolver_sgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebd2_batched_rank_0(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebd2_batched_rank_0 = rocsolver_sgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebd2_batched_rank_1(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebd2_batched_rank_1 = rocsolver_sgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebd2_batched_full_rank(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebd2_batched_full_rank = rocsolver_dgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebd2_batched_rank_0(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebd2_batched_rank_0 = rocsolver_dgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebd2_batched_rank_1(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebd2_batched_rank_1 = rocsolver_dgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_cgebd2_batched_full_rank(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target,dimension(:) :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebd2_batched_full_rank = rocsolver_cgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_cgebd2_batched_rank_0(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebd2_batched_rank_0 = rocsolver_cgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_cgebd2_batched_rank_1(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target,dimension(:) :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebd2_batched_rank_1 = rocsolver_cgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_zgebd2_batched_full_rank(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target,dimension(:) :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebd2_batched_full_rank = rocsolver_zgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_zgebd2_batched_rank_0(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebd2_batched_rank_0 = rocsolver_zgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_zgebd2_batched_rank_1(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target,dimension(:) :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebd2_batched_rank_1 = rocsolver_zgebd2_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_sgebd2_strided_batched_full_rank(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebd2_strided_batched_full_rank = rocsolver_sgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebd2_strided_batched_rank_0(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebd2_strided_batched_rank_0 = rocsolver_sgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebd2_strided_batched_rank_1(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebd2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebd2_strided_batched_rank_1 = rocsolver_sgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebd2_strided_batched_full_rank(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebd2_strided_batched_full_rank = rocsolver_dgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebd2_strided_batched_rank_0(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebd2_strided_batched_rank_0 = rocsolver_dgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebd2_strided_batched_rank_1(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebd2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebd2_strided_batched_rank_1 = rocsolver_dgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_cgebd2_strided_batched_full_rank(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebd2_strided_batched_full_rank = rocsolver_cgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_cgebd2_strided_batched_rank_0(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebd2_strided_batched_rank_0 = rocsolver_cgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_cgebd2_strided_batched_rank_1(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebd2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebd2_strided_batched_rank_1 = rocsolver_cgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_zgebd2_strided_batched_full_rank(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebd2_strided_batched_full_rank = rocsolver_zgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_zgebd2_strided_batched_rank_0(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebd2_strided_batched_rank_0 = rocsolver_zgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_zgebd2_strided_batched_rank_1(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebd2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebd2_strided_batched_rank_1 = rocsolver_zgebd2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebrd_full_rank(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      real(c_float),target,dimension(:) :: tauq
      real(c_float),target,dimension(:) :: taup
      !
      rocsolver_sgebrd_full_rank = rocsolver_sgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_sgebrd_rank_0(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: D
      real(c_float),target :: E
      real(c_float),target :: tauq
      real(c_float),target :: taup
      !
      rocsolver_sgebrd_rank_0 = rocsolver_sgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_sgebrd_rank_1(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      real(c_float),target,dimension(:) :: tauq
      real(c_float),target,dimension(:) :: taup
      !
      rocsolver_sgebrd_rank_1 = rocsolver_sgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_dgebrd_full_rank(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      real(c_double),target,dimension(:) :: tauq
      real(c_double),target,dimension(:) :: taup
      !
      rocsolver_dgebrd_full_rank = rocsolver_dgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_dgebrd_rank_0(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: D
      real(c_double),target :: E
      real(c_double),target :: tauq
      real(c_double),target :: taup
      !
      rocsolver_dgebrd_rank_0 = rocsolver_dgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_dgebrd_rank_1(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      real(c_double),target,dimension(:) :: tauq
      real(c_double),target,dimension(:) :: taup
      !
      rocsolver_dgebrd_rank_1 = rocsolver_dgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_cgebrd_full_rank(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      complex(c_float_complex),target,dimension(:) :: tauq
      complex(c_float_complex),target,dimension(:) :: taup
      !
      rocsolver_cgebrd_full_rank = rocsolver_cgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_cgebrd_rank_0(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: D
      real(c_float),target :: E
      complex(c_float_complex),target :: tauq
      complex(c_float_complex),target :: taup
      !
      rocsolver_cgebrd_rank_0 = rocsolver_cgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_cgebrd_rank_1(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      real(c_float),target,dimension(:) :: E
      complex(c_float_complex),target,dimension(:) :: tauq
      complex(c_float_complex),target,dimension(:) :: taup
      !
      rocsolver_cgebrd_rank_1 = rocsolver_cgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_zgebrd_full_rank(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      complex(c_double_complex),target,dimension(:) :: tauq
      complex(c_double_complex),target,dimension(:) :: taup
      !
      rocsolver_zgebrd_full_rank = rocsolver_zgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_zgebrd_rank_0(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: D
      real(c_double),target :: E
      complex(c_double_complex),target :: tauq
      complex(c_double_complex),target :: taup
      !
      rocsolver_zgebrd_rank_0 = rocsolver_zgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_zgebrd_rank_1(handle,n,A,lda,D,E,tauq,taup)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      real(c_double),target,dimension(:) :: E
      complex(c_double_complex),target,dimension(:) :: tauq
      complex(c_double_complex),target,dimension(:) :: taup
      !
      rocsolver_zgebrd_rank_1 = rocsolver_zgebrd_orig(handle,n,c_loc(A),lda,c_loc(D),c_loc(E),c_loc(tauq),c_loc(taup))
    end function

    function rocsolver_sgebrd_batched_full_rank(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebrd_batched_full_rank = rocsolver_sgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebrd_batched_rank_0(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebrd_batched_rank_0 = rocsolver_sgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebrd_batched_rank_1(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebrd_batched_rank_1 = rocsolver_sgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebrd_batched_full_rank(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebrd_batched_full_rank = rocsolver_dgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebrd_batched_rank_0(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebrd_batched_rank_0 = rocsolver_dgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebrd_batched_rank_1(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebrd_batched_rank_1 = rocsolver_dgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_cgebrd_batched_full_rank(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target,dimension(:) :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebrd_batched_full_rank = rocsolver_cgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_cgebrd_batched_rank_0(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebrd_batched_rank_0 = rocsolver_cgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_cgebrd_batched_rank_1(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target,dimension(:) :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebrd_batched_rank_1 = rocsolver_cgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_zgebrd_batched_full_rank(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target,dimension(:) :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebrd_batched_full_rank = rocsolver_zgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_zgebrd_batched_rank_0(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebrd_batched_rank_0 = rocsolver_zgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_zgebrd_batched_rank_1(handle,n,A,lda,D,strideD,E,strideE,tauq,strideQ,taup,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target,dimension(:) :: taup
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebrd_batched_rank_1 = rocsolver_zgebrd_batched_orig(handle,n,c_loc(A),lda,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),strideP,batch_count)
    end function

    function rocsolver_sgebrd_strided_batched_full_rank(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebrd_strided_batched_full_rank = rocsolver_sgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebrd_strided_batched_rank_0(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebrd_strided_batched_rank_0 = rocsolver_sgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgebrd_strided_batched_rank_1(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgebrd_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_float),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_float),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_sgebrd_strided_batched_rank_1 = rocsolver_sgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebrd_strided_batched_full_rank(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebrd_strided_batched_full_rank = rocsolver_dgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebrd_strided_batched_rank_0(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebrd_strided_batched_rank_0 = rocsolver_dgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_dgebrd_strided_batched_rank_1(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgebrd_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      real(c_double),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      real(c_double),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_dgebrd_strided_batched_rank_1 = rocsolver_dgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_cgebrd_strided_batched_full_rank(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebrd_strided_batched_full_rank = rocsolver_cgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_cgebrd_strided_batched_rank_0(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebrd_strided_batched_rank_0 = rocsolver_cgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_cgebrd_strided_batched_rank_1(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgebrd_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_float_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_float_complex),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_cgebrd_strided_batched_rank_1 = rocsolver_cgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_zgebrd_strided_batched_full_rank(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebrd_strided_batched_full_rank = rocsolver_zgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_zgebrd_strided_batched_rank_0(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebrd_strided_batched_rank_0 = rocsolver_zgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_zgebrd_strided_batched_rank_1(handle,n,A,lda,strideA,D,strideD,E,strideE,tauq,strideQ,taup,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgebrd_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: D
      integer(c_int64_t),value :: strideD
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      complex(c_double_complex),target,dimension(:) :: tauq
      integer(c_int64_t),value :: strideQ
      complex(c_double_complex),target,dimension(:) :: taup
      integer(c_int),value :: batch_count
      !
      rocsolver_zgebrd_strided_batched_rank_1 = rocsolver_zgebrd_strided_batched_orig(handle,n,c_loc(A),lda,strideA,c_loc(D),strideD,c_loc(E),strideE,c_loc(tauq),strideQ,c_loc(taup),batch_count)
    end function

    function rocsolver_sgetrs_batched_full_rank(handle,n,lda,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrs_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      real(c_float),target,dimension(:,:,:) :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrs_batched_full_rank = rocsolver_sgetrs_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_sgetrs_batched_rank_0(handle,n,lda,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrs_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      integer(c_int64_t),value :: strideP
      real(c_float),target :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrs_batched_rank_0 = rocsolver_sgetrs_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_sgetrs_batched_rank_1(handle,n,lda,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrs_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      real(c_float),target,dimension(:) :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrs_batched_rank_1 = rocsolver_sgetrs_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_dgetrs_batched_full_rank(handle,n,lda,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrs_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      real(c_double),target,dimension(:,:,:) :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrs_batched_full_rank = rocsolver_dgetrs_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_dgetrs_batched_rank_0(handle,n,lda,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrs_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      integer(c_int64_t),value :: strideP
      real(c_double),target :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrs_batched_rank_0 = rocsolver_dgetrs_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_dgetrs_batched_rank_1(handle,n,lda,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrs_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      real(c_double),target,dimension(:) :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrs_batched_rank_1 = rocsolver_dgetrs_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_cgetrs_batched_full_rank(handle,n,nrhs,A,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nrhs
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_float_complex),target,dimension(:,:,:) :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrs_batched_full_rank = rocsolver_cgetrs_batched_orig(handle,n,nrhs,c_loc(A),c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_cgetrs_batched_rank_0(handle,n,nrhs,A,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nrhs
      complex(c_float_complex),target :: A
      integer(c_int),target :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_float_complex),target :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrs_batched_rank_0 = rocsolver_cgetrs_batched_orig(handle,n,nrhs,c_loc(A),c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_cgetrs_batched_rank_1(handle,n,nrhs,A,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nrhs
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_float_complex),target,dimension(:) :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrs_batched_rank_1 = rocsolver_cgetrs_batched_orig(handle,n,nrhs,c_loc(A),c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_zgetrs_batched_full_rank(handle,n,nrhs,A,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nrhs
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_double_complex),target,dimension(:,:,:) :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrs_batched_full_rank = rocsolver_zgetrs_batched_orig(handle,n,nrhs,c_loc(A),c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_zgetrs_batched_rank_0(handle,n,nrhs,A,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nrhs
      complex(c_double_complex),target :: A
      integer(c_int),target :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_double_complex),target :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrs_batched_rank_0 = rocsolver_zgetrs_batched_orig(handle,n,nrhs,c_loc(A),c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_zgetrs_batched_rank_1(handle,n,nrhs,A,ipiv,strideP,B,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: nrhs
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_double_complex),target,dimension(:) :: B
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrs_batched_rank_1 = rocsolver_zgetrs_batched_orig(handle,n,nrhs,c_loc(A),c_loc(ipiv),strideP,c_loc(B),batch_count)
    end function

    function rocsolver_sgetrs_strided_batched_rank_0(handle,n,lda,ipiv,ldb,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrs_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      integer(c_int),value :: ldb
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrs_strided_batched_rank_0 = rocsolver_sgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),ldb,batch_count)
    end function

    function rocsolver_sgetrs_strided_batched_rank_1(handle,n,lda,ipiv,ldb,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetrs_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int),value :: ldb
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetrs_strided_batched_rank_1 = rocsolver_sgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),ldb,batch_count)
    end function

    function rocsolver_dgetrs_strided_batched_rank_0(handle,n,lda,ipiv,ldb,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrs_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      integer(c_int),value :: ldb
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrs_strided_batched_rank_0 = rocsolver_dgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),ldb,batch_count)
    end function

    function rocsolver_dgetrs_strided_batched_rank_1(handle,n,lda,ipiv,ldb,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetrs_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int),value :: ldb
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetrs_strided_batched_rank_1 = rocsolver_dgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),ldb,batch_count)
    end function

    function rocsolver_cgetrs_strided_batched_full_rank(handle,n,lda,ipiv,strideP,B,ldb,strideB,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_float_complex),target,dimension(:,:) :: B
      integer(c_int),value :: ldb
      integer(c_int64_t),value :: strideB
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrs_strided_batched_full_rank = rocsolver_cgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),ldb,strideB,batch_count)
    end function

    function rocsolver_cgetrs_strided_batched_rank_0(handle,n,lda,ipiv,strideP,B,ldb,strideB,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_float_complex),target :: B
      integer(c_int),value :: ldb
      integer(c_int64_t),value :: strideB
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrs_strided_batched_rank_0 = rocsolver_cgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),ldb,strideB,batch_count)
    end function

    function rocsolver_cgetrs_strided_batched_rank_1(handle,n,lda,ipiv,strideP,B,ldb,strideB,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetrs_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_float_complex),target,dimension(:) :: B
      integer(c_int),value :: ldb
      integer(c_int64_t),value :: strideB
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetrs_strided_batched_rank_1 = rocsolver_cgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),ldb,strideB,batch_count)
    end function

    function rocsolver_zgetrs_strided_batched_full_rank(handle,n,lda,ipiv,strideP,B,ldb,strideB,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_double_complex),target,dimension(:,:) :: B
      integer(c_int),value :: ldb
      integer(c_int64_t),value :: strideB
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrs_strided_batched_full_rank = rocsolver_zgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),ldb,strideB,batch_count)
    end function

    function rocsolver_zgetrs_strided_batched_rank_0(handle,n,lda,ipiv,strideP,B,ldb,strideB,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_double_complex),target :: B
      integer(c_int),value :: ldb
      integer(c_int64_t),value :: strideB
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrs_strided_batched_rank_0 = rocsolver_zgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),ldb,strideB,batch_count)
    end function

    function rocsolver_zgetrs_strided_batched_rank_1(handle,n,lda,ipiv,strideP,B,ldb,strideB,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetrs_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      complex(c_double_complex),target,dimension(:) :: B
      integer(c_int),value :: ldb
      integer(c_int64_t),value :: strideB
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetrs_strided_batched_rank_1 = rocsolver_zgetrs_strided_batched_orig(handle,n,lda,c_loc(ipiv),strideP,c_loc(B),ldb,strideB,batch_count)
    end function

    function rocsolver_sgetri_full_rank(handle,n,A,lda,ipiv,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetri_full_rank = rocsolver_sgetri_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo)
    end function

    function rocsolver_sgetri_rank_0(handle,n,A,lda,ipiv,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetri_rank_0 = rocsolver_sgetri_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo)
    end function

    function rocsolver_sgetri_rank_1(handle,n,A,lda,ipiv,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgetri_rank_1 = rocsolver_sgetri_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo)
    end function

    function rocsolver_dgetri_full_rank(handle,n,A,lda,ipiv,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetri_full_rank = rocsolver_dgetri_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo)
    end function

    function rocsolver_dgetri_rank_0(handle,n,A,lda,ipiv,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetri_rank_0 = rocsolver_dgetri_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo)
    end function

    function rocsolver_dgetri_rank_1(handle,n,A,lda,ipiv,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgetri_rank_1 = rocsolver_dgetri_orig(handle,n,c_loc(A),lda,c_loc(ipiv),myInfo)
    end function

    function rocsolver_cgetri_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetri_full_rank = rocsolver_cgetri_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetri_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetri_rank_0 = rocsolver_cgetri_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cgetri_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgetri_rank_1 = rocsolver_cgetri_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetri_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetri_full_rank = rocsolver_zgetri_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetri_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetri_rank_0 = rocsolver_zgetri_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zgetri_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgetri_rank_1 = rocsolver_zgetri_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_sgetri_batched_full_rank(handle,n,A,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetri_batched_full_rank = rocsolver_sgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_sgetri_batched_rank_0(handle,n,A,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetri_batched_rank_0 = rocsolver_sgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_sgetri_batched_rank_1(handle,n,A,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetri_batched_rank_1 = rocsolver_sgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_dgetri_batched_full_rank(handle,n,A,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetri_batched_full_rank = rocsolver_dgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_dgetri_batched_rank_0(handle,n,A,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),target :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetri_batched_rank_0 = rocsolver_dgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_dgetri_batched_rank_1(handle,n,A,ipiv,strideP,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      integer(c_int64_t),value :: strideP
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetri_batched_rank_1 = rocsolver_dgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),strideP,batch_count)
    end function

    function rocsolver_cgetri_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetri_batched_full_rank = rocsolver_cgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetri_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetri_batched_rank_0 = rocsolver_cgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetri_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetri_batched_rank_1 = rocsolver_cgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetri_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetri_batched_full_rank = rocsolver_zgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetri_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetri_batched_rank_0 = rocsolver_zgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetri_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetri_batched_rank_1 = rocsolver_zgetri_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetri_strided_batched_rank_0(handle,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: lda
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetri_strided_batched_rank_0 = rocsolver_sgetri_strided_batched_orig(handle,lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_sgetri_strided_batched_rank_1(handle,lda,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgetri_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: lda
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgetri_strided_batched_rank_1 = rocsolver_sgetri_strided_batched_orig(handle,lda,c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetri_strided_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetri_strided_batched_full_rank = rocsolver_dgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetri_strided_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetri_strided_batched_rank_0 = rocsolver_dgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_dgetri_strided_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgetri_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgetri_strided_batched_rank_1 = rocsolver_dgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetri_strided_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetri_strided_batched_full_rank = rocsolver_cgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetri_strided_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetri_strided_batched_rank_0 = rocsolver_cgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_cgetri_strided_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgetri_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgetri_strided_batched_rank_1 = rocsolver_cgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetri_strided_batched_full_rank(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetri_strided_batched_full_rank = rocsolver_zgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetri_strided_batched_rank_0(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),target :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetri_strided_batched_rank_0 = rocsolver_zgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_zgetri_strided_batched_rank_1(handle,n,A,ipiv,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgetri_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),target,dimension(:) :: ipiv
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgetri_strided_batched_rank_1 = rocsolver_zgetri_strided_batched_orig(handle,n,c_loc(A),c_loc(ipiv),myInfo,batch_count)
    end function

    function rocsolver_spotf2_full_rank(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_spotf2_full_rank = rocsolver_spotf2_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_spotf2_rank_0(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_spotf2_rank_0 = rocsolver_spotf2_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_spotf2_rank_1(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_spotf2_rank_1 = rocsolver_spotf2_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_dpotf2_full_rank(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_dpotf2_full_rank = rocsolver_dpotf2_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_dpotf2_rank_0(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_dpotf2_rank_0 = rocsolver_dpotf2_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_dpotf2_rank_1(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_dpotf2_rank_1 = rocsolver_dpotf2_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_cpotf2_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cpotf2_full_rank = rocsolver_cpotf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cpotf2_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cpotf2_rank_0 = rocsolver_cpotf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cpotf2_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cpotf2_rank_1 = rocsolver_cpotf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zpotf2_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zpotf2_full_rank = rocsolver_zpotf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zpotf2_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zpotf2_rank_0 = rocsolver_zpotf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zpotf2_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zpotf2_rank_1 = rocsolver_zpotf2_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_spotf2_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_spotf2_batched_full_rank = rocsolver_spotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_spotf2_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_spotf2_batched_rank_0 = rocsolver_spotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_spotf2_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_spotf2_batched_rank_1 = rocsolver_spotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dpotf2_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotf2_batched_full_rank = rocsolver_dpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dpotf2_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotf2_batched_rank_0 = rocsolver_dpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dpotf2_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotf2_batched_rank_1 = rocsolver_dpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cpotf2_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotf2_batched_full_rank = rocsolver_cpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cpotf2_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotf2_batched_rank_0 = rocsolver_cpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cpotf2_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotf2_batched_rank_1 = rocsolver_cpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zpotf2_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotf2_batched_full_rank = rocsolver_zpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zpotf2_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotf2_batched_rank_0 = rocsolver_zpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zpotf2_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotf2_batched_rank_1 = rocsolver_zpotf2_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_spotf2_strided_batched_full_rank(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_spotf2_strided_batched_full_rank = rocsolver_spotf2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_spotf2_strided_batched_rank_0(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_spotf2_strided_batched_rank_0 = rocsolver_spotf2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_spotf2_strided_batched_rank_1(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotf2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_spotf2_strided_batched_rank_1 = rocsolver_spotf2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_dpotf2_strided_batched_full_rank(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotf2_strided_batched_full_rank = rocsolver_dpotf2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_dpotf2_strided_batched_rank_0(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotf2_strided_batched_rank_0 = rocsolver_dpotf2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_dpotf2_strided_batched_rank_1(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotf2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotf2_strided_batched_rank_1 = rocsolver_dpotf2_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_cpotf2_strided_batched_full_rank(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotf2_strided_batched_full_rank = rocsolver_cpotf2_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_cpotf2_strided_batched_rank_0(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotf2_strided_batched_rank_0 = rocsolver_cpotf2_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_cpotf2_strided_batched_rank_1(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotf2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotf2_strided_batched_rank_1 = rocsolver_cpotf2_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zpotf2_strided_batched_full_rank(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotf2_strided_batched_full_rank = rocsolver_zpotf2_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zpotf2_strided_batched_rank_0(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotf2_strided_batched_rank_0 = rocsolver_zpotf2_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zpotf2_strided_batched_rank_1(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotf2_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotf2_strided_batched_rank_1 = rocsolver_zpotf2_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_spotrf_full_rank(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_spotrf_full_rank = rocsolver_spotrf_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_spotrf_rank_0(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_spotrf_rank_0 = rocsolver_spotrf_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_spotrf_rank_1(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_spotrf_rank_1 = rocsolver_spotrf_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_dpotrf_full_rank(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_dpotrf_full_rank = rocsolver_dpotrf_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_dpotrf_rank_0(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_dpotrf_rank_0 = rocsolver_dpotrf_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_dpotrf_rank_1(handle,uplo,n,A,lda,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_fill_upper)),value :: uplo
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      !
      rocsolver_dpotrf_rank_1 = rocsolver_dpotrf_orig(handle,uplo,n,c_loc(A),lda,myInfo)
    end function

    function rocsolver_cpotrf_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cpotrf_full_rank = rocsolver_cpotrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cpotrf_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cpotrf_rank_0 = rocsolver_cpotrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_cpotrf_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_cpotrf_rank_1 = rocsolver_cpotrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zpotrf_full_rank(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zpotrf_full_rank = rocsolver_zpotrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zpotrf_rank_0(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zpotrf_rank_0 = rocsolver_zpotrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_zpotrf_rank_1(handle,n,A,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      !
      rocsolver_zpotrf_rank_1 = rocsolver_zpotrf_orig(handle,n,c_loc(A),myInfo)
    end function

    function rocsolver_spotrf_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_spotrf_batched_full_rank = rocsolver_spotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_spotrf_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_spotrf_batched_rank_0 = rocsolver_spotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_spotrf_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_spotrf_batched_rank_1 = rocsolver_spotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dpotrf_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotrf_batched_full_rank = rocsolver_dpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dpotrf_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotrf_batched_rank_0 = rocsolver_dpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_dpotrf_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotrf_batched_rank_1 = rocsolver_dpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cpotrf_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotrf_batched_full_rank = rocsolver_cpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cpotrf_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotrf_batched_rank_0 = rocsolver_cpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_cpotrf_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotrf_batched_rank_1 = rocsolver_cpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zpotrf_batched_full_rank(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotrf_batched_full_rank = rocsolver_zpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zpotrf_batched_rank_0(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotrf_batched_rank_0 = rocsolver_zpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_zpotrf_batched_rank_1(handle,n,A,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotrf_batched_rank_1 = rocsolver_zpotrf_batched_orig(handle,n,c_loc(A),myInfo,batch_count)
    end function

    function rocsolver_spotrf_strided_batched_full_rank(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_spotrf_strided_batched_full_rank = rocsolver_spotrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_spotrf_strided_batched_rank_0(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_spotrf_strided_batched_rank_0 = rocsolver_spotrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_spotrf_strided_batched_rank_1(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_spotrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_spotrf_strided_batched_rank_1 = rocsolver_spotrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_dpotrf_strided_batched_full_rank(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotrf_strided_batched_full_rank = rocsolver_dpotrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_dpotrf_strided_batched_rank_0(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotrf_strided_batched_rank_0 = rocsolver_dpotrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_dpotrf_strided_batched_rank_1(handle,n,A,lda,strideA,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dpotrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      integer(c_int),value :: batch_count
      !
      rocsolver_dpotrf_strided_batched_rank_1 = rocsolver_dpotrf_strided_batched_orig(handle,n,c_loc(A),lda,strideA,batch_count)
    end function

    function rocsolver_cpotrf_strided_batched_full_rank(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotrf_strided_batched_full_rank = rocsolver_cpotrf_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_cpotrf_strided_batched_rank_0(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotrf_strided_batched_rank_0 = rocsolver_cpotrf_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_cpotrf_strided_batched_rank_1(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cpotrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cpotrf_strided_batched_rank_1 = rocsolver_cpotrf_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zpotrf_strided_batched_full_rank(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotrf_strided_batched_full_rank = rocsolver_zpotrf_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zpotrf_strided_batched_rank_0(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotrf_strided_batched_rank_0 = rocsolver_zpotrf_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_zpotrf_strided_batched_rank_1(handle,n,A,lda,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zpotrf_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zpotrf_strided_batched_rank_1 = rocsolver_zpotrf_strided_batched_orig(handle,n,c_loc(A),lda,myInfo,batch_count)
    end function

    function rocsolver_sgesvd_full_rank(handle,left_svect,n,A,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: ldu
      real(c_float),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      real(c_float),target,dimension(:) :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgesvd_full_rank = rocsolver_sgesvd_orig(handle,left_svect,n,c_loc(A),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_sgesvd_rank_0(handle,left_svect,n,A,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: ldu
      real(c_float),target :: V
      integer(c_int),value :: ldv
      real(c_float),target :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgesvd_rank_0 = rocsolver_sgesvd_orig(handle,left_svect,n,c_loc(A),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_sgesvd_rank_1(handle,left_svect,n,A,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: ldu
      real(c_float),target,dimension(:) :: V
      integer(c_int),value :: ldv
      real(c_float),target,dimension(:) :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_sgesvd_rank_1 = rocsolver_sgesvd_orig(handle,left_svect,n,c_loc(A),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_dgesvd_full_rank(handle,left_svect,n,A,lda,S,U,ldv,E,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: S
      real(c_double),target,dimension(:,:) :: U
      integer(c_int),value :: ldv
      real(c_double),target,dimension(:) :: E
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgesvd_full_rank = rocsolver_dgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldv,c_loc(E),myInfo)
    end function

    function rocsolver_dgesvd_rank_0(handle,left_svect,n,A,lda,S,U,ldv,E,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: S
      real(c_double),target :: U
      integer(c_int),value :: ldv
      real(c_double),target :: E
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgesvd_rank_0 = rocsolver_dgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldv,c_loc(E),myInfo)
    end function

    function rocsolver_dgesvd_rank_1(handle,left_svect,n,A,lda,S,U,ldv,E,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: S
      real(c_double),target,dimension(:) :: U
      integer(c_int),value :: ldv
      real(c_double),target,dimension(:) :: E
      type(c_ptr),value :: myInfo
      !
      rocsolver_dgesvd_rank_1 = rocsolver_dgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldv,c_loc(E),myInfo)
    end function

    function rocsolver_cgesvd_full_rank(handle,left_svect,n,A,lda,S,U,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: S
      complex(c_float_complex),target,dimension(:,:) :: U
      integer(c_int),value :: ldu
      complex(c_float_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      real(c_float),target,dimension(:) :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgesvd_full_rank = rocsolver_cgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_cgesvd_rank_0(handle,left_svect,n,A,lda,S,U,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: S
      complex(c_float_complex),target :: U
      integer(c_int),value :: ldu
      complex(c_float_complex),target :: V
      integer(c_int),value :: ldv
      real(c_float),target :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgesvd_rank_0 = rocsolver_cgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_cgesvd_rank_1(handle,left_svect,n,A,lda,S,U,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: S
      complex(c_float_complex),target,dimension(:) :: U
      integer(c_int),value :: ldu
      complex(c_float_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      real(c_float),target,dimension(:) :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_cgesvd_rank_1 = rocsolver_cgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_zgesvd_full_rank(handle,left_svect,n,A,lda,S,U,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: S
      complex(c_double_complex),target,dimension(:,:) :: U
      integer(c_int),value :: ldu
      complex(c_double_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      real(c_double),target,dimension(:) :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgesvd_full_rank = rocsolver_zgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_zgesvd_rank_0(handle,left_svect,n,A,lda,S,U,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: S
      complex(c_double_complex),target :: U
      integer(c_int),value :: ldu
      complex(c_double_complex),target :: V
      integer(c_int),value :: ldv
      real(c_double),target :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgesvd_rank_0 = rocsolver_zgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_zgesvd_rank_1(handle,left_svect,n,A,lda,S,U,ldu,V,ldv,E,fast_alg,myInfo)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: S
      complex(c_double_complex),target,dimension(:) :: U
      integer(c_int),value :: ldu
      complex(c_double_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      real(c_double),target,dimension(:) :: E
      integer(kind(rocblas_outofplace)),value :: fast_alg
      type(c_ptr),value :: myInfo
      !
      rocsolver_zgesvd_rank_1 = rocsolver_zgesvd_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),c_loc(U),ldu,c_loc(V),ldv,c_loc(E),fast_alg,myInfo)
    end function

    function rocsolver_sgesvd_batched_full_rank(handle,left_svect,n,A,lda,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_batched_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgesvd_batched_full_rank = rocsolver_sgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_sgesvd_batched_rank_0(handle,left_svect,n,A,lda,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_batched_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgesvd_batched_rank_0 = rocsolver_sgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_sgesvd_batched_rank_1(handle,left_svect,n,A,lda,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_batched_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgesvd_batched_rank_1 = rocsolver_sgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_dgesvd_batched_full_rank(handle,left_svect,n,A,lda,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_batched_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgesvd_batched_full_rank = rocsolver_dgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_dgesvd_batched_rank_0(handle,left_svect,n,A,lda,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_batched_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgesvd_batched_rank_0 = rocsolver_dgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_dgesvd_batched_rank_1(handle,left_svect,n,A,lda,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_batched_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgesvd_batched_rank_1 = rocsolver_dgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_cgesvd_batched_full_rank(handle,left_svect,n,A,lda,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_batched_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: S
      integer(c_int64_t),value :: strideS
      complex(c_float_complex),target,dimension(:,:) :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_float_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgesvd_batched_full_rank = rocsolver_cgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_cgesvd_batched_rank_0(handle,left_svect,n,A,lda,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_batched_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      real(c_float),target :: S
      integer(c_int64_t),value :: strideS
      complex(c_float_complex),target :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_float_complex),target :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgesvd_batched_rank_0 = rocsolver_cgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_cgesvd_batched_rank_1(handle,left_svect,n,A,lda,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_batched_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_float),target,dimension(:) :: S
      integer(c_int64_t),value :: strideS
      complex(c_float_complex),target,dimension(:) :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_float_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_cgesvd_batched_rank_1 = rocsolver_cgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_zgesvd_batched_full_rank(handle,left_svect,n,A,lda,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_batched_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:,:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: S
      integer(c_int64_t),value :: strideS
      complex(c_double_complex),target,dimension(:,:) :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_double_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgesvd_batched_full_rank = rocsolver_zgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_zgesvd_batched_rank_0(handle,left_svect,n,A,lda,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_batched_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      real(c_double),target :: S
      integer(c_int64_t),value :: strideS
      complex(c_double_complex),target :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_double_complex),target :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgesvd_batched_rank_0 = rocsolver_zgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_zgesvd_batched_rank_1(handle,left_svect,n,A,lda,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_batched_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      real(c_double),target,dimension(:) :: S
      integer(c_int64_t),value :: strideS
      complex(c_double_complex),target,dimension(:) :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_double_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_zgesvd_batched_rank_1 = rocsolver_zgesvd_batched_orig(handle,left_svect,n,c_loc(A),lda,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_sgesvd_strided_batched_full_rank(handle,left_svect,n,A,lda,strideA,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgesvd_strided_batched_full_rank = rocsolver_sgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_sgesvd_strided_batched_rank_0(handle,left_svect,n,A,lda,strideA,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgesvd_strided_batched_rank_0 = rocsolver_sgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_sgesvd_strided_batched_rank_1(handle,left_svect,n,A,lda,strideA,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_sgesvd_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_float),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_sgesvd_strided_batched_rank_1 = rocsolver_sgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_dgesvd_strided_batched_full_rank(handle,left_svect,n,A,lda,strideA,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgesvd_strided_batched_full_rank = rocsolver_dgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_dgesvd_strided_batched_rank_0(handle,left_svect,n,A,lda,strideA,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgesvd_strided_batched_rank_0 = rocsolver_dgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_dgesvd_strided_batched_rank_1(handle,left_svect,n,A,lda,strideA,S,ldu,ldv,strideV,E,strideE,myInfo,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_dgesvd_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      real(c_double),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: S
      integer(c_int),value :: ldu
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      type(c_ptr),value :: myInfo
      integer(c_int),value :: batch_count
      !
      rocsolver_dgesvd_strided_batched_rank_1 = rocsolver_dgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),ldu,ldv,strideV,c_loc(E),strideE,myInfo,batch_count)
    end function

    function rocsolver_cgesvd_strided_batched_full_rank(handle,left_svect,n,A,lda,strideA,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,fast_alg,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: S
      integer(c_int64_t),value :: strideS
      complex(c_float_complex),target,dimension(:,:) :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_float_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      integer(kind(rocblas_outofplace)),value :: fast_alg
      integer(c_int),value :: batch_count
      !
      rocsolver_cgesvd_strided_batched_full_rank = rocsolver_cgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,fast_alg,batch_count)
    end function

    function rocsolver_cgesvd_strided_batched_rank_0(handle,left_svect,n,A,lda,strideA,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,fast_alg,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target :: S
      integer(c_int64_t),value :: strideS
      complex(c_float_complex),target :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_float_complex),target :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target :: E
      integer(c_int64_t),value :: strideE
      integer(kind(rocblas_outofplace)),value :: fast_alg
      integer(c_int),value :: batch_count
      !
      rocsolver_cgesvd_strided_batched_rank_0 = rocsolver_cgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,fast_alg,batch_count)
    end function

    function rocsolver_cgesvd_strided_batched_rank_1(handle,left_svect,n,A,lda,strideA,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,fast_alg,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_cgesvd_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_float_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_float),target,dimension(:) :: S
      integer(c_int64_t),value :: strideS
      complex(c_float_complex),target,dimension(:) :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_float_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_float),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      integer(kind(rocblas_outofplace)),value :: fast_alg
      integer(c_int),value :: batch_count
      !
      rocsolver_cgesvd_strided_batched_rank_1 = rocsolver_cgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,fast_alg,batch_count)
    end function

    function rocsolver_zgesvd_strided_batched_full_rank(handle,left_svect,n,A,lda,strideA,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,fast_alg,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_strided_batched_full_rank
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:,:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: S
      integer(c_int64_t),value :: strideS
      complex(c_double_complex),target,dimension(:,:) :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_double_complex),target,dimension(:,:) :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      integer(kind(rocblas_outofplace)),value :: fast_alg
      integer(c_int),value :: batch_count
      !
      rocsolver_zgesvd_strided_batched_full_rank = rocsolver_zgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,fast_alg,batch_count)
    end function

    function rocsolver_zgesvd_strided_batched_rank_0(handle,left_svect,n,A,lda,strideA,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,fast_alg,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_strided_batched_rank_0
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target :: S
      integer(c_int64_t),value :: strideS
      complex(c_double_complex),target :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_double_complex),target :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target :: E
      integer(c_int64_t),value :: strideE
      integer(kind(rocblas_outofplace)),value :: fast_alg
      integer(c_int),value :: batch_count
      !
      rocsolver_zgesvd_strided_batched_rank_0 = rocsolver_zgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,fast_alg,batch_count)
    end function

    function rocsolver_zgesvd_strided_batched_rank_1(handle,left_svect,n,A,lda,strideA,S,strideS,U,ldu,strideU,V,ldv,strideV,E,strideE,fast_alg,batch_count)
      use iso_c_binding
      use hipfort_rocsolver_enums
      implicit none
      integer(kind(rocblas_status_success)) :: rocsolver_zgesvd_strided_batched_rank_1
      type(c_ptr),value :: handle
      integer(kind(rocblas_svect_all)),value :: left_svect
      integer(c_int),value :: n
      complex(c_double_complex),target,dimension(:) :: A
      integer(c_int),value :: lda
      integer(c_int64_t),value :: strideA
      real(c_double),target,dimension(:) :: S
      integer(c_int64_t),value :: strideS
      complex(c_double_complex),target,dimension(:) :: U
      integer(c_int),value :: ldu
      integer(c_int64_t),value :: strideU
      complex(c_double_complex),target,dimension(:) :: V
      integer(c_int),value :: ldv
      integer(c_int64_t),value :: strideV
      real(c_double),target,dimension(:) :: E
      integer(c_int64_t),value :: strideE
      integer(kind(rocblas_outofplace)),value :: fast_alg
      integer(c_int),value :: batch_count
      !
      rocsolver_zgesvd_strided_batched_rank_1 = rocsolver_zgesvd_strided_batched_orig(handle,left_svect,n,c_loc(A),lda,strideA,c_loc(S),strideS,c_loc(U),ldu,strideU,c_loc(V),ldv,strideV,c_loc(E),strideE,fast_alg,batch_count)
    end function

  
end module hipfort_rocsolver