let sieve_eratosthenes n =
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

let get_primes n =
  let arr = sieve_eratosthenes n in
  let result = ref [] in
  Array.iteri (fun i is_prime -> if is_prime then result := i :: !result) arr ;
  List.rev !result

let goldbach value =
  let result = ref [] in
  if value >= 4 && value mod 2 = 0 then
    let primes = get_primes value in
    List.iter (fun p1 ->
      List.iter (fun p2 ->
      if p1 + p2 = value && p1 <= then
      result := (p1, p2) :: !result
      ) primes
      ) primes ;
    !result
