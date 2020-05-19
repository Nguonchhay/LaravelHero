Welcome to Laravel Hero
---

A repository that contain all sample codes for Laravel features

# Requirement

* PHP >= 7.4
* MySQL >= 8.0
* Node >= 12.13.x
* NPM >= 6.x

# Local Setup

* Clone project from repository
```
git clone https://github.com/Nguonchhay/LaravelHero.git local.larahero.host
```

* Change owner
```
cd local.larahero.host
sudo chown -R ${USER}:${USER} .
```

* Run script to set up
```
chmod u+x local_setup/setup.sh
./local_setup/setup.sh
```

__Note1__: Actually, the script is trying to kill all conflict ports but sometimes it could not. So if there are conflict ports, you have to kill it first then rerun the script.
Here is the command to kill the port in Linux: sudo kill $(sudo lsof -t -i:PORT_TO_FREE).

__Note2__: If there is an error about permission deny for adding host, you can manually add `0.0.0.0 local.larahero.host` to file `/etc/hosts`.

* Verify installation by visit `http://local.larahero.host` on the browser

# Useful Commands

* Up local environment
```
chmod u+x local_setup/up.sh
./local_setup/up.sh
```

* SSH to web container
```
chmod u+x local_setup/web_ssh.sh
./local_setup/web_ssh.sh
```

* SSH to database container
```
chmod u+x local_setup/db_ssh.sh
./local_setup/db_ssh.sh
```

# Sample Features
TO BE WRITTEN
