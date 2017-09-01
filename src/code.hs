add1 x = x + 1

square x = x * x

square(add1 1)

(square . add1) 1

:type (.) -- > (.) :: (b -> c) -> (a -> b) -> (a -> c)

------------------------------------------------------

add1 (x, log) = (x + 1, log ++ "add1")

square (x, log) = (x * x, log ++ "square")

sub1 (x, log) = (x - 1, log)

square(sub1(add1 (1, "")))

(square . sub1 . add1) (1, "")
