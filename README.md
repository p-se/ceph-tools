# Tools around Ceph Development

Mainly used for cleaning up services in `/etc/systemd` and running left-over
`podman` containers from cephadm.

# Dependencies

- libsystemd-dev (for `pystemd` Python package)

## Install Dependencies

```bash
source venv/bin/activate
pip3 install -r requirements.txt
```

## Run

`./ceph-tools --help`

# Install

- `make install`
- Ensure ~/bin is in your \$PATH
