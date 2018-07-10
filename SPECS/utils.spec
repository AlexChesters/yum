%define name alexchesters-utils
%define version 0.0.0
%define release 1
%define buildroot %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

Name: %{name}
Version: %{version}
Release: %{release}
Summary: A collection of various utilities packaged as an RPM

Group: Installation Script
License: MIT
Source: %{name}.tar.gz
BuildRoot: %{buildroot}
Requires: nodejs
BuildRequires: nodejs
AutoReqProv: no

%description
A collection of various utilities packaged as an RPM

%prep
%setup -q -c -n %{name}

%pre
getent group alexchesters-utils >/dev/null || groupadd -r alexchesters-utils
getent passwd alexchesters-utils >/dev/null || useradd -r -g alexchesters-utils -G alexchesters-utils -d / -s /sbin/nologin -c "alexchesters-utils" alexchesters-utils

%install
mkdir -p %{buildroot}/usr/lib/alexchesters-utils
cp -r ./src %{buildroot}/usr/lib/alexchesters-utils
mkdir -p %{buildroot}/var/log/alexchesters-utils

%clean
rm -rf %{buildroot}

%files
%defattr(644, alexchesters-utils, alexchesters-utils, 755)
/usr/lib/alexchesters-utils
/var/log/alexchesters-utils
