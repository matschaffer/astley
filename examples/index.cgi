#!/bin/bash

. "../lib/astley.sh"

get/() {
  render views/form.html
}

post/saymyname() {
  NAME=`params "name"`
  render views/response.html
}

name_resource() {
  NAME=`echo ${PATH_INFO} | cut -d/ -f3`
  render views/response.html
}

match_route "/name/[A-Za-z]*" name_resource

route