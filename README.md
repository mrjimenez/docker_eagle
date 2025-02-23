# Eagle docker image <!-- omit in toc -->

- [1. What is this](#1-what-is-this)
- [2. Eagle versions](#2-eagle-versions)
- [2. How to use it](#2-how-to-use-it)

## 1. What is this

This is a docker image of the Eagle environment. It runs on an old Ubuntu 18:04 virtual environment and does some virtual maps to ensure a natural usage. The GUI uses X11 to display on the host screen, so it just works as if natively ran.

| Host path      | Guest path                     | Flag |
|----------------|--------------------------------|:----:|
| /tmp/.X11-unix | /tmp/.X11-unix                 |      |
| "$XAUTHORITY"  | /home/ubuntu/.Xauthority       | ro   |
| /etc/localtime | /etc/localtime                 | ro   |
| "$HOME"        | /home/ubuntu/shared            |      |
| "$HOME"/eagle  | /home/ubuntu/eagle             | ro   |
| "$LICENSE_MAC" | "01:ab:23:cd:45:ef"            |      |

The folder `~/eagle` is used to store Xilinx configuration files in the host and in the guest systems, as normal. On the guest, the folder `/home/ubuntu/shared` gives you access to your host's home folder.

## 2. Eagle versions

You can find some of the old eagle versions from 6.6.0 on in the Autodesk site.

[Legacy Software Versions](http://eagle.autodesk.com/eagle/software-versions)

After June 7, 2026, it is unlikely anyone can find a downloadable version of the files.

[Autodesk EAGLE Announcement - Next steps and FAQ](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Autodesk-EAGLE-Announcement-Next-steps-and-FAQ.html)

## 2. How to use it

```bash
# Clone the repo
git clone git@github.com:mrjimenez/docker_eagle.git
cd docker_eagle

# You need a license file to have all the eagle features enabled.
# The license will be asked on the first time you run the container.

# Hard link or copy of the eagle run file.
cp /some/other/path/eagle-lin-6.6.0.run .

# Docker image creation. Do this only once.
./create_image.sh
# Now you have an image that can be pushed to a docker repo.

# Docker container creation. Do this only once.
# Here you will install the license.
./create_container.sh

# After that, just run this command to start ISE
./run_eagle.sh
```
