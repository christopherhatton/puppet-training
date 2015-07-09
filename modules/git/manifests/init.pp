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

file { "/home/<username>/.ssh":
    ensure => directory,
    owner => '<username>',
    group => '<username>',
    mode => 0600,
}

# Key for to be able to connect to GitHub
file { "/home/<username>/.ssh/system_key":
    ensure => present,
    source => "puppet:///modules/git/system_key",
    owner => '<username>',
    group => '<username>',
    mode => 0600,
    require => File['/home/<username>/.ssh'],
}

# Configure key to be automatically used for GitHub
file { "/home/<username>/.ssh/config":
    ensure => present,
    source => "puppet:///modules/git/config",
    owner => '<username>',
    group => '<username>',
    mode => 0600,
    require => File['/home/<username>/.ssh'],

}

# Add GitHub to known hosts to avoid prompt
file { "/home/<username>/.ssh/known_hosts":
    ensure => present,
    source => "puppet:///modules/git/known_hosts",
    owner => '<username>',
    group => '<username>',
    mode => 0600,
    require => File['/home/<username>/.ssh'],
}
