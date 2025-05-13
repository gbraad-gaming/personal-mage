XMage for private (remote) use
===============================

XMage for personal/private use (rdesktop)

> [!NOTE]
> This image is based on my [gbraad-devenv/fedora](https://github.com/gbraad-devenv/fedora) image, and is therefore personalized;
> it uses  `gbraad` as user with my [dotfiles](https://github.com/gbraad/dotfiles) and tailored to use services exposed by my [homelab](https://github.com/gbraad-homelab) setup.
> For a more generic image, have a look at [spotsnel-gaming/personal-cardforge](https://github.com/spotsnel-gaming/personal-cardforge).


## Usage instructions

```shell
$ podman run -d --name xmage \
   --hostname ${HOSTNAME}-xmage -p 8444:8444 \
   ghcr.io/gbraad-gaming/xmage:latest
```

This allows you to open the remote session from your IP, like
`https://[remote_ip]:8444`. 

Otherwise, you can use tailscale to allow remote use:

```shell
$ podman exec xmage tailscale up
$ podman exec xmage tailscale ip
```

... and then open `https://[tailscale_ip]:8444`

### Devcontainer

A devcontainer is available for testing purposes. While it starts, the kasmvnc server
can not be used on localhost. Preferably the following can be done

As `root`
```
$ tmux new-session -s tailscaled -d
$ tmux send -t tailscaled "tailscaled" ENTER
$ tailscale up
```

and then use another user:
```
$ su - gbraad
$ kasmvncserver
$ tailscale ip
```

... and then open `https://[tailscale_ip]:8444`
