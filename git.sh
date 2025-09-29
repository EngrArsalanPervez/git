# Credentials
git config --global credential.helper store                                    # Store credentials permanently
git config --global user.email "usman.pervez@31c.io"
git config --global user.name "Usman Pervez"

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
meson setup build --wipe -Denable_dpi_qosmos=true -Denable_dpi_pace2=false      # Qosmos
meson setup build --wipe -Denable_dpi_qosmos=false -Denable_dpi_pace2=true      # PACE2
ninja -C build
sudo ./build/project
