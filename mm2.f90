module mm2
    contains
    subroutine mm(first, second, multiply, status)
        implicit none
        real (kind = 8), intent(in) :: first(:,:) ! pierwsza macierz
        real (kind = 8), intent(in) :: second(: ,:) ! druga macierz
        real (kind = 8), intent(out) :: multiply(:,:) ! macierz wynikowa
        integer (kind = 4), intent(out) :: status ! kod błędu, 0 gdy OK
        integer (kind = 4) :: shape1(2), shape2(2), i, j, k, kk, jj, ichunk

        shape1 = shape(first)
        shape2 = shape(second)

        if (shape1(2) .NE. shape2(1)) then
            status = 1
            return 
        end if

        multiply = 0
        ichunk = 512 ! I have a 3MB cache size
        do jj = 1, shape1(1), ichunk
           do kk = 1, shape2(2), ichunk
 
              do j = jj, min(jj + ichunk - 1, shape1(1))
                 do k = kk, min(kk + ichunk - 1, shape2(2))
                    do i = 1, shape1(2)
                       multiply(i, j) = multiply(i, j) + first(i, k) * second(k, j)
                    end do
                 end do
              end do
 
           end do
        end do

        status = 0
        
    end subroutine
end module
