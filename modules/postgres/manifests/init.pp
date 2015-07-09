class postgres{
    include postgres::install, postgres::config, postgres::service
}

class postgres::install{
    package { 'postgresql':
        ensure => present
    }
}

class postgres::config{

}

class postgres::service{
    service {'postgresql':
        ensure => running,
        enable => true,
    }
}


 postgresql::server::db {'django_db':
    user => 'django',
    password => postgresql_password('django', 'changeme!'),
}

Class["postgres::install"] -> Class["postgres::config"] -> Class["postgres::service"]
