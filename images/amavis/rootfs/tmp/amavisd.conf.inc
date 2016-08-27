

# Executing additional configuration files from /etc/amavis/conf.d directory
{ my($d) = "/etc/amavis/conf.d";
  local(*D); opendir(D,$d) or die "Can't open dir $d: $!";
  my(@d) = sort grep {/\.(cf|conf)$/ && -f} map {/^(.*)$/,"$d/$1"} readdir(D);
  closedir(D) or die "Can't close $d: $!";
  for my $f (@d) {
    printf("Reading config file %s\n", $f); $!=0;
    if (defined(do $f)) {}
    elsif ($@ ne '') { die "Error in $f: $@" }
    elsif ($! != 0)  { die "Error reading $f: $!" }
  }
}


1;
