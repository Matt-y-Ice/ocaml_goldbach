let sieve_eratosthenes n =
  let arr = Array.make (n + 1) true in
  arr.(0) <- false;
  arr.(1) <- false;
  let sqrt_n = int_of_float (sqrt (float_of_int n)) in
  (* Start from 2 and only mark odd multiples for even numbers *)
  arr.(2) <- true;
  for i = 3 to n do
    if i mod 2 = 0 then arr.(i) <- false
  done;
  (* Only check odd numbers for sieving *)
  for i = 3 to sqrt_n do
    if arr.(i) then
      let j = ref (i * i) in
      while !j <= n do
        arr.(!j) <- false;
        j := !j + (2 * i)  (* Skip even multiples *)
      done
  done;
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
    (* Convert list to hashtable for O(1) lookups *)
    let prime_set = Hashtbl.create (List.length primes) in
    List.iter (fun p -> Hashtbl.add prime_set p true) primes;
    (* Only iterate through primes up to value/2 *)
    List.iter (fun p1 ->
      if p1 <= value/2 then
        let p2 = value - p1 in
        if Hashtbl.mem prime_set p2 && p1 <= p2 then
          result := (p1, p2) :: !result
    ) primes;
    !result
  else
    []

let print_goldbach value pairs =
  if List.length pairs = 0 then
    Printf.printf "We found no Goldbach pairs for %d.\n" value
  else begin
    Printf.printf "We found %d Goldbach pair(s) for %d.\n" (List.length pairs) value;
    List.iter (fun (p1, p2) ->
      Printf.printf "%d = %d + %d\n" value p1 p2
    ) pairs;
  end;
  print_newline ()

let write_goldbach oc value pairs =
  if List.length pairs = 0 then
    Printf.fprintf oc "We found no Goldbach pairs for %d.\n" value
  else begin
    Printf.fprintf oc "We found %d Goldbach pair(s) for %d.\n" (List.length pairs) value;
    List.iter (fun (p1, p2) ->
      Printf.fprintf oc "%d = %d + %d\n" value p1 p2
    ) pairs;
  end;
  Printf.fprintf oc "\n"

let process_file filename =
  let ic = open_in filename in
  let oc = open_out "ocaml-results.txt" in
  try
    while true do
      let line = input_line ic in
      try
        let value = int_of_string (String.trim line) in
        let result = goldbach value in
        print_goldbach value result;
        write_goldbach oc value result
      with Failure _ ->
        let error_msg = Printf.sprintf "Error: Invalid integer '%s' in file %s\n" line filename in
        print_string error_msg;
        Printf.fprintf oc "%s\n" error_msg
    done
  with
  | End_of_file -> 
      close_in ic;
      close_out oc
  | e -> 
      close_in_noerr ic;
      close_out_noerr oc;
      raise e

let default_values = [3; 4; 14; 26; 100]

let () = 
  if Array.length Sys.argv > 1 then
    Array.iter process_file (Array.sub Sys.argv 1 (Array.length Sys.argv - 1))
  else begin
    let oc = open_out "ocaml-results.txt" in
    List.iter (fun value ->
      let result = goldbach value in
      print_goldbach value result;
      write_goldbach oc value result
    ) default_values;
    close_out oc
  end

     