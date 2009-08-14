#!/bin/bash

get/() {
  render "views/form.html"
}

post/saymyname() {
  NAME=`params "name"`
  render "views/response.html"
}

. "../lib/astley.sh"
