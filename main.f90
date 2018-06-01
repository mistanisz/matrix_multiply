program main
    use M
    implicit none
    integer(kind = 4) :: status, i
    real (kind = 8), allocatable :: first(:,:), second(:,:), multiply(:,:)
    real (kind = 8) :: start, stop

    first = 1.8
    second = 8.8

    do i=1, 1001, 10
        allocate(first(i, i))
        allocate(second(i, i))
        allocate(multiply(i, i))
        call cpu_time(start)
        call mm(first, second, multiply, status)
        call cpu_time(stop)
        write(*,*) i,",", (stop - start)
        deallocate(first)
        deallocate(second)
        deallocate(multiply)
    end do

end program
