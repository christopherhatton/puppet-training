class users {

  user { 'chris':
      ensure => 'present',
      require => user['ubuntu'],
      groups => ['sudo', 'ubuntu'],
      home => '/home/chris',
      managehome => true,
      password => '$6$lY2Gp3Cr$zNrUB7T3yibUF/gWn5cTQ0fNv7MUmx/DZuw3E7I..Vh9tITG28BtgvXJPU4Gm4Z/9oNvlbX24KzQ9Ib1QH1B9.',
      shell => '/bin/bash',
  }

  user { 'ubuntu':
    ensure           => 'present',
  }

  file { '/home/chris':
      ensure => directory,
      owner => 'chris',
      group => 'ubuntu',
      mode => 755,
      source => 'puppet:///modules/users/chris',
      recurse => remote,
      require => User['chris'],
  }

  ssh_authorized_key { 'chris':
      ensure => 'present',
      user => 'chris',
      type => 'rsa',
      key => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDAg3ts/BQxESOB+x0s8za+hogw+U0uvSEB6+Vwd6fNoDzk5nr4CvIl+F17YJr2jn1erY0TQ0k1+kxWQxQbkiFkWnBrX/i+kA8Dbi3vv2R3VxO7pN1Avoi+aPTunlAQ+eeJDVpY38JuY9VNgj+GvFkouwVNsB1I/nn93bqbVsqn/KlVVTUTTVH3VJRb9PKMF44xkuNlNgYtAUewQUb/cbcT5xFTlQ1Na57ShY5xoiRWD2AeMLBg4/Rh28J+r2YtPCMrDKSfUaSf8b2EchTXchbUAfLcUrTnJxLsyzRtWUoTTLDyYiQtzH6gXFVfbYj2mA0x+zCXeV+sElLwEBSIe+hn+SbBkGSqXawbeszelEEaHw8JDlswLDjeeEICMcS9HcG4MbM00yu8/IEZ1cg53S640ERL1A3O2e/nGdfxuC0K8ChskCkD9pPVNwpe7jHtgPcRXYlOF1D41mJSRbJyupDz+ju2PKETe1vUuGndZj40OKsBZnBPH5VBTWVEuUmSj/0byCb5g2iMakJ+8TB0lwdYshqCAIgeXC0stxLE1Pn37p7tCnbm2D8a4Q6SmvS7beKbpl40VyWi9Gp4n9PkI9piikwz8VacMOZVMUeE5GjASvR8HIn2Gi0o3YlanQLpyAWKS463TFU/lv5LzRts0DuTYuf52BbbrHHw2t/3B/O5Iw==',
  }

}
