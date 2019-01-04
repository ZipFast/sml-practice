fun is_older (first:int*int*int,second:int*int*int) =
    let val gap1 =(#1 first) - (#1 second)
	val gap2 =(#2 first) - (#2 second)
	val gap3 =(#3 first) - (#3 second)
    in if gap1 < 0 then true
       else if gap1 = 0 andalso gap2 < 0
       then true
       else if gap1 = 0 andalso gap2 = 0 andalso gap3 < 0
       then true
       else false
    end

fun number_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then 0
    else let val num = number_in_month(tl dates, month)
	 in if month = (#2 (hd dates))
	    then 1 + num
	    else num
	 end

fun number_in_months (dates : (int*int*int) list, months : int list)=
    if null months
    then 0
    else let val num = number_in_month (dates,hd months)
	 in num + number_in_months(dates,tl months)
	 end
	     
fun dates_in_month (dates : (int*int*int) list, month : int)=
    if null dates
    then []
    else let val date = dates_in_month (tl dates, month)
	 in if (#2 (hd dates)) = month
	    then (hd dates) :: date
	    else date
	 end
	     
fun dates_in_months (dates: (int*int*int) list, months : int list) =
    if null months
    then []
    else let val dateIn = dates_in_month (dates, hd months)
	 in dateIn @ dates_in_months (dates, tl months)
	 end
	     
fun get_nth (strs : string list, n : int) =
    if n = 1
    then hd strs
    else get_nth (tl strs, n-1)

fun date_to_string (date : int*int*int) =
    let val months_str = ["January","February","March","April","May","June",
			  "July","August","September","October","November",
			  "December"]
    in get_nth (months_str,(#2 date)) ^ " " ^ Int.toString((#3 date))^ ", "^
       Int.toString((#1 date))
    end
	
fun number_before_reaching_sum (sum : int, nums : int list) =
    if sum <= 0 then (0-1)
    else 1 + number_before_reaching_sum (sum - (hd nums), tl nums)

fun what_month (day : int) =
    let val days = [31,28,31,30,31,30,31,31,30,31,30,31]
    in number_before_reaching_sum(day, days) + 1 
    end

fun month_range (day1 : int, day2 : int) =
    if day1 > day2 then []
    else what_month day1 :: month_range(day1 + 1, day2)

fun oldest (dates : (int*int*int) list) =
    if null dates then NONE
    else if null (tl dates) then SOME(hd dates)
	else if is_older(hd dates,valOf(oldest (tl dates)))
	     then SOME(hd dates) else oldest (tl dates)
	
