# riodelaplata

_Chuleta_ de la configuración de `riodelaplata` con AWS Linux 2023 y operarlo con Docker.

## Setup

### OS

https://docs.aws.amazon.com/linux/al2023/ug/what-is-amazon-linux.html

```
cat /etc/os-release
```

### Upgrade

https://docs.aws.amazon.com/linux/al2023/ug/managing-repos-os-updates.html

https://docs.aws.amazon.com/linux/al2023/ug/deterministic-upgrades-usage.html#deterministic-upgrade-override-persist

```
echo latest | tee /etc/dnf/vars/releasever
dnf upgrade
```

### Usuario

```
adduser manuel -G wheel
echo "manuel ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-manuel
```

### Hostname

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-hostname.html

```
cp /etc/cloud/cloud.cfg /etc/cloud/cloud.cfg.orig
```

En `/etc/cloud/cloud.cfg`:

```
preserve_hostname: true
```

```
hostnamectl set-hostname riodelaplata.rabade.net
reboot
```

### Timezone

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html

```
timedatectl set-timezone Mexico/General
```

## Docker

https://medium.com/@srijaanaparthy/step-by-step-guide-to-install-docker-on-amazon-linux-machine-in-aws-a690bf44b5fe


```
dnf install docker
systemctl start docker
docker run hello-world
systemctl enable docker
usermod -a -G docker manuel
```

### Contextos

https://www.docker.com/blog/how-to-deploy-on-remote-docker-hosts-with-docker-compose/

```
docker context create riodelaplata --docker "host=ssh://manuel@riodelaplata.rabade.net"
docker context ls
```

## Contenedores

En local:

```
docker compose up -d
```

En `riodelaplata`:

```
docker context use riodelaplata
docker compose -f docker-compose.yml -f docker-compose.prod.yml up
```
