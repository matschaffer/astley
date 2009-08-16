#!/bin/bash

test_can_create_hashes_with_default_data() {
  create_hash myHash a "never gonna give you up" b "never gonna let you down"
  assertEquals "never gonna let you down" "`access_hash myHash b`"
  destroy_hash myHash
}

test_can_add_values_to_hashes() {
  create_hash myHash a "never gonna give you up"
  add_to_hash myHash b "never gonna let you down"
  assertEquals "never gonna let you down" "`access_hash myHash b`"
  destroy_hash myHash
}

. testHelper.sh