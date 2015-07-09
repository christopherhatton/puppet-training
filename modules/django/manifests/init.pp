class django::install {
    package { [ "python", "python-dev", "python-virtualenv", "python-pip",
                "python-psycopg2", "python-imaging"]:
        ensure => present,
    }
}

class django::clone {
    git::clone { 'django/django':
        path => '/usr/local/app',
        dir => 'django',
    }
}
