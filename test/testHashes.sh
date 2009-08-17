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

dummy_iteration_function() {
  local key value i
  key="$1"
  value="$2"
  i="$3"
  case $i in
    0) assertEquals "$key" a
       assertEquals "$value" "never gonna give you up";;
    1) assertEquals "$key" b
       assertEquals "$value" "never gonna let you down";;
    *) fail;;
  esac
}

test_can_iterate_through_hashes() {
  create_hash myHash a "never gonna give you up" b "never gonna let you down"
  iterate_hash myHash dummy_iteration_function
  destroy_hash myHash
}

. testHelper.sh