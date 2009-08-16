#!/bin/bash

testCanCreateHashesWithDefaultData() {
  createHash myHash a "never gonna give you up" b "never gonna let you down"
  assertEquals "never gonna let you down" "`accessHash myHash b`"
  destroyHash myHash
}

testCanAddValuesToHashes() {
  createHash myHash a "never gonna give you up"
  addToHash myHash b "never gonna let you down"
  assertEquals "never gonna let you down" "`accessHash myHash b`"
  destroyHash myHash
}

. testHelper.sh