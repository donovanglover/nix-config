#!/usr/bin/env bash
cat > /etc/yum.repos.d/crystal.repo <<END
[crystal]
name = Crystal
baseurl = http://dist.crystal-lang.org/rpm/
END

rpm --import http://dist.crystal-lang.org/rpm/RPM-GPG-KEY
