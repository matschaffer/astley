test_can_match_path_info_to_action_by_regex() {
  match_route '/entity name/[0-9]' dummyControllerAction
  assertEquals `resolve_matched_route '/entity name/3'` dummyControllerAction
}

get/dummy/url() {
  echo "Just a test method"
}

test_can_match_to_methods_directly() {
  REQUEST_METHOD="GET"
  PATH_INFO="/dummy/url"
  assertEquals `resolve_controller_method` "get/dummy/url"
}

test_will_run_404_action_if_no_action_found() {
  REQUEST_METHOD="GET"
  PATH_INFO="/a/url/that/i/don't/have/a/method/for"
  assertEquals `resolve_controller_method` "get/_astley/error/404"
}

. testHelper.sh