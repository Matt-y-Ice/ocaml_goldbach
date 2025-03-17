let find_primes_eratosthenes n =
  let arr = Array.make (n + 1) true in
  arr.(0) <- false ;
  arr.(1) <- false ;
  for i = 2 to int_of_float (sqrt (float_of_int n)) do
    if arr.(i) then
      let j = ref (i * i) in
      while !j <= n do
        arr.(!j) <- false ;
        j := !j + i
      done
  done ;
  arr

let primes n =
  let arr = find_primes_eratosthenes n in
  let result = ref [] in
  Array.iteri (fun i is_prime -> if is_prime then result := i :: !result) arr ;
  List.rev !result
