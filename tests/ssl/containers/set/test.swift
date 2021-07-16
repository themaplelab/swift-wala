// https://developer.apple.com/documentation/swift/set

func source() -> String {
    return "I'm bad";
}

func sink(sunk: String) {
    print(sunk);
}

// ------- Creating -------

func test_init() {
  let src = source();
  let aSet : Set = ["a", "b", src]; //!testing!source
  sink(sunk : aSet.first!); //!testing!sink
}

// ------- Adding ---------

func test_insert() {
  let src = source();
  var aSet = Set<String>();
  aSet.insert(src); //!testing!source
  sink(sunk : aSet.first!); //!testing!sink
}

func test_update() {
  let src = source();
  var aSet : Set = ["a", "b", "c"];
  aSet.update(with: src); //!testing!source
  sink(sunk : aSet.first!); //!testing!sink
}

//--------------Removing----------------

func test_filter() {
  let src = source();
  let aSet : Set = ["a", "b", "c", "b", src]; //!testing!source
  let Set2 = aSet.filter{ $0 != "b" };
  sink(sunk : Set2.first!); //!testing!sink
}

func test_remove() {
  let src = source();
  var aSet : Set = ["a", "b", "c", src]; //!testing!source
  let removed = aSet.remove("a");
  sink(sunk : removed!); //!testing!sink
}

func test_removeFirst() {
  let src = source();
  var aSet : Set = ["a", "b", "c", src]; //!testing!source
  let removed = aSet.removeFirst();
  sink(sunk : removed); //!testing!sink
}

func test_removeAt() {
  let src = source();
  var aSet : Set = ["a", "b", "c", src]; //!testing!source
  let removed = aSet.remove( at : aSet.startIndex);
  sink(sunk : removed); //!testing!sink
}

func test_removeAll() {
  let src = source();
  var aSet : Set = ["a", "b", "c", src]; //!testing!source
  aSet.removeAll();
  sink(sunk : aSet.first!); //!testing!sink!fp
}

//--------------Combining----------------

// func test_union() {
//   //SWAN-23
//   let src = source();
//   let aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 : Set = ["e", "f", "g"];
//   let newSet = aSet.union(aSet1);
//   sink(sunk : newSet.first!); !testing!sink
// }

// func test_formUnion1() {
//   //SWAN-23
//   let src = source();
//   var aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 : Set = ["a", "b", "g"];
//   aSet.formUnion(aSet1);
//   sink(sunk : aSet.first!); !testing!sink
// }

// func test_formUnion2() {
//      //SWAN-23
//   let src = source();
//   var aSet : Set = ["a", "b", "c", src]; !testing!source
//   let arr = ["a", "b", "g"];
//   aSet.formUnion(arr);
//   sink(sunk : aSet.first!); !testing!sink
// }

// func test_intersection1() {
//      //SWAN-23
//   let src = source();
//   let aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 : Set = ["a", "b", "d"];
//   let newSet = aSet.intersection(aSet1);
//   sink(sunk : newSet.first!); !testing!sink
// }

// func test_intersection2() {
//      //SWAN-23
//   let src = source();
//   let aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 = ["a", "b", "d"];
//   let newSet = aSet.intersection(aSet1);
//   sink(sunk : newSet.first!); !testing!sink
// }

// func test_formIntersection() {
//      //SWAN-23
//   let src = source();
//   var aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 : Set = ["a", "b", "d"];
//   aSet.formIntersection(aSet1);
//   sink(sunk : aSet.first!); !testing!sink
// }

// func test_symmetricDifference() {
//      //SWAN-23
//   let src = source();
//   let aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 : Set = ["a", "b", "d"];
//   let newSet = aSet.symmetricDifference(aSet1);
//   sink(sunk : newSet.first!); !testing!sink
// }

// func test_formSymmetricDifference1() {
//      //SWAN-23
//   let src = source();
//   var aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 : Set = ["a", "b", "d"];
//   aSet.formSymmetricDifference(aSet1);
//   sink(sunk : aSet.first!); !testing!sink
// }

// func test_formSymmetricDifference2() {
//      //SWAN-23
//   let src = source();
//   var aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 = ["a", "b", "d"];
//   aSet.formSymmetricDifference(aSet1);
//   sink(sunk : aSet.first!); !testing!sink
// }

// func test_subtract1() {
//     // SWAN-23
//   let src = source();
//   var aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 = ["a", "b", "d"];
//   aSet.subtract(aSet1);
//   sink(sunk : aSet.first!); !testing!sink
// }

// func test_subtract2() {
//      //SWAN-23
//   let src = source();
//   var aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 : Set = ["a", "b", "d"];
//   aSet.subtract(aSet1);
//   sink(sunk : aSet.first!); !testing!sink
// }

// func test_subtracting1() {
//      //SWAN-23
//   let src = source();
//   let aSet : Set = ["a", "b", "c", src]; !testing!source
//   let arr = ["a", "b", "d"];
//   let new_set = aSet.subtracting(arr);
//   sink(sunk : new_set.first!); !testing!sink
// }

// If "let" is changed to "var" for "aSet", the test is not passed
// func test_subtracting2() {
//      //SWAN-23
//   let src = source();
//   let aSet : Set = ["a", "b", "c", src]; !testing!source
//   let aSet1 : Set = ["a", "b", "d"];
//   let new_set = aSet.subtracting(aSet1);
//   sink(sunk : new_set.first!); !testing!sink
// }

// ...