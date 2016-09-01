

#   Configure Pyzor, if the plugin is enabled
#
ifplugin Mail::SpamAssassin::Plugin::Pyzor
#   Whether to use Pyzor, or not.
#
use_pyzor      1

#   Additional options to the pyzor(1) command.
#   Please note that only characters in the range [0-9A-Za-z ,._/-] are allowed
#   for security reasons.
#
pyzor_options   -d

endif # Mail::SpamAssassin::Plugin::Pyzor


#   Configure Razor2, if the plugin is enabled
#
ifplugin Mail::SpamAssassin::Plugin::Razor2
#   Whether to use Razor2, or not.
#
use_razor2      1

endif # Mail::SpamAssassin::Plugin::Razor2
