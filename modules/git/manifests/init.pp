class git{
    include git::install
}

class git::install{
    package { 'git:':
        ensure => present
    }
}


define git::clone ( $path, $dir){
    exec { "clone-$name-$path":
        command => "/usr/bin/git clone git@github.com:$name $path/$dir",
        creates => "$path/$dir",
        require => [Class["git"], File[$path]],
    }
}


class git::keys{
file { "/home/chris/.ssh":
    ensure => directory,
    owner => 'chris',
    group => 'chris',
    mode => 0600,
}

# Key for to be able to connect to GitHub
file { "/home/chris/.ssh/system_key":
    ensure => present,
    source => "puppet:///modules/git/system_key",
    owner => 'chris',
    group => 'chris',
    mode => 0600,
    require => File['/home/chris/.ssh'],
}

# Configure key to be automatically used for GitHub
file { "/home/chris/.ssh/config":
    ensure => present,
    source => "puppet:///modules/git/config",
    owner => 'chris',
    group => 'chris',
    mode => 0600,
    require => File['/home/chris/.ssh'],

}

# Add GitHub to known hosts to avoid prompt
file { "/home/chris/.ssh/known_hosts":
    ensure => present,
    source => "puppet:///modules/git/known_hosts",
    owner => 'chris',
    group => 'chris',
    mode => 0600,
    require => File['/home/chris/.ssh'],
}
}

#file { "/usr/local/app":
#    ensure => directory,
#    owner => 'chris',
#    group => 'chris',
#    mode => 755,
#}

#git::clone { '<GitHub repository name>':
#    path => '/usr/local/app',
#    dir => 'django',
#}
