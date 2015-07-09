node default {

include users
include ssh
include postgres
include git::install
include git::keys
#include git::clone
}
