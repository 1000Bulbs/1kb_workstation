include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::mysql"
include_recipe "pivotal_workstation::mongodb"
include_recipe "pivotal_workstation::postgres"
include_recipe "pivotal_workstation::redis"

# this must be run last, because it does dumb stuff with permissions in /usr/local
include_recipe "1kb_workstation::php53"