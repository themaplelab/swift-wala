// https://developer.apple.com/documentation/swift/array

// SWAN treats arrays as just an object with a single field.

func source() -> String {
  return "I'm bad";
}

func sink(sunk: String) {
  print(sunk);
}

// ------- Creating -------

func test_init1() {
  // Slightly incorrect path (SWAN-30)
  let src = source();
  let arr = [src]; //!testing!source
  sink(sunk : arr[0]); //!testing!sink
}

func test_init2() {
  let src = source();
  let arr = Array(repeating: src, count: 2); //!testing!source 
  sink(sunk : arr[0]); //!testing!sink
}

// ------- Accessing -------

// basic subscript already tested above

func test_first() {
  let src = source();
  let arr = [src]; //!testing!source
  sink(sunk : arr.first!); //!testing!sink
}

func test_last() {
  let src = source();
  let arr = [src]; //!testing!source
  sink(sunk : arr.last!); //!testing!sink
}

func test_subcript_write() {
  let src = source();
  var arr = [String]();
  arr[0] = src; //!testing!source
  sink(sunk : arr[0]); //!testing!sink
}

func test_subscript_range() {
  let src = source();
  let arr = ["a", src, "b", "c"]; //!testing!source
  let arrSlice = arr[1 ..< arr.endIndex]
  sink(sunk : arrSlice[0]); //!testing!sink
}

func test_random_element() {
  let src = source();
  let arr = ["a", src, "b", "c"]; //!testing!source
  sink(sunk : arr.randomElement()!); //!testing!sink
}

// ------- Adding -------

func test_append() {
  let src = source();
  var arr = [String]();
  arr.append(src); //!testing!source
  sink(sunk : arr[0]); //!testing!sink
}

func test_insert() {
  let src = source();
  var arr = [String]();
  arr.insert(src, at: 0); //!testing!source
  sink(sunk : arr[0]); //!testing!sink
}

func test_insert_contentsOf() {
  let src = source();
  let arr1 = [src]; //!testing!source
  var arr2 = [String]();
  arr2.insert(contentsOf: arr1, at: 0);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_replace_subrange() {
  let src = source();
  let arr1 = [src]; //!testing!source
  var arr2 = ["a", "b", "c"];
  arr2.replaceSubrange(1...2, with: arr1);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_append_combine() {
  let src = source();
  let arr1 = [src]; //!testing!source
  var arr2 = ["a", "b", "c"];
  arr2.append(contentsOf: arr1);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_add1() {
  let src = source();
  let arr1 = [src]; //!testing!source
  var arr2 = ["a", "b", "c"];
  arr2 = arr2 + arr1
  sink(sunk : arr2[0]); //!testing!sink
}

func test_add2() {
  let src = source();
  let arr1 = [src]; //!testing!source
  var arr2 = ["a", "b", "c"];
  arr2 += arr1
  sink(sunk : arr2[0]); //!testing!sink
}

// ------- Removing -------

func test_removeAt() {
  let src = source();
  var arr = ["a", src, "b", "c"]; //!testing!source
  let removed = arr.remove(at: 2);
  sink(sunk : removed); //!testing!sink
}

func test_removeFirst() {
  let src = source();
  var arr = ["a", src, "b", "c"]; //!testing!source
  let removed = arr.removeFirst();
  sink(sunk : removed); //!testing!sink
}

func test_removeLast() {
  let src = source();
  var arr = ["a", src, "b", "c"]; //!testing!source
  let removed = arr.removeLast();
  sink(sunk : removed); //!testing!sink
}

func test_removeAll(){
  let src = source();
  var arr = ["a", src, "b", "c"]; //!testing!source
  arr.removeAll();
  sink(sunk : arr[0]); //!testing!sink!fp
}

func test_popLast() {
  let src = source();
  var arr = ["a", src, "b", "c"]; //!testing!source
  let removed = arr.popLast();
  sink(sunk : removed!); //!testing!sink
}

// ------- Finding -------

func test_findFirst() {
  let src = source();
  let arr = ["a", src, "b", "c", "b", "c"]; //!testing!source
  let FirstElement = arr.first(where: {$0 == "b" });
  sink(sunk : FirstElement!); //!testing!sink
}

func test_findLast() {
  let src = source();
  let arr = ["a", src, "b", "c", "b", "c"]; //!testing!source
  let FirstElement = arr.last(where: {$0 == "b" });
  sink(sunk : FirstElement!); //!testing!sink
}

// ------- Selecting -------

func test_prefix1() {
  let src = source();
  let arr1 = ["a", src, "b", "c"]; //!testing!source
  let arr2 = arr1.prefix(3);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_prefix2() {
  let src = source();
  let arr1 = ["a", src, "b", "c"]; //!testing!source
  let arr2 = arr1.prefix(through: 3);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_prefix3() {
  let src = source();
  let arr1 = ["a", src, "b", "c"]; //!testing!source
  let arr2 = arr1.prefix(upTo: 2);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_prefix4() {
  let src = source();
  let arr1 = ["a", src, "b", "c"]; //!testing!source
  let arr2 = arr1.prefix(while: { $0 != "b"});
  sink(sunk : arr2[0]); //!testing!sink
}

func test_suffix1() {
  let src = source();
  let arr1 = ["a", src, "b", "c"]; //!testing!source
  let arr2 = arr1.suffix(3);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_suffix2() {
  let src = source();
  let arr1 = ["a", src, "b", "c"]; //!testing!source
  let arr2 = arr1.suffix(from: 2);
  sink(sunk : arr2[0]); //!testing!sink
}

// ------- Excluding -------

func test_dropFirst() {
  let src = source();
  let arr1 = ["a", src, "b", "c"]; //!testing!source
  let arr2 = arr1.dropFirst(2);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_dropLast() {
  let src = source();
  let arr1 = ["a", src, "b", "c"]; //!testing!source
  let arr2 = arr1.dropLast(1);
  sink(sunk : arr2[0]); //!testing!sink
}

//-------- Reordering --------

func test_sorted1() {
  let src = source();
  let arr1 = ["c", src, "d", "b", "a"]; //!testing!source
  let arr2 = arr1.sorted();
  sink(sunk : arr2[0]); //!testing!sink
}

func test_sorted2() {
  let src = source();
  let arr1 = ["a", src, "b", "c", "d"]; //!testing!source
  let arr2 = arr1.sorted(by: <);
  sink(sunk : arr2[0]); //!testing!sink
}

func test_reverse() {
  let src = source();
  var arr = ["a", src, "b", "c", "d"]; //!testing!source
  arr.reverse();
  sink(sunk : arr[0]); //!testing!sink
}

func test_shuffled() {
  let src = source();
  let arr1 = ["a", src, "b", "c", "d"]; //!testing!source
  let arr2 = arr1.shuffled();
  sink(sunk : arr2[0]); //!testing!sink
}

// -------- transforming ---------

func test_map() {
  let src = source();
  let arr1 = ["a", src, "B", "c", "d"]; //!testing!source
  let arr2 = arr1.map { $0.lowercased() }
  sink(sunk : arr2[0]); //!testing!sink
}

func test_compactMap() {
  let src = source();
  let arr1 = ["a", src, "B", "c", "d"]; //!testing!source
  let arr2 = arr1.compactMap { str in str }
  sink(sunk : arr2[0]); //!testing!sink
}

// ...