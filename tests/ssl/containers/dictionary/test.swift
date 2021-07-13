// https://developer.apple.com/documentation/swift/dictionary

// SWAN treats dictionaries as just an object with a single field.
// Assumes key taintedness is irrelevant.

func source() -> String {
  return "I'm bad";
}

func sink(sunk: String) {
  print(sunk);
}

// ------- Creating -------

func test_init() {
  let src = source();
  let dict = ["key": src]; //!testing!source
  sink(sunk: dict["key"]!); //!testing!sink
}

// ------- Accessing -------

func test_subscript_default1() {
  let src = source();
  let dict = ["key": src]; //!testing!source
  sink(sunk: dict["key", default: "a"]); //!testing!sink
}

func test_subscript_default2() {
  let src = source();
  let dict = ["key": "a"];
  let taintedValue = dict["key", default: src]; //!testing!source
  sink(sunk: taintedValue); //!testing!sink
}


// -------- Adding -------

func test_updateValue1() {
  let src = source();
  var dict = ["key": src, "key1": "a"]; //!testing!source
  let updated = dict.updateValue("b", forKey: "key1");
  sink(sunk: updated!); //!testing!sink
}

func test_updateValue2() {
  let src = source();
  var dict = ["key": src, "key1": "a"]; //!testing!source
  let updated = dict.updateValue("b", forKey: "key2");
  sink(sunk: updated!); //!testing!sink
}

// func test_merge1() {
//   let src = source();
//   var dict = ["key": src, "key1": "a"]; !testing!source
//   dict.merge(["key1": "b", "c": "c"]) { (current, _) in current };
//   sink(sunk: dict["c"]!); !testing!sink
//
// }
//
// func test_merge2() {
//   let src = source();
//   var dict = ["key": src, "key1": "a"]; !testing!source
//   dict.merge(["key1": "b", "c": "c"]) { (_, new) in new };
//   sink(sunk: dict["c"]!); !testing!sink
//
// }


// not sure because of the "zip"
// func test_merge3() {
//   let src = source();
//   var dict = ["key": src, "key1": "a"]; !testing!source
//   dict.merge(zip(["key1", "c"],["b", "c"])) { (current, _) in current };
//   sink(sunk: dict["c"]!); !testing!sink
// }

func test_merging1() {
  let src = source();
  let dict = ["key": src, "key1": "a"]; //!testing!source
  let dict1 = ["key2": "b", "key3": "c"];
  let keepCurrent = dict.merging(dict1) { (current, _) in current };
  sink(sunk: keepCurrent["key3"]!); //!testing!sink
}

func test_merging2() {
  let src = source();
  let dict = ["key": src, "key1": "a"]; //!testing!source
  let dict1 = ["key2": "b", "key3": "c"];
  let keepCurrent = dict.merging(dict1) { (_, new) in new };
  sink(sunk: keepCurrent["key2"]!); //!testing!sink
}

// not sure because of the "zip"
// func test_merging3() {
//   let src = source();
//   let dict = ["key": src, "key1": "a"]; !testing!source
//   let dict1 = zip(["key2", "key3"], ["b", "c"]);
//   let keepCurrent = dict.merging(dict1) { (_, new) in new };
//   sink(sunk: keepCurrent["key2"]!); !testing!sink
// }

// ------- Removing -------

// func test_filter() {
//   let src = source();
//   let dict = ["key": src, "key1": "a", "key2": "a", "key3": "b"]; !testing!source
//   let filtered = dict.filter { $0.value == "a"};
//   sink(sunk: filtered.values.first!); !testing!sink
// }

// ------- Transforming --------

// func test_mapValues() {
//   let src = source();
//   let dict = ["key": src, "key1": "a", "key2": "b", "key3": "b"]; !testing!source
//   let new_dict = dict.mapValues { $0 + "a"};
//   sink(sunk: new_dict.values.first!); !testing!sink
// }

func test_map() {
  let src = source();
  let dict = ["key": src, "key1": "a", "key2": "b", "key3": "b"]; //!testing!source
  let new_dict = dict.map { $0.value.lowercased() };
  sink(sunk: new_dict.first!); //!testing!sink
}

func test_compactMap() {
  let src = source();
  let dict = ["key": src, "key1": "a", "key2": "b", "key3": "c"]; //!testing!source
  let new_arr : [String] = dict.compactMap{ key, value in value };
  sink(sunk: new_arr.first!); //!testing!sink
}

// func test_compactMapValues() {
//   let src = source();
//   let dict = ["key": src, "key1": "a", "key2": "b", "key3": "c"]; !testing!source
//   let new_dict : [String: String] = dict.compactMapValues { str in String(str) };
//   sink(sunk: new_dict.values.first!); !testing!sink
// }



// ...