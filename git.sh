# Credentials
git config --global credential.helper store                                    # Store credentials permanently

git config --global user.email "usman.pervez10@gmail.com"
git config --global user.name "EngrArsalanPervez"

git config --global user.email "Usman.Pervez@31c.io"
git config --global user.name "Usman Pervez"
ssh -T git@git.corp.31c.io

git config --global diff.tool meld

# Status
git status
git logs

# Fetch all Branches
git fetch --all                                                                 # To fetch all branches
git fetch origin                                                                # To fetch from a specific remote
git pull                                                                        # To pull the latest changes from the current branch

# View Branches
git branch -a                                                                   # To list all local and remote branches
git branch -r                                                                   # To list all remote branches
git branch                                                                      # To list all local branches

# Delete Local Branches
git branch | grep -v "^\*" | xargs git branch -D                                # delete all local branches
git branch -d branch_name                                                       # To delete a local branch

# Git switch to the local branch
git switch dev

# Git switch to the remote branch
git switch -c dev remotes/origin/dev

# Delete all local changes
git reset --hard && git clean -fd

# Delete everything local. Sync with remote
git fetch origin
git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
git clean -fd
git clean -fdx



# Git checkout to a specific commit
git checkout a1b2c3d

# Git New Branch
git switch -c dev remotes/origin/dev                                            # Create a local branch based on the remote branch
git pull                                                                        # Pull the latest changes from that branch
git switch -c feature/qosmos                                                    # Create a new branch for your changes
git add .                                                                       # Stage all changes
git commit -m "Your commit message for qosmos changes"                          # Commit your changes
git push -u origin feature/qosmos                                               # Push the new branch and set upstream
git push
git pull

# View the difference between the current branch and the remote branch
git diff --name-only dev remotes/origin/qosmos                                  # List files that differ between the two branches
git diff dev..feature/qosmos                                                    # View the difference between two branches
git log origin/feature/dpi-iface..feature/qosmos --oneline                      # View the commit history between two branches


# Push Updates
git add .                                                                       # Stage all changes
git commit -m "Your commit message"                                             # Commit your changes
git push                                                                        # Push changes to the current branch


#############################################Rebase (Always done on local branches)#######################################  
git switch feature/qosmos                                                       # Switch to your feature branch
git fetch origin                                                                # Fetch the latest changes from the remote
git fetch --all                                                                 # Fetch all branches from all remotes

git switch -c dev origin/dev                                                    # Create and switch to a local branch based on the remote dev branch
git pull                                                                        # Pull the latest changes from the remote dev branch

git switch feature/qosmos                                                       # Switch back to your feature branch

CTRL+SHIFT+P => Command Pallet => Git: Rebase Branch…                           # Vscode
Select dev                                                                      # Local branch and NOT origin/dev becase we are rewriting local history

Left side (yours) = features/qosmos                                             # Merge/Rebase editor
Right side (theirs) = dev

# Accept All Incoming Changes (theirs)
Then Go to Result Pane
it should be like
Incoming | Remove Incoming

# Abort
CTRL+SHIFT+P => Command Pallet => Git: Abort Rebase

# Reset after abort
git reset --hard origin/feature/qosmos

# Accept theirs
git checkout --theirs -- path/to/file
git add path/to/file
git rebase --continue
##########################################################################################################################

# Git Large File Storage (LFS)
apt get install git-lfs
git lfs install
git lfs pull
git lfs ls-files


# project
echo 1024 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
rm -rf build/
sudo apt install libpq-dev
sudo apt install libprotobuf-c-dev protobuf-c-compiler
sudo ./container/install_pace2.sh dev
sudo ./container/install_qosmos.sh dev
export LD_LIBRARY_PATH=/usr/lib:/usr/lib/dpdk/pmds-25.0:/usr/local/lib/pace2/lib:/usr/local/lib/qosmos/:/usr/local/lib:$LD_LIBRARY_PATH # Arch
meson setup build --wipe -Denable_dpi_qosmos=true -Denable_dpi_pace2=false      # Qosmos
meson setup build --wipe -Denable_dpi_qosmos=false -Denable_dpi_pace2=true      # PACE2
meson setup build --wipe -Denable_dpi_qosmos=false -Denable_dpi_pace2=true -Dwerror=false # PACE2
ninja -C build
sudo ./build/project
sudo LD_LIBRARY_PATH=/usr/local/lib ./build/project # Arch

# Submodules
git submodule update --init --recursive
Username: usmanpervez
Password: <company email>


# Clear git user settings
# List
git config --global --list
# Unsed
git config --global --unset user.name
git config --global --unset user.email
rm ~/.gitconfig
# Set
git config --global user.email "Usman.Pervez@31c.io"
git config --global user.name "Usman Pervez"
ssh -T git@git.corp.31c.io
# Passphrase
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519


# Final push after rebase when vscode is all done
git push --force-with-lease

# Docker Build
echo "username:token" > git_auth.txt
sudo docker build --secret id=GIT_AUTH,src=git_auth.txt -t my_docker_image:1.0 .

################################################################################################################
# Saldom Live Server
Step1:
cd /opt/saldem
vim docker-compose.yml
# Add tty: true in dpi:
dpi:
stop_grace_period: 0.1s
restart: unless-stopped
privileged: true
tty: true

Step2:
vim dpi-image/entrypoint.sh
#comment last command and add a new command

# Launch DXI
# exec ./build/dxi -c /etc/dxi.conf
exec /bin/bash

Step3:
docker compose down dpi
docker compose build dpi
docker compose build dpi --no-cache
docker compose up -d dpi

Step4:
lshw -c net -businfo
pci@0000:00:14.0 network 82574L Gigabit Network Connection
pci@0000:00:16.0 network 82574L Gigabit Network Connection

Step5:
apt install vim
vim /etc/dxi.conf

[dpdk_args]
l = 0-1
iova-mode = pa
file-prefix = dxi
a = 0000:00:14.0
a = 0000:00:16.0

# [vdev0]
# driver = net_pcap0
# rx_pcap=test/input.pcap

# [vdev1]
# driver = net_pcap1
# tx_pcap=/dev/null
a = 0000:06:10.0
a = 0000:06:10.1

Step6:
ninja -C build
./build/dxi -c /etc/dxi.conf
################################################################################################################
